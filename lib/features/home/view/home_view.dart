import 'package:flutter/material.dart';
import '../../../core/app_event.dart';
import '../../../core/app_state.dart';
import '../../../model/search_engine.dart';
import '../bloc/home_requests_bloc.dart';
import '../widgets/home_body.dart';
import '../widgets/home_header.dart';
import '../widgets/home_tabs.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    if (HomeRequestsBloc.instance.state is! Done) {
      HomeRequestsBloc.instance.add(Click(arguments: SearchEngine()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(),
          HomeTabs(),
          HomeBody(),
        ],
      ),
    );
  }
}
