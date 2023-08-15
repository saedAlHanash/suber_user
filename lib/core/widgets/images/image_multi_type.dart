

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../generated/assets.dart';
import '../../api_manager/api_service.dart';
import '../../strings/app_color_manager.dart';

enum ImageType { tempImg, assetImg, assetSvg, network, file, networkSvg }

class ImageMultiType extends StatefulWidget {
  const ImageMultiType({
    Key? key,
    required this.url,
    this.height,
    this.width,
    this.fit,
    this.color,
  }) : super(key: key);

  final String url;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  @override
  State<ImageMultiType> createState() => ImageMultiTypeState();
}

class ImageMultiTypeState extends State<ImageMultiType> {
  var type = ImageType.network;

  void initialType() {

    if (widget.url.isEmpty) {
      type = ImageType.tempImg;
    } else if (widget.url.contains('assets/') && widget.url.contains('.svg')) {
      type = ImageType.assetSvg;
    } else if (widget.url.endsWith('svg')) {
      type = ImageType.networkSvg;
    } else if (widget.url.contains('assets/') && widget.url.contains('.png')) {
      type = ImageType.assetImg;
    } else {
      type = ImageType.network;
    }
  }

  @override
  Widget build(BuildContext context) {
    initialType();
    switch (type) {
      case ImageType.assetImg:
        return Image.asset(
          widget.url,
          height: widget.height,
          width: widget.width,
          color: widget.color,
          fit: widget.fit,
        );
      case ImageType.assetSvg:
        return SvgPicture.asset(
          widget.url,
          height: widget.height,
          width: widget.width,
          color: widget.color,
          fit: widget.fit ?? BoxFit.contain,
        );
      case ImageType.network:
        return CachedNetworkImage(
          imageUrl: widget.url,
          height: widget.height,
          width: widget.width,
          color: widget.color,
          filterQuality: FilterQuality.low,
          fit: widget.fit ?? BoxFit.cover,
          alignment: Alignment.center,
          errorWidget: (context, url, error) {

            return Image.asset(
              Assets.iconsLogo,
              color: AppColorManager.mainColor.withOpacity(0.6),
              height: widget.height,
              width: widget.width,
            );
          },
        );
      case ImageType.file:
      case ImageType.networkSvg:
        return SvgPicture.network(
          widget.url,
          height: widget.height,
          width: widget.width,
          color: widget.color,
          fit: widget.fit ?? BoxFit.contain,
        );
      case ImageType.tempImg:
        return ImageMultiType(
          url: Assets.iconsLogo,
          color: AppColorManager.mainColor.withOpacity(0.6),
          height: widget.height,
          width: widget.width,
        );
    }
  }
}
