import 'package:dio/dio.dart';
import '../../../../config/api_names.dart';
import '../../../../network/network_layer.dart';

abstract class ForgetPasswordRepo {
  static Future<Response> forgetPassword(email) async {
    return await Network().request(
      ApiNames.forgetPassword,
      body: FormData.fromMap({
        "email": email,
      }),
      method: ServerMethods.POST,
    );
  }
}
