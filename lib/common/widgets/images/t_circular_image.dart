import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = TSizes.sm,
    this.isNetworkImage = false,
  });
  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(TSizes.sm),
      decoration: BoxDecoration(
        color:backgroundColor??
            (THelperFunctions.isDarkMode(context)
            ? TColors.black
            : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Image(
          image: isNetworkImage? NetworkImage(image) :AssetImage(image) as ImageProvider,
          fit: fit,
          color: overlayColor,
        ),
      ),
    );
  }
}
