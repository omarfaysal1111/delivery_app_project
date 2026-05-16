import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/driver_session.dart';
import '../repositories/auth_repository.dart';

class CheckAuthSessionUseCase
    implements UseCase<DriverSession?, NoParams> {
  CheckAuthSessionUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, DriverSession?>> call(NoParams params) {
    return _repository.getCachedSession();
  }
}
