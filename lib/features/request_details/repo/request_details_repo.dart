import '../../../config/api_names.dart';
import '../../../network/network_layer.dart';

abstract class RequestDetailsRepo {
  static Future<dynamic> requestDetails(id) async {
    return await Network()
        .request(ApiNames.requestDetails(id), method: ServerMethods.GET);
  }

  static Future<dynamic> assignRequest(id) async {
    return await Network()
        .request(ApiNames.assignRequest(id), method: ServerMethods.POST);
  }
}
