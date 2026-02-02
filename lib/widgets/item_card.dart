import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_network_image.dart';
import 'package:flutter_base/components/custom_simple_dialog.dart';
import 'package:flutter_base/helpers/styles.dart';
import 'package:flutter_base/helpers/text_styles.dart';
import 'package:flutter_base/model/requests_model.dart';
import 'package:flutter_base/utility/extensions.dart';
import '../../../widgets/item_details.dart';
import '../helpers/translation/all_translation.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, this.model});
  final ItemModel? model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomSimpleDialog.parentSimpleDialog(
          widget: ItemDetails(model: model),
        );
      },
      child: Container(
        height: kIsWeb ? 120 : 80,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
            color: Styles.WHITE_COLOR,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Styles.BORDER_COLOR)),
        child: Row(
          children: [
            CustomNetworkImage.containerNewWorkImage(
                image: model?.image ?? "",
                height: kIsWeb ? 100 : 80,
                width: 80,
                fit: BoxFit.cover),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 2),
                    Text(
                      "#${model?.number ?? "c"}",
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 16,
                        color: Styles.HEADER,
                      ),
                    ),

                    ///Name
                    RichText(
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

                    const SizedBox(height: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
