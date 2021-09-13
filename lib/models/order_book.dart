class OrderBook {
  final double price;
  final int? sell;
  final int? buy;

  OrderBook({
    required this.price,
    this.sell,
    this.buy
  });
}