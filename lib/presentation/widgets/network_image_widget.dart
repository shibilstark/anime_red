import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class NetWorkImageWidget extends StatelessWidget {
  const NetWorkImageWidget({
    Key? key,
    required this.image,
    this.height = double.infinity,
    this.width = double.infinity,
    this.placeholder,
    this.placeholderRadius = 0,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final double height;
  final double width;
  final String? image;
  final String? placeholder;
  final double placeholderRadius;

  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$image",
      width: width,
      filterQuality: FilterQuality.high,
      height: height,
      fit: fit,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      // TODO PLACEHOLDER
      // placeholder: (context, url) => AppPlaceHolder(
      //     height: height, width: width, radius: placeholderRadius),
      // errorWidget: (context, url, error) => AppPlaceHolder(
      //     height: height, width: width, radius: placeholderRadius),
    );
  }
}
