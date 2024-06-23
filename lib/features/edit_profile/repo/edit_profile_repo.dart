import 'package:flutter_base/config/api_names.dart';

import '../../../network/network_layer.dart';

abstract class EditProfileRepo {
  static Future<dynamic> updateProfile(body) async {
    return await Network()
        .request(ApiNames.editProfile, method: ServerMethods.POST, body: body);
  }
}
