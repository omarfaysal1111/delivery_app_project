import 'package:flutter_bloc/flutter_bloc.dart';
import 'active_order_state.dart';

class ActiveOrderCubit extends Cubit<ActiveOrderState> {
  ActiveOrderCubit() : super(ActiveOrderIdle());

  void acceptOrder() {
    emit(ActiveOrderAssigned());
  }

  void confirmPickup() {
    emit(ActiveOrderPickedUp());
  }

  void confirmDelivery() {
    emit(ActiveOrderDelivered());
  }

  void finishOrder() {
    emit(ActiveOrderIdle());
  }
}
