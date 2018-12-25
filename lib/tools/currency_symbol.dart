class CurrencySymbol {
  static final currencies = {
    'RUB': '\u20BD',
    'RUR': '\u20BD',
    'USD': '\$',
    'EUR': '€',
  };

  static String getCurrencySymbol(String value) {
    return currencies[value.toUpperCase()] ?? value;
  }
}
