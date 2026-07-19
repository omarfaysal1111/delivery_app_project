abstract class ProfileEvent {
  const ProfileEvent();
}

class GetSettingsEvent extends ProfileEvent {
  const GetSettingsEvent();
}

class UpdateSettingsEvent extends ProfileEvent {
  final UpdateSettingsRequest request;
  const UpdateSettingsEvent(this.request);
}

class DeleteAccountEvent extends ProfileEvent {
  const DeleteAccountEvent();
}

class UpdateSettingsRequest {
  final bool? pushNotifications;
  final bool? receiveOrders;
  final String? theme;

  const UpdateSettingsRequest({
    this.pushNotifications,
    this.receiveOrders,
    this.theme,
  });
}
