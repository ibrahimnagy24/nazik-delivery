import 'package:flutter_base/features/auth/login/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/app_event.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/helpers/shared_helper.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';

class UserBloc extends Bloc<AppEvent, AppState> {
  UserModel? _model;

  UserModel? get user => _model;

  UserBloc() : super(Start()) {
    on<Click>(onClick);
    on<Update>(onUpdate);
  }

  static UserBloc get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  Future<void> onClick(AppEvent event, Emitter emit) async {
    emit(Loading());
    try {
      UserModel sharedModel = await SharedHelper.sharedHelper!.getUser();
      _model = sharedModel;
      emit(Done(model: sharedModel));
    } catch (e) {
      emit(Error());
    }
  }

  Future<void> onUpdate(AppEvent event, Emitter emit) async {
    emit(Loading());
    try {
      UserModel sharedModel = await SharedHelper.sharedHelper!.getUser();
      _model = sharedModel;
      emit(Done(model: sharedModel, reload: false));
    } catch (e) {
      emit(Error());
    }
  }
}
