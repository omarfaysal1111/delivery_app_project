import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/driver_session.dart';

abstract class AuthRepository {
  Future<bool> get isLoggedIn;

  Future<Either<Failure, DriverSession?>> getCachedSession();

  Future<Either<Failure, void>> clearSession();
}
