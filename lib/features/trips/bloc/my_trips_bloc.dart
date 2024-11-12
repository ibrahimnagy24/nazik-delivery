import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/features/trips/model/trips_model.dart';
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
import '../repo/my_trips_repo.dart';
import '../widgets/trip_card.dart';

class MyTripsBloc extends Bloc<AppEvent, AppState> {
  static MyTripsBloc get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  MyTripsBloc() : super(Start()) {
    updateSelectStatus(TripsStatus.awaiting_to_be_delivered);
    on<Update>(onUpdate);
    on<Click>(onClick);
  }

  List<TripsStatus> tabs = [
    TripsStatus.awaiting_to_be_delivered,
    TripsStatus.out_for_delivery,
    TripsStatus.completed,
  ];

  final selectStatus = BehaviorSubject<TripsStatus>();
  Function(TripsStatus) get updateSelectStatus => selectStatus.sink.add;
  Stream<TripsStatus> get selectStatusStream =>
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

      TripsModel model =
          await MyTripsRepo.getTrips(data: _engine, status: selectStatus.value);
      if (model.status == 200) {
        if (model.trips!.isNotEmpty) {
          for (var v in model.trips!) {
            _cards.add(TripCard(key: ValueKey(v.id), model: v));
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
