import 'package:cached_network_image/cached_network_image.dart';
import 'package:examenmobile/common/widgets/shimmers/shimmer.dart';
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
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color:backgroundColor??
            (THelperFunctions.isDarkMode(context)
            ? TColors.black
            : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child:isNetworkImage?
              CachedNetworkImage(
                fit:fit,
                color:overlayColor,
                imageUrl:image,
                progressIndicatorBuilder: (context,url,downloadProgress)=> const TShimmerEffect(width: 55, height: 55,radius: 55,),

              ):Image(image: AssetImage(image),fit: fit,color: overlayColor,),
          /*Image(
            image: isNetworkImage? NetworkImage(image) :AssetImage(image) as ImageProvider,
            fit: fit,
            color: overlayColor,
          ),*/
        ),
      ),
    );
  }
}
