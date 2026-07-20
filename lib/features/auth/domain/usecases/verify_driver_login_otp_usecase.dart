import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';
import '../../data/models/auth_response.dart';

class VerifyDriverLoginOtpParams {
  const VerifyDriverLoginOtpParams({required this.phone, required this.otp});
  final String phone;
  final String otp;
}

class VerifyDriverLoginOtpUseCase
    implements UseCase<AuthResponse, VerifyDriverLoginOtpParams> {
  VerifyDriverLoginOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, AuthResponse>> call(
    VerifyDriverLoginOtpParams params,
  ) {
    return _repository.verifyDriverLoginOtp(params.phone, params.otp);
  }
}
