import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';

abstract class OrderRemoteDataSource {
  Future<Map<String, dynamic>> getActiveOrder();
  Future<Map<String, dynamic>> acceptOrder(String orderId);
  Future<void> declineOrder(String orderId);
  Future<void> arrivedAtRestaurant(String orderId);
  Future<void> confirmDelivery(String orderId, String photoPath);
  Future<void> reportIssue(String orderId, Map<String, dynamic> body);
  Future<void> updateLocation(double lat, double lng);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiClient client;
  OrderRemoteDataSourceImpl(this.client);

  @override
  Future<Map<String, dynamic>> getActiveOrder() =>
      client.get(ApiConstants.activeOrder);

  @override
  Future<Map<String, dynamic>> acceptOrder(String orderId) =>
      client.post(ApiConstants.acceptOrder.replaceFirst('{id}', orderId));

  @override
  Future<void> declineOrder(String orderId) =>
      client.post(ApiConstants.declineOrder.replaceFirst('{id}', orderId));

  @override
  Future<void> arrivedAtRestaurant(String orderId) =>
      client.post(ApiConstants.arrivedOrder.replaceFirst('{id}', orderId));

  @override
  Future<void> confirmDelivery(String orderId, String photoPath) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.confirmOrder.replaceFirst('{id}', orderId)}');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('photo', photoPath));
    final streamed = await request.send();
    if (streamed.statusCode != 200) {
      throw ServerException('Confirm delivery failed: ${streamed.statusCode}');
    }
  }

  @override
  Future<void> reportIssue(String orderId, Map<String, dynamic> body) =>
      client.post(ApiConstants.reportIssue.replaceFirst('{id}', orderId),
          body: body);

  @override
  Future<void> updateLocation(double lat, double lng) =>
      client.post(ApiConstants.driverLocation, body: {'lat': lat, 'lng': lng});
}
