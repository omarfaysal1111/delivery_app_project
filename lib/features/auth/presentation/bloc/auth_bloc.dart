import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/check_auth_session_usecase.dart';
import '../../domain/usecases/register_driver_usecase.dart';
import '../../domain/usecases/upload_media_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required CheckAuthSessionUseCase checkAuthSession,
    required RegisterDriverUseCase registerDriver,
    required UploadMediaUseCase uploadMedia,
  }) : _checkAuthSession = checkAuthSession,
       _registerDriver = registerDriver,
       _uploadMedia = uploadMedia,
       super(const AuthStateInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
  }

  final CheckAuthSessionUseCase _checkAuthSession;
  final RegisterDriverUseCase _registerDriver;
  final UploadMediaUseCase _uploadMedia;

  Future<String?> uploadMedia(String filePath) {
    return _uploadMedia(filePath);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _checkAuthSession(const NoParams());
    result.fold((_) => emit(const Unauthenticated()), (session) {
      if (session == null) {
        emit(const Unauthenticated());
      } else {
        emit(Authenticated(session));
      }
    });
  }

  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthRegisterInProgress());
    final result = await _registerDriver(
      RegisterDriverParams(
        name: event.name,
        phone: event.phone,
        email: event.email,
        vehicleType: event.vehicleType,
        vehicleNumber: event.vehicleNumber,
        nationalId: event.nationalId,
        profilePhotoUrl: event.profilePhotoUrl,
        driverLicensePhotoUrl: event.driverLicensePhotoUrl,
        vehicleLicensePhotoUrl: event.vehicleLicensePhotoUrl,
        nationalIdPhotoUrl: event.nationalIdPhotoUrl,
      ),
    );
    result.fold(
      (failure) => emit(AuthRegisterFailed(failure.message)),
      (registration) => emit(AuthRegisterSucceeded(registration)),
    );
  }
}
