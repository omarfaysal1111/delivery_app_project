import '../../domain/entities/driver_registration.dart';

class DriverRegisterResponseModel extends DriverRegistration {
  const DriverRegisterResponseModel({
    required super.accessToken,
    required super.refreshToken,
    required super.tokenType,
    required super.userId,
    required super.email,
    required super.name,
    required super.role,
  });

  factory DriverRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return DriverRegisterResponseModel(
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      tokenType: json['tokenType'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
    );
  }
}
