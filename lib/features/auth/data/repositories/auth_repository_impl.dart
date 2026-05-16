import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../onboarding/data/datasources/auth_local_datasource.dart';
import '../../domain/entities/driver_session.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthLocalDataSource localDataSource})
      : _local = localDataSource;

  final AuthLocalDataSource _local;

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
}
