import 'package:flutter/material.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/features/trips/model/trips_model.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_event.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../model/search_engine.dart';
import '../../../widgets/filter_option.dart';
import '../bloc/my_trips_bloc.dart';

class TripsTabs extends StatefulWidget {
  const TripsTabs({super.key});

  @override
  State<TripsTabs> createState() => _TripsTabsState();
}

class _TripsTabsState extends State<TripsTabs> {
  final List<GlobalKey> _globalKeys = [];

  static animatedRowScroll(BuildContext context) {
    Scrollable.ensureVisible(context,
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        alignment: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: BlocBuilder<MyTripsBloc, AppState>(
        builder: (context, state) {
          return StreamBuilder<TripsStatus>(
              stream: MyTripsBloc.instance.selectStatusStream,
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 12.h),
                      ...List.generate(
                        MyTripsBloc.instance.tabs.length,
                        (index) {
                          _globalKeys.add(GlobalKey(debugLabel: "$index"));
                          Future.delayed(const Duration(seconds: 1), () {
                            animatedRowScroll(_globalKeys[
                                        MyTripsBloc.instance.tabs[index] ==
                                                snapshot.data
                                            ? index
                                            : 0]
                                    .currentContext ??
                                context);
                          });
                          return InkWell(
                            key: _globalKeys[index],
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (state is! Loading) {
                                MyTripsBloc.instance.updateSelectStatus(
                                    MyTripsBloc.instance.tabs[index]);
                                MyTripsBloc.instance
                                    .add(Click(arguments: SearchEngine()));
                              }
                            },
                            child: FilterOption(
                              title: allTranslations.text(
                                  MyTripsBloc.instance.tabs[index].name ==
                                          "completed"
                                      ? "end_trip"
                                      : MyTripsBloc.instance.tabs[index].name),
                              isSelect: MyTripsBloc.instance.tabs[index] ==
                                  snapshot.data,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
