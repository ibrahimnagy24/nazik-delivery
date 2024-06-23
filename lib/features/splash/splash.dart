import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_base/components/animated_widget.dart';
import 'package:flutter_base/core/app_event.dart';
import 'package:flutter_base/features/splash/splash_bloc.dart';
import 'package:flutter_base/utility/extensions.dart';

import '../../helpers/styles.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      SplashBloc.instance.add(Click());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.WHITE_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: AnimatedWidgets(
                  durationMilli: 2000,
                  verticalOffset: 0.0,
                  horizontalOffset: 0.0,
                  child: Styles.splash,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: AnimatedWidgets(
                durationMilli: 1500,
                verticalOffset: 20,
                horizontalOffset: 0.0,
                child: Text(
                  "Nazik",
                  style: TextStyle(
                    color: context.theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
