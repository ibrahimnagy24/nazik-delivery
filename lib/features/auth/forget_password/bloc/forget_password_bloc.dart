import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_core.dart';
import '../../../../core/app_event.dart';
import '../../../../core/app_notification.dart';
import '../../../../core/app_state.dart';
import '../../../../helpers/styles.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../repo/forget_password_repo.dart';

class ForgetPasswordBloc extends Bloc<AppEvent, AppState> {
  ForgetPasswordBloc() : super(Start()) {
    on<Click>(onClick);
  }

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController mailTEC = TextEditingController();

  clear() {
    mailTEC.clear();
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      Response res =
          await ForgetPasswordRepo.forgetPassword(mailTEC.text.trim());
      if (res.statusCode == 200) {
        CustomNavigator.push(
          Routes.OTP,
          replace: true,
          arguments: mailTEC.text.trim(),
        );
        Future.delayed(const Duration(seconds: 1), () => clear());

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
