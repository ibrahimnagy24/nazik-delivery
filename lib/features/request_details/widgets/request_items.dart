import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_base/widgets/item_card.dart';

import '../../../helpers/styles.dart';
import '../../../helpers/text_styles.dart';
import '../../../helpers/translation/all_translation.dart';
import '../../../model/items_model.dart';

class RequestItems extends StatelessWidget {
  const RequestItems({super.key, required this.items});
  final List<ItemModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Title
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Text(
            allTranslations.text("products"),
            style: AppTextStyles.w600.copyWith(
              fontSize: 14,
              color: Styles.HEADER,
            ),
          ),
        ),
        ...List.generate(
            items.length ?? 0,
            (index) => ItemCard(
                  model: items[index],
                ))
      ],
    );
  }
}
