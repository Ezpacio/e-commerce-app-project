import 'package:flutter/material.dart';
import 'package:product_app/ui/components/constants/appEnums.dart';

class ImageComponent extends StatelessWidget {
  final ImageEnums imageType;
  final String imageUrl;
  double? width = 200.00;
  double? height = 200.00;
  BoxFit boxfit;
  Color? svgColor;

  ImageComponent({
    required this.imageType,
    required this.imageUrl,
    this.width,
    this.height,
    this.boxfit = BoxFit.cover,
    this.svgColor,
  });

  @override
  Widget build(BuildContext context) {
    switch (imageType) {
      case ImageEnums.network:
        return Image.network(
          "http://kasimadalan.pe.hu/urunler/resimler/$imageUrl",
          width: width,
          height: height,
          fit: boxfit,
        );
      case ImageEnums.normal:
        return Image.asset(
          'assets/images/$imageUrl',
          width: width,
          height: height,
          fit: boxfit,
        );
      default:
        return SizedBox.shrink();
      // case ImageEnums.svg:
      //   return SvgPicture.asset(
      //     '${AssetPath.IMAGES_SVG_PATH}$imageUrl',
      //     width: width,
      //     height: height,
      //     fit: boxfit,
      //     color: svgColor,
      //   );
    }
  }
}
