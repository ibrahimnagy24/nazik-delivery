import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_btn.dart';
import 'package:flutter_base/core/app_state.dart';
import 'package:flutter_base/features/trips/model/trips_model.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_event.dart';
import '../../../helpers/translation/all_translation.dart';
import '../bloc/update_trip_status_bloc.dart';

class UpdateTripStatus extends StatelessWidget {
  const UpdateTripStatus({super.key, required this.id, required this.status});
  final String status;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: BlocProvider(
        create: (context) => UpdateTripStatusBloc(),
        child: BlocBuilder<UpdateTripStatusBloc, AppState>(
          builder: (context, state) {
            return CustomBtn(
              height: 35,
              radius: 100,
              fontSize: 13,
              text: allTranslations.text(
                  status == TripsStatus.out_for_delivery.name
                      ? "end_trip"
                      : "start_trip"),
              onPressed: () =>
                  context.read<UpdateTripStatusBloc>().add(Click(arguments: {
                        "id": id,
                        "status": (status == TripsStatus.out_for_delivery.name)
                            ? "completed"
                            : "out_for_delivery"
                      })),
            );
          },
        ),
      ),
    );
  }
}
