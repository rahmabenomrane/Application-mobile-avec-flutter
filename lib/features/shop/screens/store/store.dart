import 'package:examenmobile/common/widgets/appbar/appbar.dart';
import 'package:examenmobile/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:examenmobile/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:examenmobile/common/widgets/texts/section_heading.dart';
import 'package:examenmobile/utils/constants/colors.dart';
import 'package:examenmobile/utils/constants/sizes.dart';
import 'package:examenmobile/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Store',style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCartCountericon(onPressed: (){},)
        ],
      ),
      body: NestedScrollView(headerSliverBuilder: (_,innerBoxIsScrolled){
        return[
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            backgroundColor: THelperFunctions.isDarkMode(context)? TColors.black :TColors.white,
            expandedHeight: 440, //height
            flexibleSpace: Padding(padding: EdgeInsets.all(TSizes.defaultSpace,),child:ListView(
              shrinkWrap:  true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                //search bar
                SizedBox(height: TSizes.spaceBtwItems,),
                TSearchContainer(text: 'Search in store', showBorder: true,showBackground: false, padding: EdgeInsets.zero,),
                SizedBox(height: TSizes.spaceBtwSections,),



              ],
            ) ,),
          ),
        ];
      }, body: Container()),
    );
  }
}
