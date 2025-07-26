module NeverToxic.FriendlyVehicles

@wrapMethod(PlayerPuppet)
protected cb func OnMountingEvent(evt: ref<MountingEvent>) -> Bool {
    wrappedMethod(evt);

    if this.NeverToxic_FriendlyVehicles_GetDoPlaySfx() {
        let sfx: CName = RandF() > 0.5 ? n"nevertoxic_friendlyvehicles_maimai_enter_0" : n"nevertoxic_friendlyvehicles_maimai_enter_1";
        GameInstance.GetAudioSystem(this.GetGame()).Play(sfx);
    }
}

@wrapMethod(PlayerPuppet)
protected cb func OnUnmountingEvent(evt: ref<UnmountingEvent>) -> Bool {
    if this.NeverToxic_FriendlyVehicles_GetDoPlaySfx() {
        let sfx: CName = RandF() > 0.5 ? n"nevertoxic_friendlyvehicles_maimai_exit_0" : n"nevertoxic_friendlyvehicles_maimai_exit_1";
        GameInstance.GetAudioSystem(this.GetGame()).Play(sfx);
    }

    wrappedMethod(evt);
}

@addMethod(PlayerPuppet)
public func NeverToxic_FriendlyVehicles_GetDoPlaySfx() -> Bool {
    if IsDefined(this.m_mountedVehicle) {
        let vehicleRecord: ref<Vehicle_Record> = this.m_mountedVehicle.GetRecord();
        let vehicleModel: wref<VehicleModel_Record> = vehicleRecord.Model();
        let vehicleModelType: gamedataVehicleModel = vehicleModel.Type();

        switch vehicleModelType {
            case gamedataVehicleModel.Maimai:
                return false;
            default:
                return true;
        }
    }
}
