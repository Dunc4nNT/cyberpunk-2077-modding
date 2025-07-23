module NeverToxic.MoreLevels

@wrapMethod(RipperDocGameController)
private final func GetMaxCapacityPossible() -> Float {
    let max: Float = wrappedMethod();
    let moreLevelsService: ref<MoreLevelsService> = GameInstance.GetScriptableServiceContainer().GetService(n"NeverToxic.MoreLevels.MoreLevelsService") as MoreLevelsService;

    max += moreLevelsService.CalculateMaxCyberwareExtra();

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

    if (moreLevelsService.settings.GetDoEnableXpMultipliers()) {
        let xpFloat: Float = Cast<Float>(request.m_amount);
        let newXp: Float = xpFloat * moreLevelsService.GetXpMultiplier(request.m_experienceType);

        request.m_amount = Cast<Int32>(newXp);
    }

    wrappedMethod(request);
}
