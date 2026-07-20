class ProfileState {
  final bool isLoading;
  final bool deleteAccountSuccess;
  final bool updateSettingsSuccess;
  final String? errorMessage;
  final ProfileSettings? settings;

  const ProfileState({
    this.isLoading = false,
    this.deleteAccountSuccess = false,
    this.updateSettingsSuccess = false,
    this.errorMessage,
    this.settings,
  });

  ProfileState copyWith({
    bool? isLoading,
    bool? deleteAccountSuccess,
    bool? updateSettingsSuccess,
    String? errorMessage,
    ProfileSettings? settings,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      deleteAccountSuccess: deleteAccountSuccess ?? this.deleteAccountSuccess,
      updateSettingsSuccess:
          updateSettingsSuccess ?? this.updateSettingsSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      settings: settings ?? this.settings,
    );
  }
}

class ProfileSettings {
  final bool pushNotifications;
  final bool receiveOrders;
  const ProfileSettings({
    this.pushNotifications = true,
    this.receiveOrders = true,
  });
}
