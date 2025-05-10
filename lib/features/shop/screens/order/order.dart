import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if dark mode is enabled
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'My Orders',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildOrderCard(
              context,
              status: 'Processing',
              orderDate: '01 Sep 2023',
              orderNumber: 'CWT0012',
              shippingDate: '09 Sep 2023',
              isDarkMode: isDarkMode,
              statusColor: Colors.blue,
            ),
            const SizedBox(height: 10),
            _buildOrderCard(
              context,
              status: 'Shipment on the way',
              orderDate: '02 Oct 2023',
              orderNumber: 'CWT0025',
              shippingDate: '06 Oct 2023',
              isDarkMode: isDarkMode,
              statusColor: Colors.blue,
            ),
            const SizedBox(height: 10),
            _buildOrderCard(
              context,
              status: 'Delivered',
              orderDate: '03 Nov 2023',
              orderNumber: 'CWT0152',
              shippingDate: '08 Nov 2023',
              isDarkMode: isDarkMode,
              statusColor: Colors.blue,
            ),
            const SizedBox(height: 10),
            _buildOrderCard(
              context,
              status: 'Delivered',
              orderDate: '20 Dec 2023',
              orderNumber: 'CWT0265',
              shippingDate: '25 Dec 2023',
              isDarkMode: isDarkMode,
              statusColor: Colors.blue,
            ),
            const SizedBox(height: 10),
            _buildOrderCard(
              context,
              status: 'Delivered',
              orderDate: '25 Dec 2023',
              orderNumber: 'CWT1636',
              shippingDate: '01 Jan 2024',
              isDarkMode: isDarkMode,
              statusColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(
      BuildContext context, {
        required String status,
        required String orderDate,
        required String orderNumber,
        required String shippingDate,
        required bool isDarkMode,
        required Color statusColor,
      }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Navigate to order details
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.receipt_long_rounded,
                          color: statusColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          status,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      orderDate,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Order Number
                    Row(
                      children: [
                        Icon(
                          Icons.description_outlined,
                          color: isDarkMode ? Colors.white54 : Colors.black45,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order',
                              style: TextStyle(
                                fontSize: 10,
                                color: isDarkMode ? Colors.white38 : Colors.black38,
                              ),
                            ),
                            Text(
                              orderNumber,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Shipping Date
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping_outlined,
                          color: isDarkMode ? Colors.white54 : Colors.black45,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shipping Date',
                              style: TextStyle(
                                fontSize: 10,
                                color: isDarkMode ? Colors.white38 : Colors.black38,
                              ),
                            ),
                            Text(
                              shippingDate,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Chevron icon
                    Icon(
                      Icons.chevron_right,
                      color: isDarkMode ? Colors.white54 : Colors.black45,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
