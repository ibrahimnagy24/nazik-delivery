import 'package:dio/dio.dart';
import 'package:flutter_base/model/search_engine.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_core.dart';
import '../../../../core/app_event.dart';
import '../../../../core/app_notification.dart';
import '../../../../core/app_state.dart';
import '../../../../helpers/styles.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../my_refunds/bloc/my_order_refunds_bloc.dart';
import '../../my_refunds/model/refunds_model.dart';
import '../repo/refund_details_repo.dart';

class AssignRefundItemBloc extends Bloc<AppEvent, AppState> {
  AssignRefundItemBloc() : super(Start()) {
    on<Click>(onClick);
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      Map<String, dynamic> data = {
        "status": "claimed_return",
        "refunds[0]": (event.arguments as Map<String, dynamic>)["id"],
      };

      Response res = await RefundDetailsRepo.refund(data);

      if (res.statusCode == 200) {
        AppCore.showSnackBar(
          notification: AppNotification(
              message: allTranslations.text("updated_successfully"),
              backgroundColor: Styles.ACTIVE,
              borderColor: Styles.GREEN,
              isFloating: true),
        );
        // HomeRefundsBloc.instance.add(
        //     Update(arguments: (event.arguments as Map<String, dynamic>)["id"]));
        ((event.arguments as Map<String, dynamic>)["onSuccess"] as Function())
            .call();

        ///To Update My Refunds after Assign Refund`
        MyOrderRefundsBloc.instance.updateSelectStatus(RefundStatus.del_completed);
        MyOrderRefundsBloc.instance.add(Click(arguments: SearchEngine()));
        emit(Done());
      } else if (res.statusCode == 422) {
        // HomeRefundsBloc.instance.add(Click(arguments: SearchEngine()));
        CustomNavigator.pop();
        AppCore.showSnackBar(
            notification: AppNotification(
                message: res.data["message"] ?? "",
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Styles.DARK_RED,
                iconName: "fill-close-circle"));
        emit(Start());
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
