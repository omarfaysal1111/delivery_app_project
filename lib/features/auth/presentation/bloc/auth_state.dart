import 'package:equatable/equatable.dart';

import '../../domain/entities/driver_session.dart';
import '../../domain/entities/driver_registration.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthStateInitial extends AuthState {
  const AuthStateInitial();
}

class Authenticated extends AuthState {
  const Authenticated(this.session);

  final DriverSession session;

  @override
  List<Object?> get props => [session];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthRegisterInProgress extends AuthState {
  const AuthRegisterInProgress();
}

class AuthRegisterSucceeded extends AuthState {
  const AuthRegisterSucceeded(this.registration);

  final DriverRegistration registration;

  @override
  List<Object?> get props => [registration];
}

class AuthRegisterFailed extends AuthState {
  const AuthRegisterFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
