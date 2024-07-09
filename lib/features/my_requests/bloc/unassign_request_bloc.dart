import 'package:dio/dio.dart';
import 'package:flutter_base/components/loading_dialog.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/app_core.dart';
import 'package:flutter_base/core/app_event.dart';
import 'package:flutter_base/core/app_notification.dart';
import 'package:flutter_base/core/app_state.dart';
import '../../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../repo/requests_repo.dart';
import 'my_requests_bloc.dart';

class UnAssignRequestBloc extends Bloc<AppEvent, AppState> {
  UnAssignRequestBloc() : super(Start()) {
    on<Click>(onClick);
  }

  Future<void> onClick(AppEvent event, Emitter emit) async {
    try {
      emit(Loading());
      showLoadingDialog();
      Response res =
          await MyRequestsRepo.unAssignRequest(event.arguments as int);
      CustomNavigator.pop();
      if (res.statusCode == 200) {
        AppCore.showSnackBar(
          notification: AppNotification(
              message: allTranslations.text("order_unassigned_successfully"),
              backgroundColor: Styles.ACTIVE,
              borderColor: Styles.GREEN,
              isFloating: true),
        );
        CustomNavigator.pop();
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
      CustomNavigator.pop();

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
