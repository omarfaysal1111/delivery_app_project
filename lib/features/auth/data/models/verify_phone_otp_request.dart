class VerifyPhoneOtpRequest {
  final String phone;
  final String otp;

  const VerifyPhoneOtpRequest({required this.phone, required this.otp});

  Map<String, dynamic> toJson() {
    return {'phone': phone, 'otp': otp};
  }
}
