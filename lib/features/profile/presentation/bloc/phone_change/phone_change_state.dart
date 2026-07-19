abstract class PhoneChangeState {
  const PhoneChangeState();
}

class PhoneChangeInitial extends PhoneChangeState {}

class PhoneChangeLoading extends PhoneChangeState {}

class CurrentPhoneVerified extends PhoneChangeState {}

class SendingOtpToNewPhone extends PhoneChangeState {}

class OtpSent extends PhoneChangeState {}

class VerifyingOtp extends PhoneChangeState {}

class PhoneChangedSuccessfully extends PhoneChangeState {}

class PhoneChangeError extends PhoneChangeState {
  final String message;
  const PhoneChangeError(this.message);
}
