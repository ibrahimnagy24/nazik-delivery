import 'package:dio/dio.dart';

import '../../../../config/api_names.dart';
import '../../../../network/network_layer.dart';

abstract class ChangePasswordRepo {
  static Future<Response> changePassword(data) async {
    return await Network().request(
      ApiNames.changePassword,
      body: FormData.fromMap(data),
      method: ServerMethods.POST,
    );
  }
}
