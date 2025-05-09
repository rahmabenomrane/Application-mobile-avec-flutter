import 'package:examenmobile/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:examenmobile/common/widgets/images/t_rounded_image.dart';
import 'package:examenmobile/common/widgets/texts/section_heading.dart';
import 'package:examenmobile/features/shop/models/product_model.dart';
import 'package:examenmobile/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:examenmobile/features/shop/screens/product_details/widgets/product_attributes.dart';
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
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product ;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1 - Product Image Slider
             TProductImageSlider(product : product),

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
                  const TRatingAndShare(),
                  //price,title
                  const TProductMetaData(),

                  //attributes
                  const TProductAttributes(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  ///checkou button
                  SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () {}, child: const Text('Checkout'))),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  //description
                  const TSectionHeading(title: 'Description',showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems ),
                  ReadMoreText(
                    'Keep your pet warm and stylish with this cozy animal coat. Made from soft, breathable fabric, it ensures comfort during chilly days. Easy to put on and perfect for outdoor walks or indoor lounging.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w800),
                  ),
                  
                  ///reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  
                  Row(
                    children: [
                      const TSectionHeading(title: 'Reviews(100)',showActionButton: false),

                      IconButton(icon: const Icon(Iconsax.arrow_right_3,size: 18),onPressed: () {},)
                    ],
                  )


                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

