import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/user_bloc.dart';
import '../../../core/app_core.dart';
import '../../../core/app_event.dart';
import '../../../core/app_notification.dart';
import '../../../core/app_state.dart';
import '../../../helpers/shared_helper.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../navigation/custom_navigation.dart';
import '../../auth/login/model/user_model.dart';
import '../repo/profile_repo.dart';

class ProfileBloc extends Bloc<AppEvent, AppState> {
  ProfileBloc() : super(Start()) {
    on<Click>(onClick);
  }

  static ProfileBloc get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  Future<void> onClick(Click event, Emitter emit) async {
    try {
      emit(Loading());

      Response res = await ProfileRepo.getProfile();
      if (res.statusCode == 200) {
        UserModel model = UserModel.fromJson(res.data["data"]);
        SharedHelper.sharedHelper!
            .writeData(CachingKey.USER, json.encode(model.toJson()));
        UserBloc.instance.add(Click());
        emit(Done());
      } else {
        AppCore.showSnackBar(
            notification: AppNotification(
                message: allTranslations.text("something_went_wrong"),
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Styles.DARK_RED,
                iconName: "fill-close-circle"));
        emit(Error());
      }
    } catch (e) {
      emit(Error());
    }
  }
}
