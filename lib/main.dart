import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/config/colors/light_colors.dart';
import 'package:flutter_base/config/themes/themes.dart';
import 'package:flutter_base/utility/un_focus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_base/helpers/shared_helper.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/helpers/translation/translations.dart';
import 'package:flutter_base/bloc/main_app_bloc.dart';
import 'config/providers.dart';
import 'firebase_options.dart';
import 'helpers/notification_helper/notification_helper.dart';
import 'helpers/styles.dart';
import 'navigation/custom_navigation.dart';
import 'navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedHelper.init();
  FirebaseNotifications.setUpFirebase();
  await allTranslations.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    mainAppBloc.getShared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return MultiBlocProvider(
      providers: ProviderList.providers,
      child: StreamBuilder<String>(
        stream: mainAppBloc.langStream,
        builder: (context, lang) {
          return lang.hasData
              ? MaterialApp(
                  builder: (context, child) => MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: const TextScaler.linear(1),
                    ),
                    child: Unfocus(child: child!),
                  ),
                  initialRoute: Routes.SPLASH,
                  navigatorKey: CustomNavigator.navigatorState,
                  onGenerateRoute: CustomNavigator.onCreateRoute,
                  navigatorObservers: [CustomNavigator.routeObserver],
                  debugShowCheckedModeBanner: false,
                  scaffoldMessengerKey: CustomNavigator.scaffoldState,
                  locale: Locale(lang.data!, ''),
                  supportedLocales: allTranslations.supportedLocales(),
                  localizationsDelegates: const [
                    TranslationsDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  title: "Nazik Delivery",
                  themeMode: ThemeMode.light,
                  theme: Themes.lightTheme().themeData.copyWith(
                        appBarTheme:
                            Themes.lightTheme().themeData.appBarTheme.copyWith(
                                  iconTheme: const IconThemeData(
                                    color: LightColor.black,
                                  ),
                                  titleTextStyle: TextStyle(
                                    color: LightColor.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: lang.data == 'en'
                                        ? Styles.FONT_EN
                                        : Styles.FONT_AR,
                                  ),
                                ),
                        textTheme:
                            Themes.lightTheme().themeData.textTheme.apply(
                                  fontFamily: lang.data == 'en'
                                      ? Styles.FONT_EN
                                      : Styles.FONT_AR,
                                ),
                      ),
                )
              : Container();
        },
      ),
    );
  }
}
