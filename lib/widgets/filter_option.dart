import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';

import '../helpers/styles.dart';
import '../helpers/text_styles.dart';

class FilterOption extends StatelessWidget {
  const FilterOption({
    super.key,
    required this.title,
    this.isSelect = false,
  });
  final String title;
  final bool isSelect;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isSelect
            ? Styles.PRIMARY_COLOR
            : Styles.PRIMARY_COLOR.withOpacity(0.08),
      ),
      child: Center(
        child: Text(
          title,
          style: AppTextStyles.w500.copyWith(
              fontSize: 14,
              color: isSelect ? Styles.WHITE_COLOR : Styles.PRIMARY_COLOR),
        ),
      ),
    );
  }
}
