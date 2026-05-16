import 'package:equatable/equatable.dart';

class DriverSession extends Equatable {
  final String driverId;
  final String token;

  const DriverSession({
    required this.driverId,
    required this.token,
  });

  @override
  List<Object?> get props => [driverId, token];
}
