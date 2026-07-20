import 'package:equatable/equatable.dart';

abstract class ActiveOrderState extends Equatable {
  const ActiveOrderState();

  @override
  List<Object> get props => [];
}

class ActiveOrderIdle extends ActiveOrderState {}

class ActiveOrderAssigned extends ActiveOrderState {}

class ActiveOrderPickedUp extends ActiveOrderState {}

class ActiveOrderDelivered extends ActiveOrderState {}
