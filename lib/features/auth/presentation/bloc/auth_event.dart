import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

class AuthRegisterRequested extends AuthEvent {
  const AuthRegisterRequested({
    required this.name,
    required this.phone,
    required this.email,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.nationalId,
    required this.profilePhotoUrl,
    required this.driverLicensePhotoUrl,
    required this.vehicleLicensePhotoUrl,
    required this.nationalIdPhotoUrl,
  });

  final String name;
  final String phone;
  final String email;
  final String vehicleType;
  final String vehicleNumber;
  final String nationalId;
  final String? profilePhotoUrl;
  final String? driverLicensePhotoUrl;
  final String? vehicleLicensePhotoUrl;
  final String? nationalIdPhotoUrl;

  @override
  List<Object?> get props => [
    name,
    phone,
    email,
    vehicleType,
    vehicleNumber,
    nationalId,
    profilePhotoUrl,
    driverLicensePhotoUrl,
    vehicleLicensePhotoUrl,
    nationalIdPhotoUrl,
  ];
}
