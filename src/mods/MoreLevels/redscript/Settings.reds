module NeverToxic.MoreLevels

public class MoreLevelsSettings {
    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.displayName", "Maximum Player Level")
    @runtimeProperty("ModSettings.description", "Set the maximum player level.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "60")
    @runtimeProperty("ModSettings.max", "200")
    let maxLevel: Int32 = 79;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.displayName", "Maximum StreetCred Level")
    @runtimeProperty("ModSettings.description", "Set the maximum StreetCred level.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "50")
    @runtimeProperty("ModSettings.max", "200")
    let maxStreetCredLevel: Int32 = 100;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.displayName", "Player Level XP Curve")
    @runtimeProperty("ModSettings.description", "Set the XP curve to use for player level. Vanilla uses the vanilla curve. Scale to [num] use vanilla curve, but extend it up to [num].")
    @runtimeProperty("ModSettings.displayValues.None", "Vanilla")
    @runtimeProperty("ModSettings.displayValues.ScaleTo79", "Scale to 79")
    @runtimeProperty("ModSettings.displayValues.ScaleTo80", "Scale to 80")
    @runtimeProperty("ModSettings.displayValues.ScaleTo100", "Scale to 100")
    @runtimeProperty("ModSettings.displayValues.ScaleTo200", "Scale to 200")
    let playerLevelXpCurve: CustomLevelCurveType = CustomLevelCurveType.ScaleTo79;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.displayName", "StreetCred Level XP Curve")
    @runtimeProperty("ModSettings.description", "Set the XP curve to use for StreetCred level. Vanilla uses the vanilla curve. Scale to [num] use vanilla curve, but extend it up to [num].")
    @runtimeProperty("ModSettings.displayValues.None", "Vanilla")
    @runtimeProperty("ModSettings.displayValues.ScaleTo79", "Scale to 79")
    @runtimeProperty("ModSettings.displayValues.ScaleTo80", "Scale to 80")
    @runtimeProperty("ModSettings.displayValues.ScaleTo100", "Scale to 100")
    @runtimeProperty("ModSettings.displayValues.ScaleTo200", "Scale to 200")
    let streetCredLevelXpCurve: CustomLevelCurveType = CustomLevelCurveType.ScaleTo79;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.displayName", "Scale Cyberware Capacity")
    @runtimeProperty("ModSettings.description", "Scales the maximum cyberware capacity with the increased levels, meaning you get three (unless otherwise configured) extra points per level above 60.")
    let doScaleCyberwareCapacity: Bool = true;

    @runtimeProperty("ModSettings.mod", "More Levels")
    @runtimeProperty("ModSettings.displayName", "Cyberware Capacity per Level")
    @runtimeProperty("ModSettings.description", "Amount that cyberware capacity increases per level.")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "0")
    @runtimeProperty("ModSettings.max", "25")
    @runtimeProperty("ModSettings.updatePolicy", "LoadLastCheckpointRequired")
    let cyberwareCapacityPerLevel: Int32 = 3;

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

    public func GetPlayerLevelXpCurve() -> CustomLevelCurveType {
        return this.playerLevelXpCurve;
    }

    public func GetStreetCredLevelXpCurve() -> CustomLevelCurveType {
        return this.streetCredLevelXpCurve;
    }

    public func GetDoScaleCyberwareCapacity() -> Bool {
        return this.doScaleCyberwareCapacity;
    }

    public func GetCyberwareCapacityPerLevel() -> Int32 {
        return this.cyberwareCapacityPerLevel;
    }

    public func GetLevelXpMultiplier() -> Float {
        return this.levelXpMultiplier;
    }

    public func GetStreetCredXpMultiplier() -> Float {
        return this.streetCredXpMultiplier;
    }

    public func GetHeadhunterXpMultiplier() -> Float {
        return this.headhunterXpMultiplier;
    }

    public func GetNetrunnerXpMultiplier() -> Float {
        return this.netrunnerXpMultiplier;
    }

    public func GetShinobiXpMultiplier() -> Float {
        return this.shinobiXpMultiplier;
    }

    public func GetSoloXpMultiplier() -> Float {
        return this.soloXpMultiplier;
    }

    public func GetEngineerXpMultiplier() -> Float {
        return this.engineerXpMultiplier;
    }
}

@if(ModuleExists("ModSettingsModule"))
public func RegisterModSettings(listener: ref<IScriptable>) -> Void {
    ModSettings.RegisterListenerToModifications(listener);
}

@if(!ModuleExists("ModSettingsModule"))
public func RegisterModSettings(listener: ref<IScriptable>) -> Void {

}
