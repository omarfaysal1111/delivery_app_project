import 'package:equatable/equatable.dart';

class DriverRegistration extends Equatable {
  const DriverRegistration({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.userId,
    required this.email,
    required this.name,
    required this.role,
  });

  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final String userId;
  final String email;
  final String name;
  final String role;

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
    tokenType,
    userId,
    email,
    name,
    role,
  ];
}
