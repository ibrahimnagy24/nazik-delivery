import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_network_image.dart';
import 'package:flutter_base/components/custom_simple_dialog.dart';
import 'package:flutter_base/helpers/styles.dart';
import 'package:flutter_base/helpers/text_styles.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/model/requests_model.dart';
import 'package:flutter_base/utility/extensions.dart';
import '../../../widgets/item_details.dart';

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
        height: 80,
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        decoration: BoxDecoration(
            color: Styles.WHITE_COLOR,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Styles.BORDER_COLOR)),
        child: Row(
          children: [
            CustomNetworkImage.containerNewWorkImage(
                height: 80, width: 80, fit: BoxFit.cover),
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
                    Text(
                      model?.title ?? "title",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.w400.copyWith(
                        fontSize: 14,
                        color: Styles.HEADER,
                      ),
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
