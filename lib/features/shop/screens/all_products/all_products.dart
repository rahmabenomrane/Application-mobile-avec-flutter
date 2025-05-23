import 'package:examenmobile/common/product_cards/product_card_vertical.dart';
import 'package:examenmobile/common/widgets/appbar/appbar.dart';
import 'package:examenmobile/common/widgets/layouts/grid_layout.dart';
import 'package:examenmobile/features/shop/controllers/product/product_controller.dart';
import 'package:examenmobile/features/shop/models/product_model.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      appBar: const TAppBar(
          title: Text('Popular Products'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [

              /// Dropdown
              DropdownButtonFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.sort)),
                onChanged: (value) {},
                items: [
                  'Name',
                  'Higher Price',
                  'Lower Price',
                  'Sale',
                  'Newest',
                  'Popularity'
                ]
                    .map((option) =>
                    DropdownMenuItem(value: option, child: Text(option)))
                    .toList(),
              ),
              const SizedBox(height: TSizes.spaceBtwSections,),
              TGridLayout(
                itemCount: controller.featuredProducts.length,
                itemBuilder: (_, index) => TProductCardVertical(product:controller.featuredProducts[index]),
              ),

              ],

          ),
        ),
      ),
    );
  }
}