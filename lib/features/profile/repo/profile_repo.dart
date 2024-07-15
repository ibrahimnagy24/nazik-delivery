import 'package:flutter_base/config/api_names.dart';

import '../../../network/network_layer.dart';

abstract class ProfileRepo {
  static Future<dynamic> getProfile() async {
    return await Network().request(ApiNames.profile, method: ServerMethods.GET);
  }
}
