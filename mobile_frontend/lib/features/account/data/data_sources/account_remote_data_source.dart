import 'package:big_cart/core/api/api.dart';
import 'package:big_cart/core/error/exception.dart';
import 'package:big_cart/core/graphql/mappers.dart';
import 'package:big_cart/core/graphql/schema.graphql.dart';
import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:big_cart/features/account/data/graphql/account.graphql.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/notification_preferences.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/domain/entities/transaction.dart';
import 'package:big_cart/features/account/domain/entities/user.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart' hide Order;

abstract class AccountRemoteDataSource {
  Future<void> updateProfile({
    required String name,
    required String email,
    required String phoneNumber,
    required String currentPassword,
    required String newPassword1,
    required String newPassword2,
  });

  Future<void> addCreditCard({
    required String name,
    required String cardNumber,
    required String expiration,
    required bool saveCard,
    required PaymentProcessor processor,
  });
  Future<void> updateCreditCard(CreditCard card);
  Future<void> setDefaultCreditCard(String cardId);

  Future<List<CreditCard>> getCreditCards();

  Future<void> addProfilePicture({required String path});
  Future<User> getUserData();

  Future<void> addAddress({
    required String name,
    required String address,
    required String city,
    required String zip,
    required String country,
    required String phoneNumber,
    required bool makeDefault,
  });
  Future<void> updateAddress(Address address);

  Future<List<Address>> getAddresses();

  Future<void> setNotificationPreferences({
    required bool allowEmailNotifications,
    required bool allowOrderNotifications,
    required bool allowGeneralNotifications,
  });

  Future<NotificationPreferences> getNotificationPreferences();
  Future<List<Order>> getOrders();
  Future<List<Transaction>> getTransactions();
}

@LazySingleton(as: AccountRemoteDataSource)
class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final ApiConsumer apiConsumer;
  final UserLocalDataSource userLocalDataSource;

  AccountRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.userLocalDataSource,
  });

  @override
  Future<void> addAddress({
    required String name,
    required String address,
    required String city,
    required String zip,
    required String country,
    required String phoneNumber,
    required bool makeDefault,
  }) async {
    try {
      await apiConsumer.request(
        documentNodeMutationAddAddress,
        variables: Variables$Mutation$AddAddress(
          input: Input$AddressInput(
            name: name,
            street: address,
            city: city,
            zip_code: zip,
            country: country,
            phone: phoneNumber,
            is_default: makeDefault,
          ),
        ).toJson(),
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> addCreditCard({
    required String name,
    required String cardNumber,
    required String expiration,
    required bool saveCard,
    required PaymentProcessor processor,
  }) async {
    try {
      final cleanNumber = cardNumber.replaceAll(' ', '');
      final last4 = cleanNumber.length >= 4
          ? cleanNumber.substring(cleanNumber.length - 4)
          : cleanNumber;
      await apiConsumer.request(
        documentNodeMutationAddCard,
        variables: Variables$Mutation$AddCard(
          input: Input$CardInput(
            card_holder_name: name,
            card_number: cleanNumber,
            last4: last4,
            expiry_date: expiration,
            processor: processor.name,
            is_default: saveCard,
          ),
        ).toJson(),
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> addProfilePicture({required String path}) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(path),
        'upload_preset': 'big_cart',
      });

      final cloudinaryDio = Dio();
      final uploadRes = await cloudinaryDio.post(
        'https://api.cloudinary.com/v1_1/jz8fffg2/image/upload',
        data: formData,
      );

      final secureUrl = uploadRes.data['secure_url']?.toString();
      if (secureUrl == null || secureUrl.isEmpty) {
        throw Exception('Cloudinary upload failed');
      }

      await apiConsumer.request(
        documentNodeMutationUpdateProfile,
        variables: Variables$Mutation$UpdateProfile(
          input: Input$UpdateProfileInput(image_path: secureUrl),
        ).toJson(),
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Address>> getAddresses() async {
    try {
      final data = await apiConsumer.request(documentNodeQueryGetAddresses);
      final me = Query$GetAddresses.fromJson(data).me;
      return [
        for (final address in me.address)
          address.toEntity(isDefault: address.id == me.default_address_id),
      ];
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<CreditCard>> getCreditCards() async {
    try {
      final data = await apiConsumer.request(documentNodeQueryGetCreditCards);
      final me = Query$GetCreditCards.fromJson(data).me;
      return [
        for (final card in me.credit_card)
          card.toEntity(isDefault: card.id == me.default_credit_card_id),
      ];
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<NotificationPreferences> getNotificationPreferences() async {
    try {
      final data = await apiConsumer.request(
        documentNodeQueryGetNotificationPreferences,
      );
      final pref = Query$GetNotificationPreferences.fromJson(
        data,
      ).me.notification_preference;
      return NotificationPreferences(
        allowEmail: pref.allow_email,
        allowGeneral: pref.allow_general,
        allowOrder: pref.allow_order,
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Order>> getOrders() async {
    try {
      final data = await apiConsumer.request(documentNodeQueryGetOrders);
      return Query$GetOrders.fromJson(
        data,
      ).me.order.map((o) => o.toEntity()).toList();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    try {
      final data = await apiConsumer.request(documentNodeQueryGetTransactions);
      return Query$GetTransactions.fromJson(
        data,
      ).me.transaction.map((t) => t.toEntity()).toList();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<User> getUserData() async {
    try {
      final data = await apiConsumer.request(documentNodeQueryGetUserData);
      return Query$GetUserData.fromJson(data).me.toEntity();
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> setNotificationPreferences({
    required bool allowEmailNotifications,
    required bool allowOrderNotifications,
    required bool allowGeneralNotifications,
  }) async {
    try {
      await apiConsumer.request(
        documentNodeMutationUpdateNotificationPreference,
        variables: Variables$Mutation$UpdateNotificationPreference(
          email: allowEmailNotifications,
          order: allowOrderNotifications,
          general: allowGeneralNotifications,
        ).toJson(),
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> updateAddress(Address address) async {
    final id = address.id;
    if (id == null) return;
    try {
      await apiConsumer.request(
        documentNodeMutationUpdateAddress,
        variables: Variables$Mutation$UpdateAddress(
          id: id,
          input: Input$AddressInput(
            name: address.name,
            street: address.street,
            city: address.city,
            zip_code: address.zipCode,
            country: address.country,
            phone: address.phone,
            is_default: address.isDefault,
          ),
        ).toJson(),
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> updateCreditCard(CreditCard card) async {
    final id = card.id;
    if (id == null) return;
    try {
      await apiConsumer.request(
        documentNodeMutationUpdateCreditCard,
        variables: Variables$Mutation$UpdateCreditCard(
          id: id,
          input: Input$CardInput(
            card_holder_name: card.cardHolderName,
            last4: card.last4,
            expiry_date: card.expiryDate,
            processor: card.processor.name,
            is_default: card.isDefault,
          ),
        ).toJson(),
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> setDefaultCreditCard(String cardId) async {
    try {
      await apiConsumer.request(
        documentNodeMutationSetDefaultCreditCard,
        variables: Variables$Mutation$SetDefaultCreditCard(id: cardId).toJson(),
      );
    } on DioException {
      throw NoInternetException();
    }
  }

  @override
  Future<void> updateProfile({
    required String name,
    required String email,
    required String phoneNumber,
    required String currentPassword,
    required String newPassword1,
    required String newPassword2,
  }) async {
    try {
      if (newPassword1.isNotEmpty) {
        if (newPassword1 != newPassword2) {
          throw PasswordMismatchException();
        }
        await apiConsumer.request(
          documentNodeMutationChangePassword,
          variables: Variables$Mutation$ChangePassword(
            oldPassword: currentPassword,
            newPassword: newPassword1,
          ).toJson(),
        );
      }

      await apiConsumer.request(
        documentNodeMutationUpdateProfile,
        variables: Variables$Mutation$UpdateProfile(
          input: Input$UpdateProfileInput(
            name: name,
            email: email,
            phone: phoneNumber,
          ),
        ).toJson(),
      );
    } on DioException {
      throw NoInternetException();
    } catch (e) {
      final msg = e.toString().toLowerCase();
      if (msg.contains('incorrect') || msg.contains('wrong password')) {
        throw WrongPasswordException();
      }
      rethrow;
    }
  }
}
