import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/helpers/styles.dart';
import 'package:flutter_base/helpers/text_styles.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/model/items_model.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, this.model});
  final ItemModel? model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Styles.BORDER_COLOR)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model?.name ?? "Name",
            style: AppTextStyles.w600.copyWith(
              fontSize: 16,
              color: Styles.HEADER,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(
              children: [
                ///Price
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "${allTranslations.text("price")} ",
                      style: AppTextStyles.w400
                          .copyWith(fontSize: 14, color: Styles.HEADER),
                      children: [
                        TextSpan(
                          text: "${model?.price ?? "0"}\$",
                          style: AppTextStyles.w600.copyWith(
                              fontSize: 14, color: Styles.PRIMARY_COLOR),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///Color
              RichText(
                text: TextSpan(
                  text: "${allTranslations.text("color")} ",
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 14, color: Styles.HEADER),
                  children: [
                    TextSpan(
                      text: model?.color ?? "red",
                      style: AppTextStyles.w600
                          .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
                    )
                  ],
                ),
              ),

              ///Size
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    allTranslations.text("size"),
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 14,
                      color: Styles.HEADER,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Styles.WHITE_COLOR,
                        border: Border.all(color: Styles.BORDER_COLOR)),
                    child: Text(
                      model?.size ?? "M",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                        color: Styles.HEADER,
                      ),
                    ),
                  ),
                ],
              ),

              ///Quantity
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    allTranslations.text("quantity"),
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 14,
                      color: Styles.HEADER,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Styles.WHITE_COLOR,
                        border: Border.all(color: Styles.BORDER_COLOR)),
                    child: Text(
                      model?.quantity ?? "3",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                        color: Styles.HEADER,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
          RichText(
            text: TextSpan(
              text: "${allTranslations.text("link")} ",
              style: AppTextStyles.w600
                  .copyWith(fontSize: 14, color: Styles.HEADER),
              children: [
                TextSpan(
                    text: model?.link ?? "www.zara.com",
                    style: AppTextStyles.w400.copyWith(
                        fontSize: 14,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        launchUrl(Uri.parse("www.zara.com"));
                      })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
