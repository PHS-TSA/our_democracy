import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:our_democracy/src/features/sample/application/sample_items_service.dart';

void main() {
  group('Sample items service', () {
    test('provides three items', () {
      final container = ProviderContainer();

      final model = container.read(sampleItemsServiceProvider);
      expect(model.items.length, 3);
    });
  });
}
