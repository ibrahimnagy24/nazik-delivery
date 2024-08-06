import 'package:flutter/material.dart';
import 'package:flutter_base/features/my_refunds/model/refunds_model.dart';
import 'package:flutter_base/helpers/styles.dart';
import 'package:flutter_base/helpers/text_styles.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';
import 'package:flutter_base/navigation/routes.dart';
import 'package:flutter_base/utility/extensions.dart';

class HomeRefundRequestCard extends StatelessWidget {
  const HomeRefundRequestCard(
      {super.key, this.model, this.isDeliveryMoney = false});
  final RefundModel? model;
  final bool isDeliveryMoney;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomNavigator.push(Routes.REFUND_DETAILS, arguments: model?.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        decoration: BoxDecoration(
            color: Styles.WHITE_COLOR,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Styles.BORDER_COLOR)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Refund Number
            Text(
              "#${model?.refundNumber}",
              style: AppTextStyles.w600.copyWith(
                fontSize: 14,
                color: Styles.HEADER,
              ),
            ),

            ///Refund Amount
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: "${allTranslations.text("refund_amount")}: ",
                  style: AppTextStyles.w600
                      .copyWith(fontSize: 14, color: Styles.HEADER),
                  children: [
                    TextSpan(
                      text: "${model?.refundAmount ?? 0} \$",
                      style: AppTextStyles.w400.copyWith(
                        fontSize: 14,
                        color: Styles.SUB_HEADER,
                      ),
                    )
                  ],
                ),
              ),
            ),

            ///Refund Product
            if (isDeliveryMoney)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: "${allTranslations.text("products")}: ",
                    style: AppTextStyles.w600
                        .copyWith(fontSize: 14, color: Styles.HEADER),
                    children: [
                      TextSpan(
                        text: model?.items
                                ?.map((e) => e.title)
                                .toList()
                                .join(", ") ??
                            "",
                        style: AppTextStyles.w400.copyWith(
                          fontSize: 14,
                          color: Styles.SUB_HEADER,
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ///Address
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: "${allTranslations.text("address")}: ",
                style: AppTextStyles.w600
                    .copyWith(fontSize: 14, color: Styles.HEADER, height: 1),
                children: [
                  TextSpan(
                    text: model?.address ?? "",
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 14,
                      color: Styles.SUB_HEADER,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
