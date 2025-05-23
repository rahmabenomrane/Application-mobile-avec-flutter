import 'package:examenmobile/common/brands/brand_show_case.dart';
import 'package:examenmobile/common/product_cards/product_card_horizontal.dart';
import 'package:examenmobile/common/product_cards/product_card_vertical.dart';
import 'package:examenmobile/common/widgets/layouts/grid_layout.dart';
import 'package:examenmobile/common/widgets/texts/section_heading.dart';
import 'package:examenmobile/features/shop/controllers/product/product_controller.dart';
import 'package:examenmobile/features/shop/models/category_model.dart';
import 'package:examenmobile/features/shop/models/product_model.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //brands
              const TBrandShowcase(
                images: [
                  TImages.productImage1,
                  TImages.productImage1,
                  TImages.productImage1,
                ],
              ),
              const TBrandShowcase(
                images: [
                  TImages.productImage1,
                  TImages.productImage1,
                  TImages.productImage1,
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              //products
              TSectionHeading(
                title: 'You might like',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TGridLayout(
                itemCount: controller.featuredProducts.length,
                itemBuilder: (_, index) => TProductCardVertical(product:controller.featuredProducts[index]),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
