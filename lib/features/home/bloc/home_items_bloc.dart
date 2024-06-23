import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_core.dart';
import '../../../core/app_event.dart';
import '../../../core/app_notification.dart';
import '../../../core/app_state.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../model/items_model.dart';
import '../../../model/search_engine.dart';
import '../../../navigation/custom_navigation.dart';
import '../repo/home_repo.dart';
import '../widgets/item_card.dart';

class HomeItemsBloc extends Bloc<AppEvent, AppState> {
  static HomeItemsBloc get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  HomeItemsBloc() : super(Start()) {
    on<Click>(onClick);
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

      ItemsModel model = await HomeRepo.getHomeRequests(_engine);
      if (model.status == 200) {
        if (model.requests!.isNotEmpty) {
          for (var v in model.requests!) {
            _cards.add(ItemCard(model: v));
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
}
