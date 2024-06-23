import 'package:flutter_base/helpers/shared_helper.dart';
import 'package:flutter_base/navigation/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/app_event.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';

class SplashBloc extends Bloc<AppEvent, AppState> {
  SplashBloc() : super(Start()) {
    on<Click>(onClick);
  }

  static SplashBloc get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  Future<void> onClick(AppEvent event, Emitter emit) async {
    emit(Loading());
    try {
      SharedHelper helper = SharedHelper();
      bool? isLogin = await helper.readBoolean(CachingKey.IS_LOGIN);
      if (isLogin) {
        CustomNavigator.push(Routes.MAIN_PAGE, clean: true);
      } else {
        CustomNavigator.push(Routes.LOGIN, clean: true);
      }
    } catch (e) {
      emit(Error());
    }
  }
}
