import 'package:flutter/material.dart';
import 'package:flutter_base/widgets/nav_app.dart';

import '../core/app_event.dart';
import '../model/search_engine.dart';
import 'home/bloc/home_items_bloc.dart';
import 'home/view/home_view.dart';
import 'more/view/more_view.dart';
import 'notifications/bloc/notifications_bloc.dart';
import 'notifications/view/notifications_view.dart';
import 'requests/bloc/requests_bloc.dart';
import 'requests/view/requests_view.dart';

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
    _index = widget.index;
    super.initState();
  }

  initData() {
    HomeItemsBloc.instance.add(Click(arguments: SearchEngine()));
    NotificationsBloc.instance.add(Click(arguments: SearchEngine()));
    RequestsBloc.instance.add(Click(arguments: SearchEngine()));
  }

  Widget fregmant(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const RequestsView();
      case 2:
        return const NotificationsView();
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
