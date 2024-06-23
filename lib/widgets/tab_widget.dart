import 'package:flutter/material.dart';
import 'package:flutter_base/utility/extensions.dart';
import 'package:flutter_base/widgets/images.dart';
import 'package:flutter_base/helpers/styles.dart';

class TabWidget extends StatelessWidget {
  const TabWidget(
      {required this.data,
      required this.isSelected,
      this.expand = false,
      required this.onClick,
      super.key,
      this.iconPath});
  final String data;
  final bool isSelected, expand;
  final Function() onClick;
  final String? iconPath;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPath != null)
                Images(
                  image: iconPath!,
                  color: isSelected ? Styles.PRIMARY_COLOR : Styles.HINT,
                ),
              if (iconPath != null) const SizedBox(width: 4),
              Text(
                data,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Styles.PRIMARY_COLOR : Styles.HINT,
                ),
              ),
            ],
          ),
          LayoutBuilder(builder: (context, c) {
            return Container(
              padding: EdgeInsets.zero,
              width: (expand) ? c.maxWidth : 28 + (data.length * 8),
              height: 4,
              margin: EdgeInsets.only(top: 10.h),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                color: isSelected ? Styles.PRIMARY_COLOR : Styles.BORDER_COLOR,
              ),
            );
          })
        ],
      ),
    );
  }
}
