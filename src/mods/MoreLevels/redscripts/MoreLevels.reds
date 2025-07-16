module NeverToxic.MoreLevels

class MoreLevelsService extends ScriptableService {
    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.displayName", "Maximum Player Level")
    @runtimeProperty("ModSettings.description", "Set the maximum player level.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "60")
    @runtimeProperty("ModSettings.max", "200")
    let maxLevel: Int32 = 79;

    let originalMaxCwCap: Float;

    private cb func OnInitialize() {
        this.originalMaxCwCap = FromVariant<Float>(TweakDBInterface.GetFlat(t"BaseStats.Humanity.max"));

        ModSettings.RegisterListenerToClass(this);
		ModSettings.RegisterListenerToModifications(this);
        this.SetMaxPlayerLevel();
        this.SetMaxCyberWareCapacity();
    }

    public func SetMaxPlayerLevel() {
        TweakDBManager.SetFlat(t"Proficiencies.Level.maxLevel", this.maxLevel);
        TweakDBManager.UpdateRecord(t"Proficiencies.Level");

        TweakDBManager.SetFlat(t"LootPrereqs.BelowMaxPlayerLevelPrereq.valueToCheck", Cast<Float>(this.maxLevel));
        TweakDBManager.UpdateRecord(t"LootPrereqs.BelowMaxPlayerLevelPrereq");

        TweakDBManager.SetFlat(t"LootPrereqs.CyberpsychoWeaponInLootPrereq_end_inline1.valueToCheck", Cast<Float>(this.maxLevel));
        TweakDBManager.UpdateRecord(t"LootPrereqs.CyberpsychoWeaponInLootPrereq_end_inline1");

        TweakDBManager.SetFlat(t"LootPrereqs.LegendaryCWLevelAvailabilityAtVendor_inline1.valueToCheck", Cast<Float>(this.maxLevel));
        TweakDBManager.UpdateRecord(t"LootPrereqs.LegendaryCWLevelAvailabilityAtVendor_inline1");

        TweakDBManager.SetFlat(t"LootPrereqs.MaxPlayerLevelPrereq.valueToCheck", Cast<Float>(this.maxLevel));
        TweakDBManager.UpdateRecord(t"LootPrereqs.MaxPlayerLevelPrereq");
    }

    public func SetMaxCyberWareCapacity() {
        let ripperDoc = Reflection.GetClass(n"RipperDocGameController") as RipperDocGameController;

        let max: Float = ripperDoc.GetMaxCapacityPossible();
        ripperDoc.m_maxCapacityPossible = max;

        let newMax: Float = this.originalMaxCwCap + Cast<Float>((this.maxLevel - 60) * 3);

        TweakDBManager.SetFlat(t"BaseStats.Humanity.max", newMax);
        TweakDBManager.UpdateRecord(t"BaseStats.Humanity");
    }

    public func OnModSettingsChange() {
        this.SetMaxPlayerLevel();
        this.SetMaxCyberWareCapacity();
    }
}

@wrapMethod(RipperDocGameController)
private final func GetMaxCapacityPossible() -> Float {
    let max: Float = wrappedMethod();
    let moreLevelsService: ref<MoreLevelsService> = GameInstance.GetScriptableServiceContainer().GetService(n"NeverToxic.MoreLevels.MoreLevelsService") as MoreLevelsService;

    max += Cast<Float>((moreLevelsService.maxLevel - 60) * 3);

    return max;
}
