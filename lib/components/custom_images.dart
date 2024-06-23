import 'package:flutter/material.dart';
import 'package:flutter_base/widgets/images.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_base/helpers/styles.dart';

Widget customImageIcon({
  String? folderPath,
  String? imageName,
  String? imagePath,
  width,
  height,
  color,
}) {
  return Image.asset(
    imagePath?? 'assets/${folderPath ?? "images"}/$imageName."png"}',
    color: color,
    width: width ?? 30,
    height: height ?? 25,
  );
}

Widget customCircleSvgIcon(
    {String? folderPath,
    String? title,
    required String? imageName,
    String? imagePath,
    Function? onTap,
    color,
    width,
    height,
    radius}) {
  return InkWell(
    onTap: () {
      onTap!();
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: color ?? Styles.PRIMARY_COLOR.withOpacity(0.1),
          radius: radius ?? 24,
          child: SvgPicture.asset(
            'assets/svgs/$folderPath/$imageName.svg',
          ),
        ),
        Visibility(
          visible: title != null,
          child: Column(
            children: [
              const SizedBox(
                height: 2,
              ),
              Text(
                title ?? "",
                style: const TextStyle(
                    color: Styles.PRIMARY_COLOR,
                    fontWeight: FontWeight.w600,
                    fontSize: 10),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget customImageIconSVG({
  required String? imageName,
  Color? color,
  double? height,
  double? width,
}) {
  return Images(
    image: 'assets/svgs/$imageName.svg',
    color: color,
    height: height,
    width: width,
  );
}

Widget customContainerIconSVG({
  required String imageName,
  Color? color,
  double? height,
  double? width,
  Color? borderColor,
  required double size,
}) {
  return Container(
    width: size,
    height: size,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: color?.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor ?? Colors.transparent, width: 1)),
    child: customImageIconSVG(
      imageName: imageName,
    ),
  );
}
