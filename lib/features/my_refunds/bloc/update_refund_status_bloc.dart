import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/app_core.dart';
import 'package:flutter_base/core/app_event.dart';
import 'package:flutter_base/core/app_notification.dart';
import 'package:flutter_base/core/app_state.dart';
import '../../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../repo/my_refunds_repo.dart';

class UpdateRefundStatusBloc extends Bloc<AppEvent, AppState> {
  UpdateRefundStatusBloc() : super(Start()) {
    on<Click>(onClick);
  }

  Future<void> onClick(AppEvent event, Emitter emit) async {
    try {
      emit(Loading());
      Response res = await MyRefundRepo.updateRefundStatus(
          event.arguments as Map<String, dynamic>);

      if (res.statusCode == 200) {
        AppCore.showSnackBar(
          notification: AppNotification(
              message: allTranslations.text("updated_successfully"),
              backgroundColor: Styles.ACTIVE,
              borderColor: Styles.GREEN,
              isFloating: true),
        );

        if (((event.arguments as Map<String, dynamic>)["onSuccess"]) != null) {
          ((event.arguments as Map<String, dynamic>)["onSuccess"])?.call();
        }
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
