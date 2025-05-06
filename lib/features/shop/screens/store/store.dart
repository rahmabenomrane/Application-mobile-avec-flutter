import 'package:examenmobile/common/brands/brand_show_case.dart';
import 'package:examenmobile/common/brands/t_brand_card.dart';
import 'package:examenmobile/common/brands/t_brand_card.dart';
import 'package:examenmobile/common/widgets/appbar/appbar.dart';
import 'package:examenmobile/common/widgets/appbar/tabbar.dart';
import 'package:examenmobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:examenmobile/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:examenmobile/common/widgets/images/t_circular_image.dart';
import 'package:examenmobile/common/widgets/layouts/grid_layout.dart';
import 'package:examenmobile/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:examenmobile/common/widgets/texts/section_heading.dart';
import 'package:examenmobile/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:examenmobile/features/shop/screens/store/store.dart';
import 'package:examenmobile/features/shop/screens/store/widgets/category_tab.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/enums.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        //appbar title + cart icon
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [TCartCountericon(onPressed: () {})],
        ),

        body: NestedScrollView(
          //header
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor:
                    THelperFunctions.isDarkMode(context)
                        ? TColors.black
                        : TColors.white,
                expandedHeight: 440,

                //space btwn appbar & tabbar
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      //search bar
                      SizedBox(height: TSizes.spaceBtwItems),
                      TSearchContainer(
                        text: 'Search in store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      //feature brands
                      TSectionHeading(
                        title: 'Featured Brands',
                        onPressed: () {},
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      //brands grid
                      TGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return TBrandCard(showBorder: false);
                        },
                      ),
                    ],
                  ),
                ),

                //tabs
                bottom: const TTabBar(
                  tabs: [
                    Tab(child: Text('Bowl')),
                    Tab(child: Text('Accessories')),
                    Tab(child: Text('Hygiene')),
                    Tab(child: Text('Toys')),
                    Tab(child: Text('Food')),
                    Tab(child: Text('Box')),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
              TCategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}
