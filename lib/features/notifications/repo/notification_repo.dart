import '../../../config/api_names.dart';
import '../../../model/search_engine.dart';
import '../../../network/network_layer.dart';
import '../model/notifications_model.dart';

abstract class NotificationsRepo {
  static Future<dynamic> getNotifications(SearchEngine data) async {
    return await Network().request(ApiNames.notifications,
        query: {
          "page": data.currentPage + 1,
          "limit": data.limit,
        },
        method: ServerMethods.GET,
        model: NotificationsModel());
  }

  static Future<dynamic> readNotification(id) async {
    return await Network()
        .request(ApiNames.readNotifications(id), method: ServerMethods.POST);
  }
}
