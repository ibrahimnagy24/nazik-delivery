import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_core.dart';
import '../../../core/app_event.dart';
import '../../../core/app_notification.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../navigation/custom_navigation.dart';
import '../repo/change_password_repo.dart';

class ChangePasswordBloc extends Bloc<AppEvent, AppState> {
  ChangePasswordBloc() : super(Start()) {
    on<Click>(onClick);
  }

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();

  Future<void> onClick(AppEvent event, Emitter emit) async {
    if (globalKey.currentState!.validate()) {
      try {
        emit(Loading());
        Map<String, dynamic> body = {
          "old_password": oldPassword.text.trim(),
          "new_password": newPassword.text.trim(),
        };
        Response res = await ChangePasswordRepo.changePassword(body);

        if (res.statusCode == 200) {
          CustomNavigator.pop();
          AppCore.showSnackBar(
              notification: AppNotification(
                  message: allTranslations
                      .text("your_password_changed_successfully"),
                  backgroundColor: Styles.ACTIVE,
                  borderColor: Styles.DARK_GREEN,
                  iconName: "check-circle24",
                  isFloating: true));
          emit(Done());
        } else {
          AppCore.showSnackBar(
              notification: AppNotification(
                  message: allTranslations.text("something_went_wrong"),
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Styles.DARK_RED,
                  iconName: "close_circle32",
                  isFloating: true));
          emit(Error());
        }
      } catch (e) {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: allTranslations.text("something_went_wrong"),
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Styles.DARK_RED,
                iconName: "close_circle32",
                isFloating: true));
        emit(Error());
      }
    }
  }
}
