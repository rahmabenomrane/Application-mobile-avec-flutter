import 'package:examenmobile/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return TVerticalImageText(
            image: TImages.toysIcon,
            title: 'shoes',
            onTap: () {},
          );
        },
      ),
    );
  }
}
