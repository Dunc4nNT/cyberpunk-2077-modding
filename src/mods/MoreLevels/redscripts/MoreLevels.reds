module NeverToxic.MoreLevels

public class MoreLevelsService extends ScriptableService {
    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.category", "General")
    @runtimeProperty("ModSettings.displayName", "Maximum Player Level")
    @runtimeProperty("ModSettings.description", "Set the maximum player level.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "60")
    @runtimeProperty("ModSettings.max", "200")
    let maxLevel: Int32 = 79;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.category", "General")
    @runtimeProperty("ModSettings.displayName", "Maximum StreetCred Level")
    @runtimeProperty("ModSettings.description", "Set the maximum StreetCred level.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "50")
    @runtimeProperty("ModSettings.max", "200")
    let maxStreetCredLevel: Int32 = 100;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.category", "General")
    @runtimeProperty("ModSettings.displayName", "Player Level XP Curve")
    @runtimeProperty("ModSettings.description", "Set the XP curve to use for player level. Alternative scales up to level 79, after which it flattens. Vanilla uses the vanilla curve.")
    @runtimeProperty("ModSettings.displayValues.None", "Vanilla")
    @runtimeProperty("ModSettings.displayValues.Custom1", "Alternative")
    let playerLevelXpCurve: CustomLevelCurveType = CustomLevelCurveType.Custom1;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.category", "General")
    @runtimeProperty("ModSettings.displayName", "StreetCred Level XP Curve")
    @runtimeProperty("ModSettings.description", "Set the XP curve to use for StreetCred level. Alternative scales up to level 79, after which it flattens. Vanilla uses the vanilla curve.")
    @runtimeProperty("ModSettings.displayValues.None", "Vanilla")
    @runtimeProperty("ModSettings.displayValues.Custom1", "Alternative")
    let streetCredLevelXpCurve: CustomLevelCurveType = CustomLevelCurveType.Custom1;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.category", "General")
    @runtimeProperty("ModSettings.displayName", "Scale Cyberware Capacity")
    @runtimeProperty("ModSettings.description", "Scales the maximum cyberware capacity with the increased levels, meaning you get three (unless otherwise configured) extra points per level above 60.")
    let doScaleCyberwareCapacity: Bool = true;

    let originalMaxCwCap: Float;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.category", "XP Multipliers")
    @runtimeProperty("ModSettings.displayName", "Character Level")
    @runtimeProperty("ModSettings.description", "Set the amount character XP should be multiplied by.")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.5")
    @runtimeProperty("ModSettings.max", "5.0")
    let levelXpMultiplier: Float = 1.0;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.category", "XP Multipliers")
    @runtimeProperty("ModSettings.displayName", "StreedCred Level")
    @runtimeProperty("ModSettings.description", "Set the amount streetcred XP should be multiplied by.")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.5")
    @runtimeProperty("ModSettings.max", "5.0")
    let streetCredXpMultiplier: Float = 1.0;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.category", "XP Multipliers")
    @runtimeProperty("ModSettings.displayName", "Headhunter")
    @runtimeProperty("ModSettings.description", "Set the amount headhunter XP should be multiplied by.")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.5")
    @runtimeProperty("ModSettings.max", "5.0")
    let headhunterXpMultiplier: Float = 1.0;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.category", "XP Multipliers")
    @runtimeProperty("ModSettings.displayName", "Netrunner")
    @runtimeProperty("ModSettings.description", "Set the amount netrunner XP should be multiplied by.")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.5")
    @runtimeProperty("ModSettings.max", "5.0")
    let netrunnerXpMultiplier: Float = 1.0;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.category", "XP Multipliers")
    @runtimeProperty("ModSettings.displayName", "Shinobi")
    @runtimeProperty("ModSettings.description", "Set the amount shinobi XP should be multiplied by.")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.5")
    @runtimeProperty("ModSettings.max", "5.0")
    let shinobiXpMultiplier: Float = 1.0;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.category", "XP Multipliers")
    @runtimeProperty("ModSettings.displayName", "Solo")
    @runtimeProperty("ModSettings.description", "Set the amount solo XP should be multiplied by.")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.5")
    @runtimeProperty("ModSettings.max", "5.0")
    let soloXpMultiplier: Float = 1.0;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.category", "XP Multipliers")
    @runtimeProperty("ModSettings.displayName", "Engineer")
    @runtimeProperty("ModSettings.description", "Set the amount engineer XP should be multiplied by.")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.5")
    @runtimeProperty("ModSettings.max", "5.0")
    let engineerXpMultiplier: Float = 1.0;

    public func GetMaxLevel() -> Int32 {
        return this.maxLevel;
    }

    public func GetMaxStreetCredLevel() -> Int32 {
        return this.maxStreetCredLevel;
    }

    public func GetDoScaleCyberwareCapacity() -> Bool {
        return this.doScaleCyberwareCapacity;
    }

    public func GetPlayerLevelXpCurve() -> CustomLevelCurveType {
        return this.playerLevelXpCurve;
    }

    public func GetStreetCredLevelXpCurve() -> CustomLevelCurveType {
        return this.streetCredLevelXpCurve;
    }

    private cb func OnLoad() {
        GameInstance
            .GetCallbackSystem()
            .RegisterCallback(n"Resource/Ready", this, n"OnCurveReady")
            .AddTarget(ResourceTarget.Path(r"base\\gameplay\\curves\\statcurves\\statscurvesset.curveresset"));
    }

    private cb func OnCurveReady(event: ref<ResourceEvent>) {
        let curveset = event.GetResource() as CurveResourceSet;

        if IsDefined(curveset) {
            let entry: CurveResourceSetEntry;
            entry.name = n"morelevels_player_level_up_curve";

            let resRef: ResRef = ResRef.FromName(n"base\\gameplay\\curves\\statcurves\\player\\morelevels_player_level_up_curve.curveset");
            entry.curveResRef = ResourceRef.FromPath(resRef);

            ArrayPush(curveset.curveResources, entry);
        }
    }

    private cb func OnInitialize() -> Void {
        this.originalMaxCwCap = FromVariant<Float>(TweakDBInterface.GetFlat(t"BaseStats.Humanity.max"));
        
        RegisterModSettings(this);
        this.UpdateSettings();
    }

    public func SetMaxPlayerLevel() -> Void {
        TweakDBManager.SetFlat(t"Proficiencies.Level.maxLevel", this.GetMaxLevel());
        TweakDBManager.UpdateRecord(t"Proficiencies.Level");

        TweakDBManager.SetFlat(t"LootPrereqs.BelowMaxPlayerLevelPrereq.valueToCheck", Cast<Float>(this.GetMaxLevel()));
        TweakDBManager.UpdateRecord(t"LootPrereqs.BelowMaxPlayerLevelPrereq");

        TweakDBManager.SetFlat(t"LootPrereqs.CyberpsychoWeaponInLootPrereq_end_inline1.valueToCheck", Cast<Float>(this.GetMaxLevel()));
        TweakDBManager.UpdateRecord(t"LootPrereqs.CyberpsychoWeaponInLootPrereq_end_inline1");

        TweakDBManager.SetFlat(t"LootPrereqs.LegendaryCWLevelAvailabilityAtVendor_inline1.valueToCheck", Cast<Float>(this.GetMaxLevel()));
        TweakDBManager.UpdateRecord(t"LootPrereqs.LegendaryCWLevelAvailabilityAtVendor_inline1");

        TweakDBManager.SetFlat(t"LootPrereqs.MaxPlayerLevelPrereq.valueToCheck", Cast<Float>(this.GetMaxLevel()));
        TweakDBManager.UpdateRecord(t"LootPrereqs.MaxPlayerLevelPrereq");
    }

    public func SetMaxStreetCredLevel() -> Void {
        TweakDBManager.SetFlat(t"BaseStats.StreetCred.max", this.GetMaxStreetCredLevel());
        TweakDBManager.UpdateRecord(t"BaseStats.StreetCred");

        TweakDBManager.SetFlat(t"Proficiencies.StreetCred.maxLevel", this.GetMaxStreetCredLevel());
        TweakDBManager.UpdateRecord(t"Proficiencies.StreetCred");
    }

    public func SetMaxCyberWareCapacity() -> Void {
        let event = new UpdateMaxCapacityPossibleEvent();
        GameInstance.GetUISystem(GetGameInstance()).QueueEvent(event);

        let newMax: Float = this.originalMaxCwCap + Cast<Float>((this.GetMaxLevel() - 60) * 3);

        TweakDBManager.SetFlat(t"BaseStats.Humanity.max", newMax);
        TweakDBManager.UpdateRecord(t"BaseStats.Humanity");
    }

    public func SetPlayerLevelCurve() -> Void {
        switch this.GetPlayerLevelXpCurve() {
            case CustomLevelCurveType.Custom1:
                TweakDBManager.SetFlat(t"Proficiencies.Level.curveSetName", n"morelevels_player_level_up_curve");
                TweakDBManager.UpdateRecord(t"Proficiencies.Level");
                return;
            default:
                TweakDBManager.SetFlat(t"Proficiencies.Level.curveSetName", n"player_level_up_curve");
                TweakDBManager.UpdateRecord(t"Proficiencies.Level");
                return;
        }
    }

    public func SetStreetCredLevelCurve() -> Void {
        switch this.GetStreetCredLevelXpCurve() {
            case CustomLevelCurveType.Custom1:
                TweakDBManager.SetFlat(t"Proficiencies.StreetCred.curveSetName", n"morelevels_player_level_up_curve");
                TweakDBManager.UpdateRecord(t"Proficiencies.StreetCred");
                return;
            default:
                TweakDBManager.SetFlat(t"Proficiencies.StreetCred.curveSetName", n"player_level_up_curve");
                TweakDBManager.UpdateRecord(t"Proficiencies.StreetCred");
                return;
        }
    }

    public func OnModSettingsChange() -> Void {
        this.UpdateSettings();
    }

    public func UpdateSettings() -> Void {
        this.SetMaxPlayerLevel();
        this.SetPlayerLevelCurve();
        this.SetMaxStreetCredLevel();
        this.SetStreetCredLevelCurve();

        if this.GetDoScaleCyberwareCapacity() {
            this.SetMaxCyberWareCapacity();
        }
    }

    public func GetXpMultiplier(type: gamedataProficiencyType) -> Float {
        switch type {
            case gamedataProficiencyType.Level:
                return this.levelXpMultiplier;
            case gamedataProficiencyType.StreetCred:
                return this.streetCredXpMultiplier;
            case gamedataProficiencyType.CoolSkill:
                return this.headhunterXpMultiplier;
            case gamedataProficiencyType.IntelligenceSkill:
                return this.netrunnerXpMultiplier;
            case gamedataProficiencyType.ReflexesSkill:
                return this.shinobiXpMultiplier;
            case gamedataProficiencyType.StrengthSkill:
                return this.soloXpMultiplier;
            case gamedataProficiencyType.TechnicalAbilitySkill:
                return this.engineerXpMultiplier;
            default:
                return 1.0;
        }
    }
}

enum CustomLevelCurveType {
    None = 0,
    Custom1 = 1,
}

public class UpdateMaxCapacityPossibleEvent extends Event {

}

@wrapMethod(RipperDocGameController)
private final func GetMaxCapacityPossible() -> Float {
    let max: Float = wrappedMethod();
    let moreLevelsService: ref<MoreLevelsService> = GameInstance.GetScriptableServiceContainer().GetService(n"NeverToxic.MoreLevels.MoreLevelsService") as MoreLevelsService;

    if moreLevelsService.GetDoScaleCyberwareCapacity() {
        max += Cast<Float>((moreLevelsService.GetMaxLevel() - 60) * 3);
    }

    return max;
}

@addMethod(RipperDocGameController)
protected cb func OnUpdateMaxCapacityPossibleEvent(event: ref<UpdateMaxCapacityPossibleEvent>) -> Bool {
    this.m_maxCapacityPossible = this.GetMaxCapacityPossible();

    return true;
}

@wrapMethod(PlayerDevelopmentSystem)
private final func OnExperienceAdded(request: ref<AddExperience>) -> Void {
    let moreLevelsService: ref<MoreLevelsService> = GameInstance.GetScriptableServiceContainer().GetService(n"NeverToxic.MoreLevels.MoreLevelsService") as MoreLevelsService;

    let xpFloat: Float = Cast<Float>(request.m_amount);
    let newXp: Float = xpFloat * moreLevelsService.GetXpMultiplier(request.m_experienceType);

    request.m_amount = Cast<Int32>(newXp);

    wrappedMethod(request);
}

@if(ModuleExists("ModSettingsModule"))
public func RegisterModSettings(listener: ref<MoreLevelsService>) -> Void {
    ModSettings.RegisterListenerToClass(listener);
    ModSettings.RegisterListenerToModifications(listener);
}

@if(!ModuleExists("ModSettingsModule"))
public func RegisterModSettings(listener: ref<MoreLevelsService>) -> Void {

}
