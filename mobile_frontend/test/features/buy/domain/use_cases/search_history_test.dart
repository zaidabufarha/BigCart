import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart';
import 'package:big_cart/features/buy/domain/use_cases/search_history.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuyRepository extends Mock implements BuyRepository {}

void main() {
  late MockBuyRepository repository;
  late AddToSearchHistory addToHistory;
  List<String> saved = [];

  setUp(() {
    repository = MockBuyRepository();
    addToHistory = AddToSearchHistory(repository);
    when(() => repository.getSearchHistory()).thenAnswer((_) async => saved);
    when(() => repository.saveSearchHistory(any())).thenAnswer((call) async {
      saved = call.positionalArguments.first as List<String>;
    });
  });

  test('puts the newest search first', () async {
    saved = ['Oil', 'Juice'];
    expect(await addToHistory('Organic'), ['Organic', 'Oil', 'Juice']);
  });

  test(
    'searching again moves it to the front instead of repeating it',
    () async {
      saved = ['Oil', 'organic', 'Juice'];
      expect(await addToHistory('Organic '), ['Organic', 'Oil', 'Juice']);
    },
  );

  test('keeps only the last ten', () async {
    saved = [for (var i = 0; i < 10; i++) 'term $i'];
    final updated = await addToHistory('new');
    expect(updated.length, AddToSearchHistory.maxEntries);
    expect(updated.first, 'new');
    expect(updated, isNot(contains('term 9')));
  });
}
