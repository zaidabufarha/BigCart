import 'package:big_cart/features/buy/domain/use_cases/search_history.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

/// The search page's recent searches, newest first. The state is the list
/// itself: it's local, so there's no loading or error to model.
@injectable
class SearchHistoryCubit extends Cubit<List<String>> {
  SearchHistoryCubit(this.getHistory, this.addToHistory, this.clearHistory)
    : super(const []);
  final GetSearchHistory getHistory;
  final AddToSearchHistory addToHistory;
  final ClearSearchHistory clearHistory;

  Future<void> load() async => emit(await getHistory.call());

  Future<void> add(String query) async {
    if (query.trim().isEmpty) return;
    emit(await addToHistory.call(query));
  }

  Future<void> clear() async {
    await clearHistory.call();
    emit(const []);
  }
}
