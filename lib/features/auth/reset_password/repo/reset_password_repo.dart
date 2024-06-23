import 'package:dio/dio.dart';

import '../../../../config/api_names.dart';
import '../../../../network/network_layer.dart';

abstract class ResetPasswordRepo {
  static Future<Response> resetPassword(data) async {
    return await Network().request(
      ApiNames.resetPassword,
      body: FormData.fromMap(data),
      method: ServerMethods.POST,
    );
  }
}
