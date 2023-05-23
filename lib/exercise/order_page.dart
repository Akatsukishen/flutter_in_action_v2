import 'package:flutter/material.dart';
import 'package:flutter_in_action_v2/base/base_page.dart';

class OrderPage extends BasePage {
  OrderPage({super.key, super.title = '订单状态管理'});

  final List<Widget> _orders = [
    OrderCard(order: Order(1, 'Coffee', 20.00, 1, DateTime(2020, 1, 1))),
    OrderCard(
        order: Order(2, 'Tea', 10.00, 1, DateTime(2020, 1, 2)),
        key: UniqueKey()),
    OrderCard(
        order: Order(3, 'Cake', 50.00, 1, DateTime(2020, 1, 3)),
        key: UniqueKey()),
    OrderCard(
        order: Order(4, 'Pizza', 100.00, 1, DateTime(2020, 1, 4)),
        key: UniqueKey()),
  ];

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      children: _orders,
    );
  }
}

class OrderCard extends StatefulWidget {
  const OrderCard({required this.order, Key? key}) : super(key: key);

  final Order order;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  late Order order;

  @override
  void initState() {
    super.initState();
    order = widget.order;
  }

  void incrementQuantity(Order order) {
    double initPrice = order.price / order.quantity;
    setState(() {
      order.quantity++;
      order.price = initPrice * order.quantity;
    });
  }

  void decrementQuantity(Order order) {
    double initPrice = order.price / order.quantity;
    setState(() {
      order.quantity--;
      order.price = initPrice * order.quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(order.name),
      subtitle: Text('USD ${order.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                decrementQuantity(order);
              },
              icon: const Icon(Icons.remove)),
          const SizedBox(
            width: 15,
          ),
          Text('${order.quantity}'),
          const SizedBox(
            width: 15,
          ),
          IconButton(
              onPressed: () {
                incrementQuantity(order);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}

class Order {
  Order(this.id, this.name, this.price, this.quantity, this.date);
  int id;
  String name;
  int quantity;
  double price;
  DateTime date;
}
