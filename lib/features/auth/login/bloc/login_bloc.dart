import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/app_core.dart';
import 'package:flutter_base/core/app_event.dart';
import 'package:flutter_base/core/app_notification.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/features/auth/login/model/user_model.dart';
import 'package:flutter_base/features/auth/login/repo/login_repo.dart';
import 'package:flutter_base/helpers/shared_helper.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';
import 'package:flutter_base/navigation/routes.dart';
import '../../../../helpers/styles.dart';

class LoginBloc extends Bloc<AppEvent, AppState> {
  LoginBloc() : super(Start()) {
    on<Click>(onClick);
  }

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController mailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  clear() {
    mailTEC.clear();
    passwordTEC.clear();
  }

  Future<void> onClick(AppEvent event, Emitter emit) async {
    emit(Loading());
    try {
      Response res = await LoginRepo.login(
        password: passwordTEC.text.trim(),
        username: mailTEC.text.trim(),
      );
      if (res.statusCode == 200) {
        if (res.data != null &&
            res.data["data"] != null &&
            res.data["data"]["type"] == ["delivery-employee"]) {
          UserModel model = UserModel.fromJson(res.data["data"]);
          if (model.token != null) {
            SharedHelper.sharedHelper!.writeData(CachingKey.TOKEN, model.token);
            SharedHelper.sharedHelper!.writeData(CachingKey.SKIP, true);
            SharedHelper.sharedHelper!.writeData(CachingKey.IS_LOGIN, true);
            SharedHelper.sharedHelper!.writeData(
              CachingKey.USER,
              json.encode(
                model.toJson(),
              ),
            );
            CustomNavigator.push(Routes.MAIN_PAGE, clean: true);
            emit(Done());
          } else {
            AppCore.showSnackBar(
              notification: AppNotification(
                message: allTranslations.text("invalid_credentials"),
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Styles.DARK_RED,
                iconName: "fill-close-circle",
              ),
            );
            emit(Start());
          }
        } else {
          AppCore.showSnackBar(
            notification: AppNotification(
              message: allTranslations.text("invalid_credentials"),
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Styles.DARK_RED,
              iconName: "fill-close-circle",
            ),
          );
          emit(Start());
        }
      } else {
        AppCore.showSnackBar(
          notification: AppNotification(
            message: allTranslations.text("invalid_credentials"),
            backgroundColor: Styles.IN_ACTIVE,
            borderColor: Styles.DARK_RED,
            iconName: "fill-close-circle",
          ),
        );
        emit(Start());
      }
    } catch (e) {
      AppCore.showSnackBar(
        notification: AppNotification(
          message: e.toString(),
          backgroundColor: Styles.IN_ACTIVE,
          borderColor: Styles.DARK_RED,
          iconName: "fill-close-circle",
        ),
      );
      emit(Error());
    }
  }
}
