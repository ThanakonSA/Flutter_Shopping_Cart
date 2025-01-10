import 'package:flutter/material.dart';
import 'package:shopping_cart/item.dart';

class CartItem extends StatefulWidget {
  final Item items;
  final Function(int) onQuantityChanged;

  const CartItem({
    super.key,
    required this.items,
    required this.onQuantityChanged,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.items.amount;
  }

  @override
  void didUpdateWidget(covariant CartItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // อัปเดต quantity เมื่อ amount ของ Item เปลี่ยนแปลง
    if (widget.items.amount != quantity) {
      setState(() {
        quantity = widget.items.amount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.items.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Price: ${widget.items.price} ฿',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (quantity > 0) {
                  setState(() {
                    quantity--;
                  });
                  widget.items.amount = quantity; // อัปเดตจำนวนใน items
                  widget.onQuantityChanged(-widget.items.price.toInt());
                }
              },
            ),
            Text(
              '$quantity',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  quantity++;
                });
                widget.items.amount = quantity; // อัปเดตจำนวนใน items
                widget.onQuantityChanged(widget.items.price.toInt());
              },
            ),
          ],
        ),
      ],
    );
  }
}
