class OrderData {
  String id;
  OrderType type;
  OrderSide side;
  double price;
  int qty;

  OrderData({this.id, this.type, this.side, this.price, this.qty});
}

enum OrderType {
  limit, market, stop
}

enum OrderSide {
  buy, sell
}
