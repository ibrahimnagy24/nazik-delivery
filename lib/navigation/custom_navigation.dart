import 'package:flutter/material.dart';
import 'package:flutter_base/features/auth/forget_password/view/forget_password_view.dart';
import 'package:flutter_base/features/auth/otp/view/otp_view.dart';
import 'package:flutter_base/features/auth/reset_password/view/reset_password_view.dart';
import 'package:flutter_base/features/auth/login/view/login.dart';
import 'package:flutter_base/features/edit_profile/view/edit_profile_view.dart';
import 'package:flutter_base/features/privacy/view/policy_view.dart';
import 'package:flutter_base/features/request_details/view/request_details_view.dart';
import 'package:flutter_base/features/splash/splash.dart';
import 'package:flutter_base/features/main_page.dart';
import 'package:flutter_base/features/terms_conditions/view/terms_view.dart';
import '../features/change_password/view/change_password_view.dart';
import '../main.dart';
import 'routes.dart';

const begin = Offset(0.0, 1.0);
const end = Offset.zero;
const curve = Curves.bounceInOut;
var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

abstract class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.APP:
        return pageRouteBuilder(const MyApp());
      case Routes.SPLASH:
        return pageRouteBuilder(const Splash());

      case Routes.LOGIN:
        return pageRouteBuilder(const Login());

      case Routes.FORGET_PASSWORD:
        return pageRouteBuilder(const ForgetPasswordView());

      case Routes.CHANGE_PASSWORD:
        return pageRouteBuilder(const ChangePasswordView());

      case Routes.EDIT_PROFILE:
        return pageRouteBuilder(const EditProfileView());

      case Routes.OTP:
        return pageRouteBuilder(OtpView(email: settings.arguments as String));

      case Routes.RESET_PASSWORD:
        return pageRouteBuilder(
            ResetPasswordView(email: settings.arguments as String));

      case Routes.MAIN_PAGE:
        return pageRouteBuilder(
          MainPage(
              index:
                  settings.arguments != null ? settings.arguments as int : 0),
        );

      case Routes.TERMS:
        return pageRouteBuilder(const TermsConditionsView());

      case Routes.REQUEST_DETAILS:
        return pageRouteBuilder(
            RequestDetailsView(id: settings.arguments as int));

      case Routes.PRIVACY:
        return pageRouteBuilder(const PrivacyPolicyView());

      default:
        return MaterialPageRoute(builder: (_) => const MyApp());
    }
  }

  static pageRouteBuilder(Widget child) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );

  static pop({dynamic result}) {
    if (navigatorState.currentState?.canPop() == true) {
      navigatorState.currentState?.pop(result);
    }
  }

  static push(
    String routeName, {
    arguments,
    bool replace = false,
    bool clean = false,
  }) {
    if (clean) {
      return navigatorState.currentState?.pushNamedAndRemoveUntil(
        routeName,
        (_) => false,
        arguments: arguments,
      );
    } else if (replace) {
      return navigatorState.currentState?.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    } else {
      return navigatorState.currentState?.pushNamed(
        routeName,
        arguments: arguments,
      );
    }
  }
}
