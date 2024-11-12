import 'package:flutter/material.dart';
import 'package:flutter_base/features/trips/view/my_trips_view.dart';
import 'package:flutter_base/widgets/nav_app.dart';

import '../bloc/user_bloc.dart';
import '../core/app_event.dart';
import 'more/view/more_view.dart';
import 'my_refunds/view/my_refunds_view.dart';
import 'my_requests/view/my_requests_view.dart';

class MainPage extends StatefulWidget {
  final int index;

  const MainPage({super.key, this.index = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  int _index = 0;

  @override
  void initState() {
    initData();
    _index = widget.index;
    super.initState();
  }

  initData() {
    UserBloc.instance.add(Click());
  }

  Widget fregmant(int index) {
    switch (index) {
      // case 0:
      //   return const HomeView();
      case 0:
        return const MyTripsView();
      case 1:
        return const MyRequestsView();
      case 2:
        return const MyRefundsView();
      case 3:
        return const MoreView();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: fregmant(_index),
      bottomNavigationBar: NavApp(
        index: _index,
        onSelect: (p0) {
          _index = p0;
          setState(() {});
        },
      ),
    );
  }
}
