import 'package:examenmobile/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/texts/section_heading.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TSectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: () {}),
        const SizedBox(height: 10),
        Row(
          children: [
            const Image(image: AssetImage(TImages.visa), width: 50),
            const SizedBox(width: 16),
            Text('visa', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }
}
