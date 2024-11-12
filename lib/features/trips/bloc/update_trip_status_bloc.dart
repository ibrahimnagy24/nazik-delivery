import 'package:dio/dio.dart';
import 'package:flutter_base/components/loading_dialog.dart';
import 'package:flutter_base/features/trips/bloc/my_trips_bloc.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/app_core.dart';
import 'package:flutter_base/core/app_event.dart';
import 'package:flutter_base/core/app_notification.dart';
import 'package:flutter_base/core/app_state.dart';
import '../../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../repo/my_trips_repo.dart';

class UpdateTripStatusBloc extends Bloc<AppEvent, AppState> {
  UpdateTripStatusBloc() : super(Start()) {
    on<Click>(onClick);
  }

  Future<void> onClick(AppEvent event, Emitter emit) async {
    try {
      emit(Loading());
      showLoadingDialog();
      Response res = await MyTripsRepo.updateTripStatus(event.arguments as Map);
      CustomNavigator.pop();
      if (res.statusCode == 200) {
        MyTripsBloc.instance
            .add(Update(arguments: (event.arguments as Map)["id"] as int));
        AppCore.showSnackBar(
          notification: AppNotification(
              message: allTranslations.text("status_updated_successfully"),
              backgroundColor: Styles.ACTIVE,
              borderColor: Styles.GREEN,
              isFloating: true),
        );
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
