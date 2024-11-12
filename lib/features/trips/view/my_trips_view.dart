import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_app_bar.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import '../../../core/app_event.dart';
import '../../../model/search_engine.dart';
import '../bloc/my_trips_bloc.dart';
import '../widgets/trips_body.dart';
import '../widgets/trips_tabs.dart';

class MyTripsView extends StatefulWidget {
  const MyTripsView({super.key});

  @override
  State<MyTripsView> createState() => _MyTripsViewState();
}

class _MyTripsViewState extends State<MyTripsView> {
  @override
  void initState() {
    MyTripsBloc.instance.add(Click(arguments: SearchEngine()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: allTranslations.text("trips"),
        withBack: false,
      ),
      body: const Column(
        children: [
          TripsTabs(),
          RequestsBody(),
        ],
      ),
    );
  }
}
