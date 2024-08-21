import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_core.dart';
import '../../../core/app_event.dart';
import '../../../core/app_notification.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../model/requests_model.dart';
import '../../../navigation/custom_navigation.dart';
import '../repo/request_details_repo.dart';

class RequestDetailsBloc extends Bloc<AppEvent, AppState> {
  RequestDetailsBloc() : super(Start()) {
    on<Click>(onClick);
  }

  static RequestDetailsBloc get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);


  onClick(Click event, Emitter emit) async {
    try {
      emit(Loading());

      Response res =
          await RequestDetailsRepo.requestDetails(event.arguments as int);
      if (res.statusCode == 200 &&
          res.data != null &&
          res.data["data"] != null &&
          res.data["data"].isNotEmpty) {
        RequestModel model = RequestModel.fromJson(res.data["data"][0]);
        emit(Done(model: model));
      } else {
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
