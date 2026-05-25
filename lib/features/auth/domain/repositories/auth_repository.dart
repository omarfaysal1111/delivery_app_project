import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/driver_registration.dart';
import '../entities/driver_session.dart';

class RegisterDriverParams {
  const RegisterDriverParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.nationalId,
    required this.profilePhotoUrl,
    required this.driverLicensePhotoUrl,
    required this.vehicleLicensePhotoUrl,
    required this.nationalIdPhotoUrl,
  });

  final String name;
  final String phone;
  final String email;
  final String vehicleType;
  final String vehicleNumber;
  final String nationalId;
  final String? profilePhotoUrl;
  final String? driverLicensePhotoUrl;
  final String? vehicleLicensePhotoUrl;
  final String? nationalIdPhotoUrl;
}

abstract class AuthRepository {
  Future<bool> get isLoggedIn;

  Future<Either<Failure, DriverSession?>> getCachedSession();

  Future<Either<Failure, void>> clearSession();

  Future<Either<Failure, DriverRegistration>> registerDriver(
    RegisterDriverParams params,
  );

  Future<String?> uploadMedia(String filePath);
}
