import 'package:examenmobile/features/shop/models/category_model.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';

class TDummyData {
  /// -- Banners
  /*static final List<BannerModel> banners = [
    BannerModel(imageUrl: TImages.banner1, targetScreen: TRoutes.order, active: false),
    BannerModel(imageUrl: TImages.banner2, targetScreen: TRoutes.cart, active: true),
    BannerModel(imageUrl: TImages.banner3, targetScreen: TRoutes.favourites, active: true),
    BannerModel(imageUrl: TImages.banner4, targetScreen: TRoutes.search, active: true),
    BannerModel(imageUrl: TImages.banner5, targetScreen: TRoutes.settings, active: true),
    BannerModel(imageUrl: TImages.banner6, targetScreen: TRoutes.userAddress, active: true),
    BannerModel(imageUrl: TImages.banner8, targetScreen: TRoutes.checkout, active: false),
  ];*/
  // -- List of all Categories
  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', image: TImages.dogIcon, name: 'Dogs', isFeatured: true),
    CategoryModel(id: '5', image: TImages.catIcon, name: 'Cats', isFeatured: true),
    CategoryModel(id: '2', image: TImages.toysIcon, name: 'Toys', isFeatured: true),
    CategoryModel(id: '3', image: TImages.bowlIcon, name: 'Bowls', isFeatured: true),
    CategoryModel(id: '4', image: TImages.hygienIcon, name: 'Hygiene', isFeatured: true),
/*bowlIcon = "assets/icons/categories/bowl.png";
  static const String toysIcon = "assets/icons/categories/dog-ball.png";
  static const String boxIcon = "assets/icons/categories/pet-carrier.png";
  static const String foodIcon = "assets/icons/categories/pet-food.png";
  static const String accessoriesIcon = "assets/icons/categories/pet-collar.png";
  static const String hygienIcon*/
    // Subcategories
    CategoryModel(id: '8', image: TImages.foodIcon, name: 'Dog food', parentId: '1', isFeatured: false),
    CategoryModel(id: '9', image: TImages.accessoriesIcon, name: 'Accessories', parentId: '1', isFeatured: false),
    CategoryModel(id: '10', image: TImages.bowlIcon, name: 'Boxes', parentId: '1', isFeatured: false),

    // Furniture
    CategoryModel(id: '11', image: TImages.foodIcon, name: 'Cat food', parentId: '5', isFeatured: false),
    CategoryModel(id: '12', image: TImages.boxIcon, name: 'Cat boxes', parentId: '5', isFeatured: false),
    CategoryModel(id: '9', image: TImages.accessoriesIcon, name: 'Accessories', parentId: '5', isFeatured: false),


  ];
}