import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

import '../bloc/user_bloc.dart';
import '../features/home/bloc/home_purchases_requests_bloc.dart';
import '../features/home/bloc/home_refunds_requests_bloc.dart';
import '../features/my_refunds/bloc/my_money_refunds_bloc.dart';
import '../features/my_refunds/bloc/my_order_refunds_bloc.dart';
import '../features/my_requests/bloc/my_requests_bloc.dart';
import '../features/notifications/bloc/notifications_bloc.dart';
import '../features/profile/bloc/profile_bloc.dart';
import '../features/splash/splash_bloc.dart';
import '../features/trips/bloc/my_trips_bloc.dart';
import '../utility/keybord_lisenter.dart';

abstract class ProviderList {
  static List<BlocProvider> providers = [
    BlocProvider<SplashBloc>(create: (_) => SplashBloc()),
    BlocProvider<UserBloc>(create: (_) => UserBloc()),
    BlocProvider<KeyBordBloc>(create: (_) => KeyBordBloc()),
    BlocProvider<HomePurchasesRequestsBloc>(
        create: (_) => HomePurchasesRequestsBloc()),
    BlocProvider<NotificationsBloc>(create: (_) => NotificationsBloc()),
    BlocProvider<MyTripsBloc>(create: (_) => MyTripsBloc()),
    BlocProvider<MyRequestsBloc>(create: (_) => MyRequestsBloc()),

    ///Refunds
    BlocProvider<HomeRefundsRequestsBloc>(
        create: (_) => HomeRefundsRequestsBloc()),
    BlocProvider<MyMoneyRefundsBloc>(create: (_) => MyMoneyRefundsBloc()),
    BlocProvider<MyOrderRefundsBloc>(create: (_) => MyOrderRefundsBloc()),
    BlocProvider<ProfileBloc>(create: (_) => ProfileBloc()),
  ];
}
