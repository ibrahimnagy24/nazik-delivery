import 'package:dio/dio.dart';
import 'package:flutter_base/components/loading_dialog.dart';
import 'package:flutter_base/model/requests_model.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';
import 'package:flutter_base/navigation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/app_core.dart';
import 'package:flutter_base/core/app_event.dart';
import 'package:flutter_base/core/app_notification.dart';
import 'package:flutter_base/core/app_state.dart';
import '../../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../model/search_engine.dart';
import '../../home/bloc/home_purchases_requests_bloc.dart';
import '../repo/requests_repo.dart';
import 'my_requests_bloc.dart';

class UpdateRequestStatusBloc extends Bloc<AppEvent, AppState> {
  UpdateRequestStatusBloc() : super(Start()) {
    on<Click>(onClick);
  }

  Future<void> onClick(AppEvent event, Emitter emit) async {
    try {
      emit(Loading());
      showLoadingDialog();
      Response res =
          await MyRequestsRepo.updateRequestStatus(event.arguments as Map);
      CustomNavigator.pop();
      if (res.statusCode == 200) {
        AppCore.showSnackBar(
          notification: AppNotification(
              message: allTranslations.text("status_updated_successfully"),
              backgroundColor: Styles.ACTIVE,
              borderColor: Styles.GREEN,
              isFloating: true),
        );
        Map data = event.arguments as Map;
        if(data["fromRequestDetails"]){
          CustomNavigator.push(Routes.MAIN_PAGE,clean: true, arguments: 1);
          MyRequestsBloc.instance.updateSelectStatus(RequestStatus.completed);

        }
        MyRequestsBloc.instance.add(Update(arguments: data["id"]));
        HomePurchasesRequestsBloc.instance.add(Click(arguments: SearchEngine()));
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
