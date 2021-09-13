class Order {
  String id;
  OrderType type;
  OrderSide side;
  double price;
  int qty;

  String name; //todo remove

  Order({
    required this.id,
    required this.type,
    required this.side,
    required this.price,
    required this.qty,
    required this.name
  });
}

enum OrderType {
  limit, market, stop
}

enum OrderSide {
  buy, sell
}
