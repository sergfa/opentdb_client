import 'package:flutter_test/flutter_test.dart';

import 'package:opentdb_client/opentdb_client.dart';

void main() {
  test('should return a list of categories', () {
    final categoreis = OpentdbRepository.fetchCategories();
    expect(categoreis, isNotNull);
    expect(categoreis.length, greaterThan(0));
  });

test('should have random category', () {
    final categoreis = OpentdbRepository.fetchCategories();
    expect(categoreis.where((element) => element.id == -1), isNotEmpty);
  });

}
