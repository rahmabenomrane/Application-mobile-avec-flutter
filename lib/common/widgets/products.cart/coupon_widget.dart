import 'package:flutter/material.dart';

class TCouponCode extends StatelessWidget {
  const TCouponCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.discount),
              hintText: 'Have a promo code? Enter here',
            ),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.withOpacity(0.2),
            elevation: 0,
            foregroundColor: Colors.black,
          ),
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
