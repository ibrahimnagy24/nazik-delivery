import 'package:flutter/material.dart';
import 'package:flutter_base/helpers/styles.dart';
import 'package:flutter_base/helpers/text_styles.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/model/requests_model.dart';
import 'package:flutter_base/utility/extensions.dart';

import '../model/trips_model.dart';
import 'update_trip_status.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, this.model});
  final TripModel? model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Styles.BORDER_COLOR)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Trip Number
          Text(
            "#${model?.number}",
            style: AppTextStyles.w600.copyWith(
              fontSize: 18,
              color: Styles.PRIMARY_COLOR,
            ),
          ),

          ///Name
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: "${allTranslations.text("trip_name")}: ",
                style: AppTextStyles.w600
                    .copyWith(fontSize: 16, color: Styles.HEADER),
                children: [
                  TextSpan(
                    text: model?.name ?? "",
                    style: AppTextStyles.w400.copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
          ),

          if (model?.status != null &&
              model?.status != RequestStatus.completed.name)
            UpdateTripStatus(
              id: model?.id,
              status: model!.status!,
            ),
        ],
      ),
    );
  }
}
