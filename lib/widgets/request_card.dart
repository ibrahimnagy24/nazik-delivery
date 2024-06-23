import 'package:flutter/material.dart';
import 'package:flutter_base/helpers/styles.dart';
import 'package:flutter_base/helpers/text_styles.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/model/items_model.dart';
import 'package:flutter_base/utility/extensions.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key, this.model});
  final RequestModel? model;

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
          Text(
            "#${model?.id ?? 0}",
            style: AppTextStyles.w600.copyWith(
              fontSize: 16,
              color: Styles.HEADER,
            ),
          ),
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
                    text:
                        model?.items?.map((e) => e.name).toList().join(", ") ??
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
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: "${allTranslations.text("address")} ",
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
        ],
      ),
    );
  }
}
