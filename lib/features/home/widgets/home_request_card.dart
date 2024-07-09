import 'package:flutter/material.dart';
import 'package:flutter_base/helpers/styles.dart';
import 'package:flutter_base/helpers/text_styles.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/model/requests_model.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';
import 'package:flutter_base/navigation/routes.dart';
import 'package:flutter_base/utility/extensions.dart';

class HomeRequestCard extends StatelessWidget {
  const HomeRequestCard({super.key, this.model, this.isDeposit = false});
  final RequestModel? model;
  final bool isDeposit;

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
            ///Order Number
            Text(
              "#${model?.orderNumber}",
              style: AppTextStyles.w600.copyWith(
                fontSize: 14,
                color: Styles.HEADER,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: isDeposit
                  ? RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "${allTranslations.text("deposit_value")}: ",
                        style: AppTextStyles.w600
                            .copyWith(fontSize: 14, color: Styles.HEADER),
                        children: [
                          TextSpan(
                            text: "${model?.deposit ?? 0} \$",
                            style: AppTextStyles.w400.copyWith(
                              fontSize: 14,
                              color: Styles.SUB_HEADER,
                            ),
                          )
                        ],
                      ),
                    )
                  : RichText(
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
