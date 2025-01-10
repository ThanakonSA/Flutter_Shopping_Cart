class Item {
  Item({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  final String name;
  final double price;
  final String imageUrl;
  int amount = 0; // Mutable field to track quantity
}