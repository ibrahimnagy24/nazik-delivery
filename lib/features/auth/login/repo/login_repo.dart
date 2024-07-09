import 'package:dio/dio.dart';
import 'package:flutter_base/config/api_names.dart';
import 'package:flutter_base/network/network_layer.dart';

import '../../../../helpers/shared_helper.dart';

abstract class LoginRepo {
  static Future<dynamic> login({
    required String username,
    required String password,
  }) async {
    return await Network().request(
      ApiNames.login,
      body: FormData.fromMap({
        "email": username,
        "password": password,
        'device_token':
            await SharedHelper.sharedHelper!.readString(CachingKey.DEVICE_TOKEN)
      }),
      method: ServerMethods.POST,
    );
  }
}
