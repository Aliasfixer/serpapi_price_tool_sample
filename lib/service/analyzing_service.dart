

import 'package:decimal/decimal.dart';

class AnalyzingService {
  static final AnalyzingService _instance = AnalyzingService._internal();

  static AnalyzingService get instance => _instance;

  AnalyzingService._internal();

  Decimal calculateAverage(List<Decimal> prices) {
    if (prices.isEmpty) return Decimal.zero;
    final sum = prices.reduce((a, b) => a + b);
    return (sum / Decimal.fromInt(prices.length)).toDecimal(scaleOnInfinitePrecision: 2);
  }

  Decimal? calculateMode(List<Decimal> prices) {
    if (prices.isEmpty) return null;
    final counts = <Decimal, int>{};
    for (var price in prices) {
      counts[price] = (counts[price] ?? 0) + 1;
    }
    int maxCount = counts.values.fold(0, (a, b) => a > b ? a : b);
    return counts.entries.firstWhere((e) => e.value == maxCount).key;
  }

  Decimal minPrice(List<Decimal> prices) {
    if (prices.isEmpty) return Decimal.zero;
    return prices.reduce((a, b) => a < b ? a : b);
  }

}