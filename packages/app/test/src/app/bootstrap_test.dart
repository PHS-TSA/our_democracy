import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:our_democracy/src/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/mocks.dart';

Future<SharedPreferencesWithCache> getSharedPreferences({
  Map<String, Object?>? cache,
  required SharedPreferencesWithCacheOptions cacheOptions,
}) async {
  return MockSharedPreferences();
}

void main() {
  setUpAll(() {
    registerFallbackValue(Container());
  });

  test('main does not throw', () async {
    const app = MyApp();

    await expectLater(
      app.bootstrap(
        (_) {},
        getSharedPreferences,
      ),
      completes,
    );
  });
}
