import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:examenmobile/common/product_cards/product_card_vertical.dart';
import 'package:examenmobile/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:examenmobile/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:examenmobile/common/widgets/images/t_rounded_image.dart';
import 'package:examenmobile/common/widgets/layouts/grid_layout.dart';
import 'package:examenmobile/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:examenmobile/features/shop/controllers/product/product_controller.dart';
import 'package:examenmobile/features/shop/screens/all_products/all_products.dart';
import 'package:examenmobile/features/shop/screens/home/widgets/home_categories.dart';
import 'package:examenmobile/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:examenmobile/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:examenmobile/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:examenmobile/common/widgets/texts/section_heading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  //appbar
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  //searchbar
                  TSearchContainer(text: 'Search in store'),
                  SizedBox(height: TSizes.spaceBtwSections),

                  ///Categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(
                          title: 'Popular categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),

                        //categories
                        THomeCategories(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(
                    banners: [
                      TImages.promoBanner2,
                      TImages.promoBanner1,
                      TImages.promoBanner3,
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  TSectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => const AllProducts()),
                  ),

                  SizedBox(height: TSizes.spaceBtwItems),

                  //Popular Products
                  Obx(() {
                    if (controller.isLoading.value)
                      return TVerticalProductShimmer();
                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No data found',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    ;
                    return TGridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (_, index) => TProductCardVertical(product:controller.featuredProducts[index]),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
