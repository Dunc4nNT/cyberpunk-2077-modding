module NeverToxic.MoreLevels

public class MoreLevelsService extends ScriptableService {
    let settings: ref<MoreLevelsSettings>;

    let originalMaxCwCap: Float;

    private cb func OnLoad() {
        this.settings = new MoreLevelsSettings();
        RegisterModSettings(this);

        GameInstance
            .GetCallbackSystem()
            .RegisterCallback(n"Resource/Ready", this, n"OnCurveReady")
            .AddTarget(ResourceTarget.Path(r"base\\gameplay\\curves\\statcurves\\player\\player_level_up_curve.curveset"));
    }

    private cb func OnInitialize() -> Void {
        this.originalMaxCwCap = FromVariant<Float>(TweakDBInterface.GetFlat(t"BaseStats.Humanity.max"));

        this.UpdateSettings();
    }

    public func OnModSettingsChange() -> Void {
        this.settings = new MoreLevelsSettings();
        this.UpdateSettings();
    }

    public func UpdateSettings() -> Void {
        this.SetMaxPlayerLevel();
        this.SetPlayerLevelCurve();
        this.SetMaxStreetCredLevel();
        this.SetStreetCredLevelCurve();
        this.SetCyberwareCapacityPerLevel();
        this.SetMaxCyberwareCapacity();
    }

    private cb func OnCurveReady(event: ref<ResourceEvent>) {
        let curveset = event.GetResource() as CurveSet;

        if IsDefined(curveset) {
            ArrayPush(curveset.curves, this.CreateLevelCurveStandardScaled(79, n"nevertoxic_morelevels_xp_per_level_standard_79"));
            ArrayPush(curveset.curves, this.CreateLevelCurveStandardScaled(80, n"nevertoxic_morelevels_xp_per_level_standard_80"));
            ArrayPush(curveset.curves, this.CreateLevelCurveStandardScaled(100, n"nevertoxic_morelevels_xp_per_level_standard_100"));
            ArrayPush(curveset.curves, this.CreateLevelCurveStandardScaled(200, n"nevertoxic_morelevels_xp_per_level_standard_200"));
        }
    }

    private func CreateLevelCurveStandardScaled(limit: Int32, name: CName) -> CurveSetEntry {
        let entry: CurveSetEntry;
        entry.name = name;

        CurveDataFloat.SetSize(entry.curve, Cast<Uint32>(limit));

        let i: Int32 = 0;
        while i < limit {
            let idx: Uint32 = Cast<Uint32>(i);
            CurveDataFloat.SetPointValue(entry.curve, idx, Cast<Float>(i + 1), this.GetLevelCurveValueAt(i + 1));

            i += 1;
        }

        return entry;
    }

    // Formula for vanilla level curve.
    // Might be off by 1 xp due to rounding error.
    private func GetLevelCurveValueAt(num: Int32) -> Float {
        if num == 1 {
            return 0.0;
        }

        let euler: Float = 2.718281828459045;
        let result: Float = (2.90699 * PowF(10, 9)) / (1.0 + PowF(euler, -(0.0399177 * Cast<Float>(num) - 14.96278)));

        return Cast<Float>(RoundF(result));
    }

    public func SetMaxPlayerLevel() -> Void {
        let maxLevel: Int32 = this.settings.GetMaxLevel();

        TweakDBManager.SetFlat(t"Proficiencies.Level.maxLevel", maxLevel);
        TweakDBManager.UpdateRecord(t"Proficiencies.Level");

        TweakDBManager.SetFlat(t"LootPrereqs.BelowMaxPlayerLevelPrereq.valueToCheck", Cast<Float>(maxLevel));
        TweakDBManager.UpdateRecord(t"LootPrereqs.BelowMaxPlayerLevelPrereq");

        TweakDBManager.SetFlat(t"LootPrereqs.CyberpsychoWeaponInLootPrereq_end_inline1.valueToCheck", Cast<Float>(maxLevel));
        TweakDBManager.UpdateRecord(t"LootPrereqs.CyberpsychoWeaponInLootPrereq_end_inline1");

        TweakDBManager.SetFlat(t"LootPrereqs.LegendaryCWLevelAvailabilityAtVendor_inline1.valueToCheck", Cast<Float>(maxLevel));
        TweakDBManager.UpdateRecord(t"LootPrereqs.LegendaryCWLevelAvailabilityAtVendor_inline1");

        TweakDBManager.SetFlat(t"LootPrereqs.MaxPlayerLevelPrereq.valueToCheck", Cast<Float>(maxLevel));
        TweakDBManager.UpdateRecord(t"LootPrereqs.MaxPlayerLevelPrereq");
    }

    public func SetMaxStreetCredLevel() -> Void {
        let maxLevel: Int32 = this.settings.GetMaxStreetCredLevel();

        TweakDBManager.SetFlat(t"BaseStats.StreetCred.max", maxLevel);
        TweakDBManager.UpdateRecord(t"BaseStats.StreetCred");

        TweakDBManager.SetFlat(t"Proficiencies.StreetCred.maxLevel", maxLevel);
        TweakDBManager.UpdateRecord(t"Proficiencies.StreetCred");
    }

    public func SetCyberwareCapacityPerLevel() -> Void {
        let capPerLevel = this.settings.GetCyberwareCapacityPerLevel();

        TweakDBManager.SetFlat(t"Character.PlayerCyberwareSystem_inline11.value", Cast<Float>(capPerLevel));
        TweakDBManager.UpdateRecord(t"Character.PlayerCyberwareSystem_inline11");
    }

    public func SetMaxCyberwareCapacity() -> Void {
        let event = new UpdateMaxCapacityPossibleEvent();
        GameInstance.GetUISystem(GetGameInstance()).QueueEvent(event);

        let newMax: Float = this.originalMaxCwCap;
        newMax += this.CalculateMaxCyberwareExtra();

        TweakDBManager.SetFlat(t"BaseStats.Humanity.max", newMax);
        TweakDBManager.UpdateRecord(t"BaseStats.Humanity");
    }

    public func CalculateMaxCyberwareExtra() -> Float {
        let extraCw: Float = 0.0;
        let cwPerLevel: Float = FromVariant<Float>(TweakDBInterface.GetFlat(t"Character.PlayerCyberwareSystem_inline11.value"));

        if this.settings.GetDoScaleCyberwareCapacity() {
            extraCw += Cast<Float>((this.settings.GetMaxLevel() - 60)) * cwPerLevel;
        }

        if cwPerLevel > 3.0 {
            extraCw += 60.0 * (cwPerLevel - 3.0);
        }

        return extraCw;
    }

    public func SetPlayerLevelCurve() -> Void {
        this.SetAlternativeLevelCurve(
            t"Proficiencies.Level.curveName",
            t"Proficiencies.Level",
            this.settings.GetPlayerLevelXpCurve()
        );
    }

    public func SetStreetCredLevelCurve() -> Void {
        this.SetAlternativeLevelCurve(
            t"Proficiencies.StreetCred.curveName",
            t"Proficiencies.StreetCred",
            this.settings.GetStreetCredLevelXpCurve()
        );
    }

    private func SetAlternativeLevelCurve(
        tweakDBID: TweakDBID,
        tweakDBRec: TweakDBID,
        curveType: CustomLevelCurveType
    ) -> Void {
        let curveName: CName;

        switch curveType {
            case CustomLevelCurveType.ScaleTo79:
                curveName= n"nevertoxic_morelevels_xp_per_level_standard_79";
                break;
            case CustomLevelCurveType.ScaleTo80:
                curveName = n"nevertoxic_morelevels_xp_per_level_standard_80";
                break;
            case CustomLevelCurveType.ScaleTo100:
                curveName = n"nevertoxic_morelevels_xp_per_level_standard_100";
                break;
            case CustomLevelCurveType.ScaleTo200:
                curveName = n"nevertoxic_morelevels_xp_per_level_standard_200";
                break;
            default:
                curveName = n"player_primary_level_to_xp";
                break;
        }

        TweakDBManager.SetFlat(tweakDBID, curveName);
        TweakDBManager.UpdateRecord(tweakDBRec);
    }

    public func GetXpMultiplier(type: gamedataProficiencyType) -> Float {
        switch type {
            case gamedataProficiencyType.Level:
                return this.settings.GetLevelXpMultiplier();
            case gamedataProficiencyType.StreetCred:
                return this.settings.GetStreetCredXpMultiplier();
            case gamedataProficiencyType.CoolSkill:
                return this.settings.GetHeadhunterXpMultiplier();
            case gamedataProficiencyType.IntelligenceSkill:
                return this.settings.GetNetrunnerXpMultiplier();
            case gamedataProficiencyType.ReflexesSkill:
                return this.settings.GetShinobiXpMultiplier();
            case gamedataProficiencyType.StrengthSkill:
                return this.settings.GetSoloXpMultiplier();
            case gamedataProficiencyType.TechnicalAbilitySkill:
                return this.settings.GetEngineerXpMultiplier();
            default:
                return 1.0;
        }
    }
}

enum CustomLevelCurveType {
    None = 0,
    ScaleTo79 = 1,
    ScaleTo80 = 2,
    ScaleTo100 = 3,
    ScaleTo200 = 4,
}

public class UpdateMaxCapacityPossibleEvent extends Event {

}
