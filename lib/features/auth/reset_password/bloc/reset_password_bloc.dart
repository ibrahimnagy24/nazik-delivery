import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/navigation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_core.dart';
import '../../../../core/app_event.dart';
import '../../../../core/app_notification.dart';
import '../../../../core/app_state.dart';
import '../../../../helpers/styles.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../../../navigation/custom_navigation.dart';
import '../repo/reset_password_repo.dart';

class ResetPasswordBloc extends Bloc<AppEvent, AppState> {
  ResetPasswordBloc() : super(Start()) {
    on<Click>(onClick);
  }

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController passwordTEC = TextEditingController();
  TextEditingController confirmPasswordTEC = TextEditingController();

  clear() {
    passwordTEC.clear();
    confirmPasswordTEC.clear();
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      Map<String, dynamic> data = {
        "email": event.arguments as String,
        "password": passwordTEC.text.trim(),
      };
      Response res = await ResetPasswordRepo.resetPassword(data);
      if (res.statusCode == 200) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: allTranslations
                    .text("your_password_has_been_reset_successfully"),
                backgroundColor: Styles.ACTIVE,
                borderColor: Styles.GREEN,
                isFloating: true));
        CustomNavigator.push(Routes.LOGIN, clean: true);
        emit(Done());
      } else {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: res.data["message"] ?? "",
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Styles.DARK_RED,
                iconName: "fill-close-circle"));
        emit(Start());
      }
    } catch (e) {
      AppCore.showSnackBar(
          notification: AppNotification(
              message: allTranslations.text("something_went_wrong"),
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Styles.DARK_RED,
              iconName: "fill-close-circle"));
      emit(Error());
    }
  }
}
