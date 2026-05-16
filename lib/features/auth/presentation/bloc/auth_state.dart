import 'package:equatable/equatable.dart';

import '../../domain/entities/driver_session.dart';

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
