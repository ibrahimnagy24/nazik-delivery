import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../bloc/user_bloc.dart';
import '../../../core/app_core.dart';
import '../../../core/app_event.dart';
import '../../../core/app_notification.dart';
import '../../../core/app_state.dart';
import '../../../helpers/shared_helper.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../auth/login/model/user_model.dart';
import '../repo/edit_profile_repo.dart';

class EditProfileBloc extends Bloc<AppEvent, AppState> {
  EditProfileBloc() : super(Start()) {
    on<Click>(onClick);
    on<Init>(onInit);
  }

  Map<String, dynamic> body = {
    "name": "${UserBloc.instance.user?.name}",
  };

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();

  final image = BehaviorSubject<File?>();
  Function(File?) get updateImage => image.sink.add;
  Stream<File?> get imageStream => image.stream.asBroadcastStream();

  editImage(File? file) {
    updateImage(file);
    if (file != null) {
      add((Click()));
    }
  }

  clear() {
    name.clear();
    email.clear();
    updateImage(null);
  }

  @override
  Future<void> close() {
    image.close();
    return super.close();
  }

  bool hasData() {
    return _boolCheckString(name.text.trim(), "name");
  }

  bool _boolCheckString(String? value, String key) {
    if (value != null) return value != "" && value != body[key];
    return false;
  }

  Future<void> onClick(Click event, Emitter emit) async {
    emit(Loading());
    if (hasData() || image.valueOrNull != null) {
      if (image.valueOrNull != null) {
        body.addAll(
            {"image": await MultipartFile.fromFile(image.valueOrNull!.path)});
      } else {
        body.addAll({"image": null});
      }
      if (_boolCheckString(name.text.trim(), "name")) {
        body["name"] = name.text.trim();
      }
      try {
        Response res =
            await EditProfileRepo.updateProfile(FormData.fromMap(body));
        if (res.statusCode == 200) {
          UserModel model = UserModel.fromJson(res.data["data"]);
          SharedHelper.sharedHelper!
              .writeData(CachingKey.USER, json.encode(model.toJson()));
          UserBloc.instance.add(Click());
          clear();
          emit(Done());
        } else {
          AppCore.showSnackBar(
              notification: AppNotification(
                  message: allTranslations.text("something_went_wrong"),
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Styles.DARK_RED,
                  iconName: "fill-close-circle"));
          emit(Error());
        }
      } catch (e) {
        emit(Error());
      }
    } else {
      AppCore.showSnackBar(
          notification: AppNotification(
              message: allTranslations.text("you_must_change_something"),
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Styles.DARK_RED,
              iconName: "fill-close-circle",
              isFloating: true));
      emit(Start());
    }
  }

  Future<void> onInit(Init event, Emitter emit) async {
    name.text = UserBloc.instance.user?.name ?? "";
    email.text = UserBloc.instance.user?.email ?? "";
    emit(Start());
  }
}
