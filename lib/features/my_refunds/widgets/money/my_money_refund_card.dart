import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_base/utility/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../helpers/styles.dart';

import '../../../../helpers/text_styles.dart';
import '../../../../helpers/translation/all_translation.dart';
import '../../model/refunds_model.dart';
import 'update_money_refund_actions.dart';

class MyMoneyRefundCard extends StatelessWidget {
  const MyMoneyRefundCard({super.key, required this.model});
  final RefundModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Styles.BORDER_COLOR)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "#${model.refundNumber ?? "c"}",
            style: AppTextStyles.w600.copyWith(
              fontSize: 16,
              color: Styles.HEADER,
            ),
          ),

          ///Mobile Number
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: "${allTranslations.text("phone")}: ",
                style: AppTextStyles.w600
                    .copyWith(fontSize: 14, color: Styles.HEADER),
                children: [
                  TextSpan(
                      text: model.mobileNumber ?? "",
                      style: AppTextStyles.w400.copyWith(
                          fontSize: 14,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          launchUrl(Uri.parse('tel: ${model.mobileNumber}'));
                        })
                ],
              ),
            ),
          ),

          ///Address
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: "${allTranslations.text("address")}: ",
                style: AppTextStyles.w600
                    .copyWith(fontSize: 14, color: Styles.HEADER),
                children: [
                  TextSpan(
                    text: model.address ?? "",
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 14,
                      color: Styles.SUB_HEADER,
                    ),
                  )
                ],
              ),
            ),
          ),

          ///Delivery Rate
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: "${allTranslations.text("delivery_rate")}: ",
                style: AppTextStyles.w600
                    .copyWith(fontSize: 14, color: Styles.HEADER),
                children: [
                  TextSpan(
                    text: model.deliveryRate ?? "",
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          ),

          ///Refund Amount
          RichText(
            text: TextSpan(
              text: "${allTranslations.text("refund_amount")} ",
              style: AppTextStyles.w400
                  .copyWith(fontSize: 14, color: Styles.SUB_HEADER),
              children: [
                TextSpan(
                  text: "${model.refundAmount}\$",
                  style: AppTextStyles.w600.copyWith(
                    fontSize: 14,
                    color: Styles.PRIMARY_COLOR,
                  ),
                )
              ],
            ),
          ),
          if (model.status != RefundStatus.del_completed &&
              model.status != null)
            UpdateMoneyRefundActions(
              id: model.id ?? 0,
              status: model.status!,
            )
        ],
      ),
    );
  }
}
