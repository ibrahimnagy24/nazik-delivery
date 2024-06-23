import 'package:dio/dio.dart';
import 'package:flutter_base/components/custom_simple_dialog.dart';
import 'package:flutter_base/features/home/bloc/home_items_bloc.dart';
import 'package:flutter_base/features/home/widgets/confirm_dialog.dart';
import 'package:flutter_base/model/search_engine.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/app_core.dart';
import '../../../../core/app_event.dart';
import '../../../../core/app_notification.dart';
import '../../../../core/app_state.dart';
import '../../../../helpers/styles.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../../navigation/custom_navigation.dart';
import '../repo/home_repo.dart';

class PurchaseBloc extends Bloc<AppEvent, AppState> {
  static PurchaseBloc get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  PurchaseBloc() : super(Start()) {
    on<Click>(onClick);
    updateItems([]);
  }

  final items = BehaviorSubject<List<int>?>();
  Function(List<int>?) get updateItems => items.sink.add;
  Stream<List<int>?> get itemsStream => items.stream.asBroadcastStream();

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      Response res = await HomeRepo.purchase({});
      updateItems([]);

      if (res.statusCode == 200) {
        HomeItemsBloc.instance.add(Click(arguments: SearchEngine()));
        AppCore.showSnackBar(
            notification: AppNotification(
                message: allTranslations
                    .text("your_request_has_been_created_successfully"),
                backgroundColor: Styles.ACTIVE,
                borderColor: Styles.GREEN,
                isFloating: true));
        emit(Done());
      } else if (res.statusCode == 500) {
        CustomSimpleDialog.parentSimpleDialog(
            widget: const ConfirmDialog(
          message: "df",
          id: [1, 2],
        ));
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
