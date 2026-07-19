import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthPhoneSubmitted extends AuthState {
  final String phone;
  const AuthPhoneSubmitted(this.phone);

  @override
  List<Object> get props => [phone];
}

class AuthOtpVerified extends AuthState {
  final bool isNewDriver;
  const AuthOtpVerified({required this.isNewDriver});

  @override
  List<Object> get props => [isNewDriver];
}

class AuthRegistrationSubmitted extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
