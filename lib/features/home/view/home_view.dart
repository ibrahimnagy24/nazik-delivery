import 'package:flutter/material.dart';
import '../widgets/home_body.dart';
import '../widgets/home_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(),
          HomeBody(),
        ],
      ),
    );
  }
}
