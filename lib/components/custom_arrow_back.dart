import 'package:flutter/material.dart';
import 'package:flutter_base/components/custom_images.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';

import '../helpers/styles.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return allTranslations.currentLanguage == "ar"
        ? customImageIconSVG(imageName: "right",color: color??Styles.HEADER)
        : customImageIconSVG(imageName: "left",color: color??Styles.HEADER);
  }
}

class ArrowBackIos extends StatelessWidget {
  final Color color;
  const ArrowBackIos({super.key, this.color = Colors.white});
  @override
  Widget build(BuildContext context) {
    return allTranslations.currentLanguage != "ar"
        ? customImageIconSVG(imageName: "ios-right", color: color)
        : customImageIconSVG(imageName: "ios-left", color: color);
  }
}
