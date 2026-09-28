import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

// The profile only. Addresses, cards, orders and transactions each have their
// own query and cubit, so the user never carries copies of them.
@freezed
abstract class User with _$User {
  const factory User({
    required String name,
    required String email,
    required String phone,
    @Default('assets/blank_profile_picture.png') String imagePath,
  }) = _User;
}
