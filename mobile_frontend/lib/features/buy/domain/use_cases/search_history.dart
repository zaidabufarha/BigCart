import 'package:big_cart/features/buy/domain/repositories/buy_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSearchHistory {
  final BuyRepository repository;
  GetSearchHistory(this.repository);
  Future<List<String>> call() => repository.getSearchHistory();
}

/// Puts a search at the front: newest first, no repeats, the last ten only.
@lazySingleton
class AddToSearchHistory {
  static const maxEntries = 10;
  final BuyRepository repository;
  AddToSearchHistory(this.repository);

  Future<List<String>> call(String query) async {
    final term = query.trim();
    final history = await repository.getSearchHistory();
    final updated = [
      term,
      // the same words in any case count as a repeat
      ...history.where((h) => h.toLowerCase() != term.toLowerCase()),
    ].take(maxEntries).toList();
    await repository.saveSearchHistory(updated);
    return updated;
  }
}

@lazySingleton
class ClearSearchHistory {
  final BuyRepository repository;
  ClearSearchHistory(this.repository);
  Future<void> call() => repository.saveSearchHistory(const []);
}
