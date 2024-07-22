import 'package:flutter_test/flutter_test.dart';
import 'package:our_democracy/src/features/sample/domain/sample_items_model.dart';

void main() {
  group('SampleItemsModel', () {
    test('should be constant and support value equality', () {
      // Arrange
      const model = SampleItemsModel(items: []);

      // Act
      final newModel = model.copyWith(items: []);

      // Assert
      expect(newModel, equals(model));
    });
  });
}
