import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/check_auth_session_usecase.dart';
import '../../domain/usecases/register_driver_usecase.dart';
import '../../domain/usecases/send_driver_login_otp_usecase.dart';
import '../../domain/usecases/upload_media_usecase.dart';
import '../../domain/usecases/verify_driver_login_otp_usecase.dart';
import 'auth_state.dart';
import 'dart:io';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.checkAuthSession,
    required this.sendDriverLoginOtp,
    required this.verifyDriverLoginOtp,
    required this.registerDriver,
    required this.uploadMedia,
    required this.authRepository,
  }) : super(AuthInitial());

  final CheckAuthSessionUseCase checkAuthSession;
  final SendDriverLoginOtpUseCase sendDriverLoginOtp;
  final VerifyDriverLoginOtpUseCase verifyDriverLoginOtp;
  final RegisterDriverUseCase registerDriver;
  final UploadMediaUseCase uploadMedia;
  final AuthRepository authRepository;

  String? _phoneNumber;
  String? get phoneNumber => _phoneNumber;

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());

    final accessToken = await authRepository.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      emit(AuthUnauthenticated());
      return;
    }

    bool isExpired = true;
    try {
      isExpired = JwtDecoder.isExpired(accessToken);
    } catch (e) {
      isExpired = true; // Default to expired if parsing fails
    }

    if (!isExpired) {
      emit(AuthAuthenticated());
      return;
    }

    // Token is expired, try to refresh
    final refreshTokenStr = await authRepository.getRefreshToken();
    if (refreshTokenStr == null || refreshTokenStr.isEmpty) {
      await authRepository.clearSession();
      emit(AuthUnauthenticated());
      return;
    }

    final result = await authRepository.refreshToken(refreshTokenStr);
    result.fold(
      (failure) async {
        await authRepository.clearSession();
        emit(AuthUnauthenticated());
      },
      (authResponse) {
        emit(AuthAuthenticated());
      },
    );
  }

  Future<void> submitPhone(String phone) async {
    _phoneNumber = phone;
    emit(AuthLoading());
    final result = await sendDriverLoginOtp(phone);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthPhoneSubmitted(phone)),
    );
  }

  Future<void> verifyOtp(String otp) async {
    if (_phoneNumber == null) {
      emit(const AuthError("Phone number is missing. Please try again."));
      return;
    }
    emit(AuthLoading());
    final result = await verifyDriverLoginOtp(VerifyDriverLoginOtpParams(
      phone: _phoneNumber!,
      otp: otp,
    ));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (authResponse) {
        emit(AuthOtpVerified(isNewDriver: authResponse.newUser));
      },
    );
  }

  Future<void> submitRegistration({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String vehicleType,
    required String vehicleNumber,
    required String nationalId,
    required File? profilePhoto,
    required File? driverLicensePhoto,
    required File? vehicleLicensePhoto,
    required File? nationalIdPhoto,
  }) async {
    emit(AuthLoading());

    try {
      String profilePhotoUrl = '';
      if (profilePhoto != null) {
        final url = await uploadMedia(profilePhoto.path);
        profilePhotoUrl = url ?? '';
      }

      String driverLicensePhotoUrl = '';
      if (driverLicensePhoto != null) {
        final url = await uploadMedia(driverLicensePhoto.path);
        driverLicensePhotoUrl = url ?? '';
      }

      String vehicleLicensePhotoUrl = '';
      if (vehicleLicensePhoto != null) {
        final url = await uploadMedia(vehicleLicensePhoto.path);
        vehicleLicensePhotoUrl = url ?? '';
      }

      String nationalIdPhotoUrl = '';
      if (nationalIdPhoto != null) {
        final url = await uploadMedia(nationalIdPhoto.path);
        nationalIdPhotoUrl = url ?? '';
      }

      final result = await registerDriver(RegisterDriverParams(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        vehicleType: vehicleType,
        vehicleNumber: vehicleNumber,
        nationalId: nationalId,
        profilePhotoUrl: profilePhotoUrl,
        driverLicensePhotoUrl: driverLicensePhotoUrl,
        vehicleLicensePhotoUrl: vehicleLicensePhotoUrl,
        nationalIdPhotoUrl: nationalIdPhotoUrl,
      ));

      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (registration) => emit(AuthRegistrationSubmitted()),
      );
    } catch (e) {
      emit(AuthError("Failed to upload media or register. Please try again."));
    }
  }

  Future<void> logout() async {
    emit(AuthLogoutLoading());
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }
}
