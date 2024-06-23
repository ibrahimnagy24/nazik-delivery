import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/features/home/bloc/purchase_bloc.dart';
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
    return StreamBuilder<List<int>?>(
        stream: PurchaseBloc.instance.itemsStream,
        builder: (context, snapshot) {
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        model?.name ?? "Name",
                        style: AppTextStyles.w600.copyWith(
                          fontSize: 16,
                          color: Styles.HEADER,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (snapshot.data?.contains(model?.id) != true) {
                          PurchaseBloc.instance.items.valueOrNull
                              ?.add(model!.id!);
                          PurchaseBloc.instance.updateItems(
                              PurchaseBloc.instance.items.valueOrNull);
                        } else {
                          PurchaseBloc.instance.items.valueOrNull
                              ?.remove(model?.id);
                          PurchaseBloc.instance.updateItems(
                              PurchaseBloc.instance.items.valueOrNull);
                        }
                      },
                      child: Icon(
                        (snapshot.data?.contains(model?.id) == true)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        size: 24,
                        color: (snapshot.data?.contains(model?.id) == true)
                            ? Styles.GREEN
                            : Styles.HINT,
                      ),
                    )
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
                    ///Color
                    RichText(
                      text: TextSpan(
                        text: "${allTranslations.text("color")} ",
                        style: AppTextStyles.w400
                            .copyWith(fontSize: 14, color: Styles.HEADER),
                        children: [
                          TextSpan(
                            text: "red",
                            style: AppTextStyles.w600.copyWith(
                                fontSize: 14, color: Styles.PRIMARY_COLOR),
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
                SizedBox(height: 2.h),
                RichText(
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
              ],
            ),
          );
        });
  }
}
