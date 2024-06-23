import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_core.dart';
import '../../../core/app_event.dart';
import '../../../core/app_notification.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../repo/terms_repo.dart';

class TermsBloc extends Bloc<AppEvent, AppState> {
  TermsBloc() : super(Start()) {
    on<Click>(_policy);
  }

  _policy(AppEvent event, Emitter<AppState> emit) async {
    emit(Loading());
    try {
      Response res = await TermsRepo.getTerms();
      if (res.statusCode == 200) {
        if (res.data != null) {
          emit(Done(data: res.data["data"]));
        } else {
          emit(Empty());
        }
      } else {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: res.data["message"] ?? "",
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Styles.DARK_RED,
                iconName: "fill-close-circle"));
        emit(Error());
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
