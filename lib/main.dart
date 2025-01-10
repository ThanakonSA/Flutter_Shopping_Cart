import 'package:flutter/material.dart';
import 'package:shopping_cart/CartItem.dart';
import 'package:shopping_cart/item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 91, 29, 199)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = <Item>[
    Item(name: 'iPhone 15', price: 17000, imageUrl: 'https://mac-center.com/cdn/shop/files/IMG-10942145_9f7ece93-39fc-4310-a98d-9c11efa3a51e.jpg?v=1723752783&width=823',),
    Item(name: 'MacBook Pro', price: 28000, imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJxn519dwNYI1EnCcOy0tMkns20f7tO1CW4Q&s',),
    Item(name: 'iPad Pro', price: 10000, imageUrl: 'https://i5.walmartimages.com/seo/2021-Apple-11-inch-iPad-Pro-Wi-Fi-512GB-Silver-3rd-Generation_e304a776-3ea7-47de-b001-093c9bf8f4ca.32175697226f4a5841a67d25c04aded3.jpeg',),
  ];

  int total = 0;

  /// อัปเดต Total เมื่อจำนวนสินค้าเปลี่ยนแปลง
  void updateTotal(int value) {
    setState(() {
      total += value;
    });
  }

  /// รีเซ็ต Cart และ Total
  void clearCart() {
    setState(() {
      total = 0; // Reset total price
      for (var item in items) {
        item.amount = 0; // Reset quantity for each item
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: const TextStyle(color: Color.fromARGB(255, 220, 182, 31)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shopping Cart',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton.icon(
                  onPressed: clearCart, // เรียกใช้ฟังก์ชัน clearCart
                  label: const Text('Clear Cart'),
                  icon: const Icon(Icons.delete_outline),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: CartItem(
                      items: items[index],
                      onQuantityChanged: updateTotal,
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    '$total ฿',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}