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

    public func GetDoScaleCyberwareCapacity() -> Bool {
        return this.doScaleCyberwareCapacity;
    }

    private cb func OnInitialize() -> Void {
        this.originalMaxCwCap = FromVariant<Float>(TweakDBInterface.GetFlat(t"BaseStats.Humanity.max"));

        ModSettings.RegisterListenerToClass(this);
		ModSettings.RegisterListenerToModifications(this);
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

    public func SetMaxCyberWareCapacity() -> Void {
        let event = new UpdateMaxCapacityPossibleEvent();
        GameInstance.GetUISystem(GetGameInstance()).QueueEvent(event);

        let newMax: Float = this.originalMaxCwCap + Cast<Float>((this.GetMaxLevel() - 60) * 3);

        TweakDBManager.SetFlat(t"BaseStats.Humanity.max", newMax);
        TweakDBManager.UpdateRecord(t"BaseStats.Humanity");
    }

    public func OnModSettingsChange() -> Void {
        this.UpdateSettings();
    }

    public func UpdateSettings() -> Void {
        this.SetMaxPlayerLevel();

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
