import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class SendDriverLoginOtpUseCase implements UseCase<void, String> {
  SendDriverLoginOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(String phone) {
    return _repository.sendDriverLoginOtp(phone);
  }
}
