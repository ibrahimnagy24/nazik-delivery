import '../../../model/meta.dart';
import '../../../network/mapper.dart';

class NotificationsModel extends SingleMapper {
  String? message;
  int? status;
  List<NotificationModel>? data;
  Meta? meta;

  NotificationsModel({this.message, this.status, this.data, this.meta});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status_code'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['meta'] = meta?.toJson();

    return data;
  }

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status_code'];
    data = <NotificationModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(NotificationModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return NotificationsModel.fromJson(json);
  }
}

class NotificationModel {
  String? id;
  bool? isRead;
  String? title;
  String? body;
  String? image;
  DateTime? createdAt;

  NotificationModel(
      {this.id,
      this.isRead,
      this.title,
      this.image,
      this.body,
      this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isRead = json['is_read'];
    title = json['title'];
    image = json['image'];
    body = json['body'];
    createdAt = json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_read'] = isRead;
    data['image'] = image;
    data['title'] = title;
    data['body'] = body;
    data['created_at'] = createdAt?.toIso8601String();
    return data;
  }
}
