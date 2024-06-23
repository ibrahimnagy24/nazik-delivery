import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/app_core.dart';
import 'package:flutter_base/core/app_event.dart';
import 'package:flutter_base/core/app_notification.dart';
import 'package:flutter_base/core/app_state.dart';
import '../../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../repo/requests_repo.dart';
import 'my_requests_bloc.dart';

class CancelRequestBloc extends Bloc<AppEvent, AppState> {
  CancelRequestBloc() : super(Start()) {
    on<Click>(onClick);
  }

  Future<void> onClick(AppEvent event, Emitter emit) async {
    emit(Loading());
    try {
      Response res = await MyRequestsRepo.cancelRequest(event.arguments as int);
      if (res.statusCode == 200) {
        AppCore.showSnackBar(
          notification: AppNotification(
              message: allTranslations.text("item_deleted_successfully"),
              backgroundColor: Styles.ACTIVE,
              borderColor: Styles.GREEN,
              isFloating: true),
        );
        MyRequestsBloc.instance.add(Update(arguments: event.arguments as int));
        emit(Done());
      } else {
        AppCore.showSnackBar(
          notification: AppNotification(
            message: res.data["message"],
            backgroundColor: Styles.IN_ACTIVE,
            borderColor: Styles.DARK_RED,
            iconName: "fill-close-circle",
          ),
        );
        emit(Error());
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
