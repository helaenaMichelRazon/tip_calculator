import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  test('calculates 15 percent tip for a 500 bill', () {
    final result = computeTip(500, 15);

    expect(result.tip, 75.00);
    expect(result.total, 575.00);
  });

  test('calculates 20 percent tip for a 500 bill', () {
    final result = computeTip(500, 20);

    expect(result.tip, 100.00);
    expect(result.total, 600.00);
  });

  test('parses a valid bill amount', () {
    expect(parseBill('500'), 500.0);
  });

  test('returns null for invalid bill input', () {
    expect(parseBill('abc'), isNull);
  });
}