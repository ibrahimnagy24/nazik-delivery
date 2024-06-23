import '../../../config/api_names.dart';
import '../../../network/network_layer.dart';

abstract class LogoutRepo {
  static Future<dynamic> logout() async {
    return await Network().request(
      ApiNames.logout,
      method: ServerMethods.POST,
    );
  }
}
