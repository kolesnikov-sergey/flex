class OrderData {
  String id;
  OrderType type;
  OrderSide side;
  double price;
  int qty;

  String name; //todo remove

  OrderData({this.id, this.type, this.side, this.price, this.qty, this.name});
}

enum OrderType {
  limit, market, stop
}

enum OrderSide {
  buy, sell
}
