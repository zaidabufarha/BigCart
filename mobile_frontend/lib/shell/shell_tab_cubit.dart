import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

/// Which of MainShell's tabs is showing: 0 Home, 1 Profile, 2 Favorites.
/// Provided app-wide, so pages opened on top of the shell (the cart's
/// "Start shopping", order success's "Continue shopping") can pick the tab
/// they return to.
///
/// Methods aren't named 'attempt' because there's no server communication.
@injectable
class ShellTabCubit extends Cubit<int> {
  ShellTabCubit() : super(home);

  static const home = 0;
  static const profile = 1;
  static const favorites = 2;

  void show(int tab) => emit(tab);
}
