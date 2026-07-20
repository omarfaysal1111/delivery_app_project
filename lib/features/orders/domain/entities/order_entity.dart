import 'package:equatable/equatable.dart';

enum OrderStatus {
  waitingAcceptance,
  preparing,
  readyForPickup,
  courierOnWay,
  delivered,
  cancelled,
}

class OrderEntity extends Equatable {
  final String id;
  final String restaurantName;
  final String pickupAddress;
  final String deliveryAddress;
  final String customerName;
  final String customerPhone;
  final double deliveryFee;
  final OrderStatus status;
  final DateTime createdAt;
  final int totalItems;
  final String? estimatedDistance;
  final String? estimatedTime;

  const OrderEntity({
    required this.id,
    required this.restaurantName,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryFee,
    required this.status,
    required this.createdAt,
    required this.totalItems,
    this.estimatedDistance,
    this.estimatedTime,
  });

  @override
  List<Object?> get props => [
    id,
    restaurantName,
    pickupAddress,
    deliveryAddress,
    customerName,
    customerPhone,
    deliveryFee,
    status,
    createdAt,
    totalItems,
    estimatedDistance,
    estimatedTime,
  ];
}
