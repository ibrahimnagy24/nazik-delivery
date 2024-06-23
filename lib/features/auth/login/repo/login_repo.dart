import 'package:flutter_base/config/api_names.dart';
import 'package:flutter_base/features/auth/login/model/user_model.dart';
import 'package:flutter_base/network/network_layer.dart';

abstract class LoginRepo {
  static Future<dynamic> login({
    required String username,
    required String password,
  }) async {
    return await Network().request(
      ApiNames.login,
      query: {
        "email": username,
        "password": password,
      },
      method: ServerMethods.POST,
      model: UserModel(),
    );
  }
}
