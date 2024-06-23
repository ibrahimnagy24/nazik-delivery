import 'package:dio/dio.dart';

import '../../../../config/api_names.dart';
import '../../../../network/network_layer.dart';

abstract class OtpRepo {
  static Future<dynamic> verify(data) async {
    return await Network().request(
      ApiNames.otp,
      body: FormData.fromMap(data),
      method: ServerMethods.POST,
    );
  }

  static Future<Response> resendCode(email) async {
    return await Network().request(
      ApiNames.resend,
      body: FormData.fromMap({
        "email": email,
      }),
      method: ServerMethods.POST,
    );
  }
}
