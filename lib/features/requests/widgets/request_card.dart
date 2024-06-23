import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/model/items_model.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helpers/styles.dart';
import '../../../helpers/text_styles.dart';
import '../../../helpers/translation/all_translation.dart';
import 'delete_button.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key, required this.model});
  final ItemModel model;

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
          Row(
            children: [
              Expanded(
                child: Text(
                  model.name ?? "Name",
                  style: AppTextStyles.w600.copyWith(
                    fontSize: 16,
                    color: Styles.HEADER,
                  ),
                ),
              ),
              SizedBox(width: 8.w),

              ///Item Status
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Styles.requestStatus(model.status).withOpacity(0.08),
                ),
                child: Text(
                  allTranslations.text(model.status?.name ?? ""),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.w600.copyWith(
                    fontSize: 14,
                    height: 1.2,
                    color: Styles.requestStatus(model.status),
                  ),
                ),
              ),
            ],
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
                          text: "120\$",
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
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Styles.WHITE_COLOR,
                        border: Border.all(color: Styles.BORDER_COLOR)),
                    child: Text(
                      "M",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                        color: Styles.HEADER,
                      ),
                    ),
                  ),
                ],
              ),

              ///Color
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    allTranslations.text("color"),
                    style: AppTextStyles.w400.copyWith(
                      fontSize: 14,
                      color: Styles.HEADER,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Styles.RED_CHART_COLOR,
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
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Styles.WHITE_COLOR,
                        border: Border.all(color: Styles.BORDER_COLOR)),
                    child: Text(
                      "3",
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
          SizedBox(height: 4.h),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: RichText(
                  text: TextSpan(
                    text: "${allTranslations.text("link")} ",
                    style: AppTextStyles.w600
                        .copyWith(fontSize: 14, color: Styles.HEADER),
                    children: [
                      TextSpan(
                          text: "www.zara.com",
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
              ),
              if (ItemStatus.inProgress == model.status) SizedBox(width: 8.w),
              if (ItemStatus.inProgress == model.status)
                Expanded(flex: 1, child: DeleteItemButton(id: model.id!))
            ],
          ),
        ],
      ),
    );
  }
}
