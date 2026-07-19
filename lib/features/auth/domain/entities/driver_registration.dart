import 'package:equatable/equatable.dart';

class DriverRegistration extends Equatable {
  const DriverRegistration({
    required this.userId,
    required this.message,
  });

  final String userId;
  final String message;

  @override
  List<Object?> get props => [
    userId,
    message,
  ];
}
