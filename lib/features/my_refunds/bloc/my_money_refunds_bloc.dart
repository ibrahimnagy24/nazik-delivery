import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/features/my_refunds/repo/my_refunds_repo.dart';
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
import '../model/refunds_model.dart';
import '../widgets/money/my_money_refund_card.dart';

class MyMoneyRefundsBloc extends Bloc<AppEvent, AppState> {
  static MyMoneyRefundsBloc get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  MyMoneyRefundsBloc() : super(Start()) {
    updateSelectStatus(RefundStatus.awaiting_money_picked);
    on<Click>(onClick);
    on<Update>(onUpdate);
  }

  List<RefundStatus> moneyStatus = [
    RefundStatus.awaiting_money,
    RefundStatus.awaiting_money_picked,
    RefundStatus.money_picked,
    RefundStatus.money_transit,
    RefundStatus.del_completed
  ];

  int getStatusIndex(RefundStatus status) {
    return moneyStatus.indexOf(status);
  }

  final selectStatus = BehaviorSubject<RefundStatus>();
  Function(RefundStatus) get updateSelectStatus => selectStatus.sink.add;
  Stream<RefundStatus> get selectStatusStream =>
      selectStatus.stream.asBroadcastStream();

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

      RefundsModel model = await MyRefundRepo.getMyRefund(
          data: _engine, status: selectStatus.value);
      if (model.status == 200) {
        if (model.refunds!.isNotEmpty) {
          for (var v in model.refunds!) {
            _cards.add(MyMoneyRefundCard(key: ValueKey(v.id), model: v));
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
    if (event.arguments != null) {
      _cards.removeWhere((e) =>
          (e.key as ValueKey<int?>).value ==
          ValueKey(event.arguments as int).value);
    }
    if (_cards.isNotEmpty) {
      emit(Done(cards: _cards));
    } else {
      emit(Empty());
    }
  }
}
