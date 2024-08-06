import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/features/my_refunds/model/refunds_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/app_core.dart';
import '../../../core/app_event.dart';
import '../../../core/app_notification.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../model/search_engine.dart';
import '../../../navigation/custom_navigation.dart';
import '../repo/home_repo.dart';
import '../widgets/refunds/home_refund_request_card.dart';

class HomeRefundsRequestsBloc extends Bloc<AppEvent, AppState> {
  static HomeRefundsRequestsBloc get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  HomeRefundsRequestsBloc() : super(Start()) {
    updateSelectIndex(0);
    on<Click>(onClick);
    on<Update>(onUpdate);
  }

  late SearchEngine _engine;
  final List<Widget> _cards = [];

  List<String> tabs = ["receiving_order", "deliver_money"];

  final selectIndex = BehaviorSubject<int>();
  Function(int) get updateSelectIndex => selectIndex.sink.add;
  Stream<int> get selectIndexStream => selectIndex.stream.asBroadcastStream();

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
      if (selectIndex.value == 0) {
        _engine.query = "approved";
      } else {
        _engine.query = "awaiting_money";
      }
      if (_engine.currentPage == 0) {
        _cards.clear();
        emit(Loading());
      } else {
        emit(Done(cards: _cards, loading: true));
      }

      RefundsModel model = await HomeRepo.getHomeRefundsRequests(_engine);
      if (model.status == 200) {
        if (model.refunds!.isNotEmpty) {
          for (var v in model.refunds!) {
            _cards.add(HomeRefundRequestCard(
              key: ValueKey(v.id),
              model: v,
              isDeliveryMoney: selectIndex.valueOrNull == 1,
            ));
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

  ///Update Cards When Delete a card
  Future<void> onUpdate(Update event, Emitter<AppState> emit) async {
    _cards.removeWhere((e) =>
        (e.key as ValueKey<int?>).value ==
        ValueKey(event.arguments as int).value);
    if (_cards.isNotEmpty) {
      emit(Done(cards: _cards));
    } else {
      emit(Empty());
    }
  }
}
