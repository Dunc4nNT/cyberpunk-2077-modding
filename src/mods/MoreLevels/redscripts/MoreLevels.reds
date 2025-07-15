module NeverToxic.MoreLevels

class MoreLevelsService extends ScriptableService {
    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.displayName", "Maximum Player Level")
    @runtimeProperty("ModSettings.description", "Set the maximum player level.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "60")
    @runtimeProperty("ModSettings.max", "200")
    let maxLevel: Int32 = 79;

    private cb func OnInitialize() {
        ModSettings.RegisterListenerToClass(this);
		ModSettings.RegisterListenerToModifications(this);
        this.SetMaxPlayerLevel();
    }

    public func SetMaxPlayerLevel() {
        TweakDBManager.SetFlat(t"Proficiencies.Level.maxLevel", this.maxLevel);
        TweakDBManager.UpdateRecord(t"Proficiencies.Level");

        TweakDBManager.SetFlat(t"LootPrereqs.BelowMaxPlayerLevelPrereq.valueToCheck", this.maxLevel);
        TweakDBManager.UpdateRecord(t"LootPrereqs.BelowMaxPlayerLevelPrereq");

        TweakDBManager.SetFlat(t"LootPrereqs.CyberpsychoWeaponInLootPrereq_end_inline1.valueToCheck", this.maxLevel);
        TweakDBManager.UpdateRecord(t"LootPrereqs.CyberpsychoWeaponInLootPrereq_end_inline1");

        TweakDBManager.SetFlat(t"LootPrereqs.LegendaryCWLevelAvailabilityAtVendor_inline1.valueToCheck", this.maxLevel);
        TweakDBManager.UpdateRecord(t"LootPrereqs.LegendaryCWLevelAvailabilityAtVendor_inline1");

        TweakDBManager.SetFlat(t"LootPrereqs.MaxPlayerLevelPrereq.valueToCheck", this.maxLevel);
        TweakDBManager.UpdateRecord(t"LootPrereqs.MaxPlayerLevelPrereq");
    }

    public func OnModSettingsChange() {
        this.SetMaxPlayerLevel();
    }
}
