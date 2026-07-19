import '../../domain/entities/driver_registration.dart';

class DriverRegisterResponseModel extends DriverRegistration {
  const DriverRegisterResponseModel({
    required super.userId,
    required super.message,
  });

  factory DriverRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return DriverRegisterResponseModel(
      userId: json['userId'] as String? ?? '',
      message: json['message'] as String? ?? 'Registration successful',
    );
  }
}
