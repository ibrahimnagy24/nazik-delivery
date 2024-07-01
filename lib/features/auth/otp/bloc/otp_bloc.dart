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
import '../repo/otp_repo.dart';

class OtpBloc extends Bloc<AppEvent, AppState> {
  OtpBloc() : super(Start()) {
    on<Click>(onClick);
  }

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController codeTEC = TextEditingController();

  clear() {
    codeTEC.clear();
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      Map<String, dynamic> data = {
        "email": event.arguments as String,
        "code": codeTEC.text.trim()
      };

      Response res = await OtpRepo.verify(data);
      if (res.statusCode == 200) {
        CustomNavigator.push(Routes.RESET_PASSWORD,
            arguments: event.arguments as String, replace: true);
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
