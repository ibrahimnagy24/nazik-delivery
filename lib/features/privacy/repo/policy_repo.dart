import '../../../network/network_layer.dart';
import '../../../config/api_names.dart';

abstract class PrivacyPolicyRepo {
  static Future<dynamic> getPolicy() async {
    return await Network().request(
      ApiNames.policy,
      method: ServerMethods.GET,
    );
  }
}
