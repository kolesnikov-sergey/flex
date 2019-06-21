class Order {
  String id;
  OrderType type;
  OrderSide side;
  double price;
  int qty;

  String name; //todo remove

  Order({this.id, this.type, this.side, this.price, this.qty, this.name});
}

enum OrderType {
  limit, market, stop
}

enum OrderSide {
  buy, sell
}
