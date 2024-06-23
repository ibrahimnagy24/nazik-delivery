import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_core.dart';
import '../../../core/app_event.dart';
import '../../../core/app_notification.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../model/search_engine.dart';
import '../../../navigation/custom_navigation.dart';
import '../model/notifications_model.dart';
import '../repo/notification_repo.dart';
import '../widgets/notifications_card.dart';

class NotificationsBloc extends Bloc<AppEvent, AppState> {
  static NotificationsBloc get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  NotificationsBloc() : super(Start()) {
    on<Click>(onClick);
    on<Read>(onRead);
  }

  late SearchEngine _engine;
  final List<Widget> _cards = [];

  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = AppCore.scrollListener(
          controller, _engine.maxPages, _engine.currentPage);
      if (scroll) {
        _engine.updateCurrentPage(_engine.currentPage);
        add(Click(arguments: _engine));
      }
    });
  }

  onClick(Click event, Emitter emit) async {
    try {
      _engine = event.arguments as SearchEngine;
      if (_engine.currentPage == 0) {
        _cards.clear();
        emit(Loading());
      } else {
        emit(Done(cards: _cards, loading: true));
      }

      NotificationsModel model =
          await NotificationsRepo.getNotifications(_engine);
      if (model.status == 200) {
        if (model.data!.isNotEmpty) {
          for (var v in model.data!) {
            _cards.add(NotificationCard(notification: v));
          }
          _engine.maxPages = model.meta?.lastPage ?? 1;
          _engine.updateCurrentPage(model.meta?.currPage ?? 1);
          emit(Done(cards: _cards, loading: false));
        } else {
          emit(Empty());
        }
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

  Future<void> onRead(Read event, Emitter<AppState> emit) async {
    await NotificationsRepo.readNotification(event.arguments as String);
  }
}
