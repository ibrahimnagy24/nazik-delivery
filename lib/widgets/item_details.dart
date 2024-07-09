import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_network_image.dart';
import 'package:flutter_base/helpers/styles.dart';
import 'package:flutter_base/helpers/text_styles.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/model/requests_model.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, required this.model});
  final ItemModel? model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomNetworkImage.containerNewWorkImage(
            height: 150, width: 150, fit: BoxFit.contain),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "#${model?.number ?? "c"}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.w600.copyWith(
                  fontSize: 14,
                  color: Styles.HEADER,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: RichText(
                  text: TextSpan(
                    text: "${allTranslations.text("product_name")} ",
                    style: AppTextStyles.w400
                        .copyWith(fontSize: 14, color: Styles.SUB_HEADER),
                    children: [
                      TextSpan(
                        text: model?.title ?? "name",
                        style: AppTextStyles.w600.copyWith(
                          fontSize: 14,
                          color: Styles.HEADER,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///store
                  RichText(
                    text: TextSpan(
                      text: "${allTranslations.text("store")} ",
                      style: AppTextStyles.w400
                          .copyWith(fontSize: 14, color: Styles.SUB_HEADER),
                      children: [
                        TextSpan(
                          text: model?.brandName ?? "brand name",
                          style: AppTextStyles.w600.copyWith(
                            fontSize: 14,
                            color: Styles.HEADER,
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Styles.WHITE_COLOR,
                        border: Border.all(color: Styles.BORDER_COLOR)),
                    child: Text(
                      model?.purchaseMethod ?? "mall",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                        color: Styles.HEADER,
                      ),
                    ),
                  ),
                ],
              ),

              ///Price
              RichText(
                text: TextSpan(
                  text: "${allTranslations.text("price")} ",
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 14, color: Styles.SUB_HEADER),
                  children: [
                    TextSpan(
                      text: "${model?.price}\$",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                        color: Styles.PRIMARY_COLOR,
                      ),
                    )
                  ],
                ),
              ),

              ///SubCategory
              RichText(
                text: TextSpan(
                  text: "${allTranslations.text("sub_category")} ",
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 14, color: Styles.SUB_HEADER),
                  children: [
                    TextSpan(
                      text: model?.subCategoryName ?? "Sub category",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                        color: Styles.PRIMARY_COLOR,
                      ),
                    )
                  ],
                ),
              ),

              ///City
              RichText(
                text: TextSpan(
                  text: "${allTranslations.text("city")} ",
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 14, color: Styles.SUB_HEADER),
                  children: [
                    TextSpan(
                      text: model?.city ?? "city",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                        color: Styles.PRIMARY_COLOR,
                      ),
                    )
                  ],
                ),
              ),

              ///Color
              RichText(
                text: TextSpan(
                  text: "${allTranslations.text("color")} ",
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 14, color: Styles.SUB_HEADER),
                  children: [
                    TextSpan(
                      text: model?.color ?? "color",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                        color: Styles.PRIMARY_COLOR,
                      ),
                    )
                  ],
                ),
              ),

              ///Size
              RichText(
                text: TextSpan(
                  text: "${allTranslations.text("size")} ",
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 14, color: Styles.SUB_HEADER),
                  children: [
                    TextSpan(
                      text: model?.size ?? "size",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                        color: Styles.PRIMARY_COLOR,
                      ),
                    )
                  ],
                ),
              ),

              ///Quantity
              RichText(
                text: TextSpan(
                  text: "${allTranslations.text("quantity")} ",
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 14, color: Styles.SUB_HEADER),
                  children: [
                    TextSpan(
                      text: "${model?.quantity ?? 0}",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                        color: Styles.PRIMARY_COLOR,
                      ),
                    )
                  ],
                ),
              ),

              ///Link
              RichText(
                 maxLines: 1,
                overflow: TextOverflow.ellipsis,
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

              ///Note
              if (model?.note != null) SizedBox(height: 2.h),
              if (model?.note != null)
                ReadMoreText(
                  model?.note ?? "",
                  style: AppTextStyles.w400
                      .copyWith(fontSize: 14, color: Styles.DETAILS),
                  trimCollapsedText: '...Show more',
                  trimExpandedText: ' show less',
                  trimLines: 2,
                  textAlign: TextAlign.start,
                  moreStyle: AppTextStyles.w600
                      .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
                  lessStyle: AppTextStyles.w600
                      .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
