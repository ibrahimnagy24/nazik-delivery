import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/features/my_refunds/bloc/my_order_refunds_bloc.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_base/widgets/item_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/animated_widget.dart';
import '../../../helpers/styles.dart';
import '../../../helpers/text_styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../my_refunds/model/refunds_model.dart';

class RefundDetailsBody extends StatelessWidget {
  const RefundDetailsBody({super.key, required this.model});
  final RefundModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListAnimator(
        data: [
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 2.h),
            child: Text(
              "#${model.refundNumber ?? "c"}",
              style: AppTextStyles.w600.copyWith(
                fontSize: 18,
                color: Styles.HEADER,
              ),
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

          ///Refund Amount
          RichText(
            text: TextSpan(
              text: "${allTranslations.text("refund_amount")}: ",
              style: AppTextStyles.w600
                  .copyWith(fontSize: 14, color: Styles.HEADER),
              children: [
                TextSpan(
                  text: "${model.refundAmount}\$",
                  style: AppTextStyles.w400.copyWith(
                    fontSize: 14,
                    color: Styles.SUB_HEADER,
                  ),
                )
              ],
            ),
          ),

          ///If Order Refund Only Show Product for Delivery Man
          if (MyOrderRefundsBloc.instance.orderStatus.contains(model.status))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Products
                Padding(
                  padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
                  child: Text(
                    allTranslations.text("products"),
                    style: AppTextStyles.w600.copyWith(
                      fontSize: 16,
                      color: Styles.HEADER,
                    ),
                  ),
                ),
                ...List.generate(
                    model.items?.length ?? 0,
                    (index) => ItemCard(
                          model: model.items?[index],
                        )),
              ],
            )
        ],
      ),
    );
  }
}
