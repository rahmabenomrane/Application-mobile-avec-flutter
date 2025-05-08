import 'package:examenmobile/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:examenmobile/common/widgets/images/t_rounded_image.dart';
import 'package:examenmobile/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:examenmobile/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:examenmobile/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1 - Product Image Slider
            TProductImageSlider(),

            /// 2 - Product Details
            Padding(
              padding: const EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// - Rating & Share Button
                  TRatingAndShare(),

                  TProductMetaData(),
                  //price,title
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

