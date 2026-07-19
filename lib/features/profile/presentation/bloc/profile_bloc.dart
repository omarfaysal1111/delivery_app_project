import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<GetSettingsEvent>(_onGetSettings);
    on<UpdateSettingsEvent>(_onUpdateSettings);
    on<DeleteAccountEvent>(_onDeleteAccount);
  }

  Future<void> _onGetSettings(GetSettingsEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(
      isLoading: false,
      settings: const ProfileSettings(pushNotifications: true),
    ));
  }

  Future<void> _onUpdateSettings(UpdateSettingsEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(
      isLoading: false,
      updateSettingsSuccess: true,
      settings: ProfileSettings(
        pushNotifications: event.request.pushNotifications ?? state.settings?.pushNotifications ?? true,
      ),
    ));
    // Reset success flag
    emit(state.copyWith(updateSettingsSuccess: false));
  }

  Future<void> _onDeleteAccount(DeleteAccountEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 1000));
    emit(state.copyWith(isLoading: false, deleteAccountSuccess: true));
  }
}
