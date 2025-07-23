module NeverToxic.MoreLevels

public class MoreLevelsSettings {
    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-MaxPlayerLevel-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-MaxPlayerLevel-Description")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "60")
    @runtimeProperty("ModSettings.max", "200")
    let maxLevel: Int32 = 79;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-MaxStreetCredLevel-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-MaxStreetCredLevel-Description")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "50")
    @runtimeProperty("ModSettings.max", "200")
    let maxStreetCredLevel: Int32 = 100;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-PlayerLevelXpCurve-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-PlayerLevelXpCurve-Description")
    @runtimeProperty("ModSettings.displayValues.None", "NeverToxic-MoreLevels-Enums-CustomLevelCurveType-None")
    @runtimeProperty("ModSettings.displayValues.ScaleTo79", "NeverToxic-MoreLevels-Enums-CustomLevelCurveType-ScaleTo79")
    @runtimeProperty("ModSettings.displayValues.ScaleTo80", "NeverToxic-MoreLevels-Enums-CustomLevelCurveType-ScaleTo80")
    @runtimeProperty("ModSettings.displayValues.ScaleTo100", "NeverToxic-MoreLevels-Enums-CustomLevelCurveType-ScaleTo100")
    @runtimeProperty("ModSettings.displayValues.ScaleTo200", "NeverToxic-MoreLevels-Enums-CustomLevelCurveType-ScaleTo200")
    let playerLevelXpCurve: CustomLevelCurveType = CustomLevelCurveType.ScaleTo79;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-StreetCredLevelXpCurve-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-StreetCredLevelXpCurve-Description")
    @runtimeProperty("ModSettings.displayValues.None", "NeverToxic-MoreLevels-Enums-CustomLevelCurveType-None")
    @runtimeProperty("ModSettings.displayValues.ScaleTo79", "NeverToxic-MoreLevels-Enums-CustomLevelCurveType-ScaleTo79")
    @runtimeProperty("ModSettings.displayValues.ScaleTo80", "NeverToxic-MoreLevels-Enums-CustomLevelCurveType-ScaleTo80")
    @runtimeProperty("ModSettings.displayValues.ScaleTo100", "NeverToxic-MoreLevels-Enums-CustomLevelCurveType-ScaleTo100")
    @runtimeProperty("ModSettings.displayValues.ScaleTo200", "NeverToxic-MoreLevels-Enums-CustomLevelCurveType-ScaleTo200")
    let streetCredLevelXpCurve: CustomLevelCurveType = CustomLevelCurveType.ScaleTo100;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.category", "NeverToxic-MoreLevels-Settings-Cyberware-CategoryName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-Cyberware-ScaleCwCap-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-Cyberware-ScaleCwCap-Description")
    let doScaleCyberwareCapacity: Bool = true;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.category", "NeverToxic-MoreLevels-Settings-Cyberware-CategoryName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-Cyberware-UseCustomCwCapPerLevel-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-Cyberware-UseCustomCwCapPerLevel-Description")
    @runtimeProperty("ModSettings.updatePolicy", "RestartRequired")
    let doUseCustomCyberwareCapacityPerLevel: Bool = true;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.category", "NeverToxic-MoreLevels-Settings-Cyberware-CategoryName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-Cyberware-CwCapPerLevel-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-Cyberware-CwCapPerLevel-Description")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "0")
    @runtimeProperty("ModSettings.max", "25")
    @runtimeProperty("ModSettings.updatePolicy", "LoadLastCheckpointRequired")
    @runtimeProperty("ModSettings.dependency", "doUseCustomCyberwareCapacityPerLevel")
    let cyberwareCapacityPerLevel: Int32 = 3;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.category", "NeverToxic-MoreLevels-Settings-XpMultipliers-CategoryName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-XpMultipliers-Toggle-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-XpMultipliers-Toggle-Description")
    let doEnableXpMultipliers: Bool = true;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.category", "NeverToxic-MoreLevels-Settings-XpMultipliers-CategoryName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-XpMultipliers-CharacterLevel-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-XpMultipliers-CharacterLevel-Description")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.05")
    @runtimeProperty("ModSettings.max", "5.0")
    @runtimeProperty("ModSettings.dependency", "doEnableXpMultipliers")
    let levelXpMultiplier: Float = 1.0;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.category", "NeverToxic-MoreLevels-Settings-XpMultipliers-CategoryName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-XpMultipliers-StreetCred-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-XpMultipliers-StreetCred-Description")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.05")
    @runtimeProperty("ModSettings.max", "5.0")
    @runtimeProperty("ModSettings.dependency", "doEnableXpMultipliers")
    let streetCredXpMultiplier: Float = 1.0;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.category", "NeverToxic-MoreLevels-Settings-XpMultipliers-CategoryName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-XpMultipliers-Headhunter-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-XpMultipliers-Headhunter-Description")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.05")
    @runtimeProperty("ModSettings.max", "5.0")
    @runtimeProperty("ModSettings.dependency", "doEnableXpMultipliers")
    let headhunterXpMultiplier: Float = 1.0;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.category", "NeverToxic-MoreLevels-Settings-XpMultipliers-CategoryName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-XpMultipliers-Netrunner-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-XpMultipliers-Netrunner-Description")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.05")
    @runtimeProperty("ModSettings.max", "5.0")
    @runtimeProperty("ModSettings.dependency", "doEnableXpMultipliers")
    let netrunnerXpMultiplier: Float = 1.0;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.category", "NeverToxic-MoreLevels-Settings-XpMultipliers-CategoryName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-XpMultipliers-Shinobi-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-XpMultipliers-Shinobi-Description")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.05")
    @runtimeProperty("ModSettings.max", "5.0")
    @runtimeProperty("ModSettings.dependency", "doEnableXpMultipliers")
    let shinobiXpMultiplier: Float = 1.0;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.category", "NeverToxic-MoreLevels-Settings-XpMultipliers-CategoryName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-XpMultipliers-Solo-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-XpMultipliers-Solo-Description")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.05")
    @runtimeProperty("ModSettings.max", "5.0")
    @runtimeProperty("ModSettings.dependency", "doEnableXpMultipliers")
    let soloXpMultiplier: Float = 1.0;

    @runtimeProperty("ModSettings.mod", "NeverToxic-MoreLevels-ModName")
    @runtimeProperty("ModSettings.category", "NeverToxic-MoreLevels-Settings-XpMultipliers-CategoryName")
    @runtimeProperty("ModSettings.displayName", "NeverToxic-MoreLevels-Settings-XpMultipliers-Engineer-Name")
    @runtimeProperty("ModSettings.description", "NeverToxic-MoreLevels-Settings-XpMultipliers-Engineer-Description")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.05")
    @runtimeProperty("ModSettings.max", "5.0")
    @runtimeProperty("ModSettings.dependency", "doEnableXpMultipliers")
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

    public func GetDoUseCustomCyberwareCapacityPerLevel() -> Bool {
        return this.doUseCustomCyberwareCapacityPerLevel;
    }

    public func GetCyberwareCapacityPerLevel() -> Int32 {
        return this.cyberwareCapacityPerLevel;
    }

    public func GetDoEnableXpMultipliers() -> Bool {
        return this.doEnableXpMultipliers;
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
