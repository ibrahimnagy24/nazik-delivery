import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/helpers/styles.dart';
import 'package:flutter_base/helpers/text_styles.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/model/requests_model.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';
import 'package:flutter_base/navigation/routes.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import 'change_request_status.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key, this.model});
  final RequestModel? model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomNavigator.push(Routes.REQUEST_DETAILS, arguments: model?.id);
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
            Row(
              children: [
                Expanded(
                  child: Text(
                    "#${model?.orderNumber}",
                    style: AppTextStyles.w600.copyWith(
                      fontSize: 14,
                      color: Styles.HEADER,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                // ///Request Status
                // Container(
                //   padding:
                //       EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                //   alignment: Alignment.center,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(100),
                //     color:
                //         Styles.requestStatus(model?.status).withOpacity(0.08),
                //   ),
                //   child: Text(
                //     allTranslations.text(model?.status?.name ?? ""),
                //     textAlign: TextAlign.center,
                //     style: AppTextStyles.w600.copyWith(
                //       fontSize: 14,
                //       height: 1.2,
                //       color: Styles.requestStatus(model?.status),
                //     ),
                //   ),
                // ),
              ],
            ),

            ///Products
            if (model?.items != null && model!.items!.isNotEmpty)
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

            ///Phone Number
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
                        text: model?.mobileNumber ?? "",
                        style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            launchUrl(Uri.parse('tel: ${model?.mobileNumber}'));
                          })
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
                    .copyWith(fontSize: 14, color: Styles.HEADER),
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
                      text: model?.deliveryRate ?? "",
                      style: AppTextStyles.w400.copyWith(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ),

            if (model?.status != null &&
                model?.status != RequestStatus.amountCollected &&
                model?.status != RequestStatus.completed)
              ChangeRequestStatus(
                id: model?.id,
                status: model!.status!,
                deliveredDeposit: model!.deliveredDeposit == true,
              ),
          ],
        ),
      ),
    );
  }
}
