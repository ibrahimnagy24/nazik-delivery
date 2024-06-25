import 'package:flutter/material.dart';
import 'package:flutter_base/helpers/styles.dart';
import 'package:flutter_base/helpers/text_styles.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/model/items_model.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';
import 'package:flutter_base/navigation/routes.dart';
import 'package:flutter_base/utility/extensions.dart';

import '../features/my_requests/widgets/change_request_status.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key, this.model, this.fromMyRequest = false});
  final RequestModel? model;
  final bool fromMyRequest;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!fromMyRequest) {
          CustomNavigator.push(Routes.REQUEST_DETAILS, arguments: model?.id);
        }
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
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: "${allTranslations.text("order_id")}: ",
                      style: AppTextStyles.w600
                          .copyWith(fontSize: 14, color: Styles.HEADER),
                      children: [
                        TextSpan(
                          text: "#10",
                          style: AppTextStyles.w400.copyWith(
                            fontSize: 14,
                            color: Styles.SUB_HEADER,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                ///Request Status
                if (fromMyRequest)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color:
                          Styles.requestStatus(model?.status).withOpacity(0.08),
                    ),
                    child: Text(
                      allTranslations.text(model?.status?.name ?? ""),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                        height: 1.2,
                        color: Styles.requestStatus(model?.status),
                      ),
                    ),
                  ),
              ],
            ),

            ///Products
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
                              ?.map((e) => e.name)
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
            if (fromMyRequest)
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
                        text: model?.phoneNumber ?? "01010101010",
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
                    .copyWith(fontSize: 14, color: Styles.HEADER),
                children: [
                  TextSpan(
                    text: "www.zara.com",
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 14,
                      color: Styles.SUB_HEADER,
                    ),
                    // recognizer: TapGestureRecognizer()
                    //   ..onTap = () async {
                    //     launchUrl(Uri.parse("www.zara.com"));
                    //   },
                  )
                ],
              ),
            ),

            if (fromMyRequest && model?.status != RequestStatus.done)
              ChangeRequestStatus(
                id: model?.id,
                status: model?.status,
              ),
          ],
        ),
      ),
    );
  }
}
