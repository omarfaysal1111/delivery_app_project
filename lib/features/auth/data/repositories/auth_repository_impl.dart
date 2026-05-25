import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../onboarding/data/datasources/auth_local_datasource.dart';
import '../../../onboarding/data/datasources/auth_remote_datasource.dart';
import '../models/driver_register_request_model.dart';
import '../models/driver_register_response_model.dart';
import '../../domain/entities/driver_registration.dart';
import '../../domain/entities/driver_session.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthLocalDataSource localDataSource,
    required AuthRemoteDataSource remoteDataSource,
  }) : _local = localDataSource,
       _remote = remoteDataSource;

  final AuthLocalDataSource _local;
  final AuthRemoteDataSource _remote;

  @override
  Future<bool> get isLoggedIn async {
    try {
      _local.getToken();
      return true;
    } on CacheException {
      return false;
    }
  }

  @override
  Future<Either<Failure, DriverSession?>> getCachedSession() async {
    try {
      final token = _local.getToken();
      final driverId = _local.getDriverId();
      return Right(DriverSession(driverId: driverId, token: token));
    } on CacheException {
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearSession() async {
    try {
      await _local.clearSession();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DriverRegistration>> registerDriver(
    RegisterDriverParams params,
  ) async {
    try {
      final request = DriverRegisterRequestModel(
        name: params.name,
        phone: params.phone,
        email: params.email,
        vehicleType: params.vehicleType,
        vehicleNumber: params.vehicleNumber,
        nationalId: params.nationalId,
        profilePhotoUrl: params.profilePhotoUrl,
        driverLicensePhotoUrl: params.driverLicensePhotoUrl,
        vehicleLicensePhotoUrl: params.vehicleLicensePhotoUrl,
        nationalIdPhotoUrl: params.nationalIdPhotoUrl,
      );
      final json = await _remote.registerDriver(request.toJson());
      final registration = DriverRegisterResponseModel.fromJson(json);
      if (registration.accessToken.isEmpty ||
          registration.refreshToken.isEmpty ||
          registration.userId.isEmpty) {
        return const Left(ServerFailure('Invalid registration response'));
      }
      await Future.wait([
        _local.saveToken(registration.accessToken),
        _local.saveRefreshToken(registration.refreshToken),
        _local.saveDriverId(registration.userId),
      ]);
      return Right(registration);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<String?> uploadMedia(String filePath) async {
    try {
      return await _remote.uploadMedia(filePath);
    } catch (_) {
      return null;
    }
  }
}
