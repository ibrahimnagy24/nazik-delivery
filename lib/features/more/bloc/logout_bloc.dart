import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_core.dart';
import '../../../core/app_event.dart';
import '../../../core/app_notification.dart';
import '../../../core/app_state.dart';
import '../../../helpers/shared_helper.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../repo/logout_repo.dart';

class LogoutBloc extends Bloc<AppEvent, AppState> {
  LogoutBloc() : super(Start()) {
    on<Click>(onLogout);
  }

  Future<void> onLogout(AppEvent event, Emitter emit) async {
    emit(Loading());
    try {
      Response res = await LogoutRepo.logout();

      if (res.statusCode == 200) {
        SharedHelper.sharedHelper?.logout();
        emit(Done());
      } else {
        AppCore.showSnackBar(
          notification: AppNotification(
            message: allTranslations.text("something_went_wrong"),
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
          message: allTranslations.text("something_went_wrong"),
          backgroundColor: Styles.IN_ACTIVE,
          borderColor: Styles.DARK_RED,
          iconName: "fill-close-circle",
        ),
      );
      emit(Error());
    }
  }
}
