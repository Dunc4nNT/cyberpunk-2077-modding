module NeverToxic.MoreLevels

public class MoreLevelsService extends ScriptableService {
    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.displayName", "Maximum Player Level")
    @runtimeProperty("ModSettings.description", "Set the maximum player level.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "60")
    @runtimeProperty("ModSettings.max", "200")
    let maxLevel: Int32 = 79;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.displayName", "Scale Cyberware Capacity")
    @runtimeProperty("ModSettings.description", "Scales the maximum cyberware capacity with the increased levels, meaning you get three (unless otherwise configured) extra points per level above 60.")
    let doScaleCyberwareCapacity: Bool = true;

    let originalMaxCwCap: Float;

    private cb func OnInitialize() -> Void {
        this.originalMaxCwCap = FromVariant<Float>(TweakDBInterface.GetFlat(t"BaseStats.Humanity.max"));

        ModSettings.RegisterListenerToClass(this);
		ModSettings.RegisterListenerToModifications(this);
        this.UpdateSettings();
    }

    public func SetMaxPlayerLevel() -> Void {
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

    public func SetMaxCyberWareCapacity() -> Void {
        let event = new UpdateMaxCapacityPossibleEvent();
        GameInstance.GetUISystem(GetGameInstance()).QueueEvent(event);

        let newMax: Float = this.originalMaxCwCap + Cast<Float>((this.maxLevel - 60) * 3);

        TweakDBManager.SetFlat(t"BaseStats.Humanity.max", newMax);
        TweakDBManager.UpdateRecord(t"BaseStats.Humanity");
    }

    public func OnModSettingsChange() -> Void {
        this.UpdateSettings();
    }

    public func UpdateSettings() -> Void {
        this.SetMaxPlayerLevel();

        if this.doScaleCyberwareCapacity {
            this.SetMaxCyberWareCapacity();
        }
    }
}

public class UpdateMaxCapacityPossibleEvent extends Event {

}

@wrapMethod(RipperDocGameController)
private final func GetMaxCapacityPossible() -> Float {
    let max: Float = wrappedMethod();
    let moreLevelsService: ref<MoreLevelsService> = GameInstance.GetScriptableServiceContainer().GetService(n"NeverToxic.MoreLevels.MoreLevelsService") as MoreLevelsService;

    if moreLevelsService.doScaleCyberwareCapacity {
        max += Cast<Float>((moreLevelsService.maxLevel - 60) * 3);
    }

    return max;
}

@addMethod(RipperDocGameController)
protected cb func OnUpdateMaxCapacityPossibleEvent(event: ref<UpdateMaxCapacityPossibleEvent>) -> Bool {
    this.m_maxCapacityPossible = this.GetMaxCapacityPossible();

    return true;
}
