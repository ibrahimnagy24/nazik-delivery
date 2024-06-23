import '../../../../network/mapper.dart';
import 'meta.dart';

class ItemsModel extends SingleMapper {
  int? status;
  String? message;
  List<ItemModel>? requests;
  Meta? meta;

  ItemsModel({this.status, this.message, this.requests, this.meta});

  ItemsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      requests = [];
      json['data'].forEach((v) {
        requests!.add(ItemModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['meta'] = meta?.toJson();
    if (requests != null) {
      data['data'] = requests!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return ItemsModel.fromJson(json);
  }
}

class ItemModel extends SingleMapper {
  int? id;
  String? name;
  bool? isSelected;
  ItemStatus? status;


  ItemModel({this.id, this.name, this.isSelected,this.status});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = ItemStatus.values[json['status']];

    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data["is_selected"] = isSelected;
    data['status'] = status?.index;


    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return ItemsModel.fromJson(json);
  }
}
enum ItemStatus { inProgress, done, canceled }
