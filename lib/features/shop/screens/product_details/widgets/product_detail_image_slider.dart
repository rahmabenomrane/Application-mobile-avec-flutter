import 'package:cached_network_image/cached_network_image.dart';
import 'package:examenmobile/common/icons/t_circular_icon.dart';
import 'package:examenmobile/common/widgets/appbar/appbar.dart';
import 'package:examenmobile/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:examenmobile/common/widgets/images/t_rounded_image.dart';
import 'package:examenmobile/features/shop/controllers/product/images_controller.dart';
import 'package:examenmobile/features/shop/models/product_model.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);
    final dark = THelperFunctions.isDarkMode(context);

    // Vérification initiale des images
    if (images.isEmpty) {
      return const Center(child: Icon(Icons.error_outline));
    }

    return TCurveEdgedWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;

                    // Gestion des erreurs améliorée
                    if (image.isEmpty) {
                      return Image.asset(TImages.promoBanner3);
                    }

                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: image.startsWith('http')
                          ? CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, progress) =>
                            CircularProgressIndicator(
                              value: progress.progress,
                              color: TColors.primary,
                            ),
                        errorWidget: (context, url, error) =>
                            Image.asset(TImages.promoBanner3),
                      )
                          : Image.asset(
                        image,
                        fit: BoxFit.contain,
                        errorBuilder: (ctx, err, stack) =>
                            Image.asset(TImages.promoBanner3),
                      ),
                    );
                  }),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder:
                      (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
                  itemBuilder: (_, index) => Obx(() {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return TRoundedImage(
                      width: 80,
                      isNetworkImage: images[index].startsWith('http'),
                      backgroundColor: dark ? TColors.dark : TColors.white,
                      onPressed: () =>
                      controller.selectedProductImage.value = images[index],
                      border: Border.all(
                          color: imageSelected
                              ? TColors.primary
                              : Colors.transparent),
                      padding: const EdgeInsets.all(TSizes.sm),
                      imageUrl: images[index],
                    );
                  }),
                ),
              ),
            ),

            /// Appbar icons
            const TAppBar(
              showBackArrow: true,
              actions: [TCircularIcon(icon: Iconsax.heart5, color: Colors.red)],
            ),
          ],
        ),
      ),
    );
  }
}