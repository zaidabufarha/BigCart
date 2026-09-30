import 'package:big_cart/core/api/api.dart';
import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:big_cart/features/buy/data/data_sources/buy_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_fixtures.dart';

class MockApiConsumer extends Mock implements ApiConsumer {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

void main() {
  late MockApiConsumer mockApiConsumer;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late BuyRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiConsumer = MockApiConsumer();
    mockUserLocalDataSource = MockUserLocalDataSource();
    dataSource = BuyRemoteDataSourceImpl(
      apiConsumer: mockApiConsumer,
      userLocalDataSource: mockUserLocalDataSource,
    );
  });

  group('BuyRemoteDataSourceImpl JSON Deserialization', () {
    test(
      'getProductList parses products and their average rating',
      () async {
        final mockResponse = {
          'products': [
            {
              'id': '1',
              'name': 'Fresh Organic Broccoli',
              'image_path': 'assets/broccoli.png',
              'amount': '1 kg',
              'description': 'Fresh broccoli',
              'discount': 0.0,
              'price': 4.99,
              'is_new': true,
              'is_favorite': false,
              'color': '0xFFE6F2EA',
              'rating': 4.5,
              'locally_sourced': true,
              'pesticide_free': false,
              'category': {
                'id': '1',
                'name': 'Vegetables',
                'image_path': 'assets/vegetables.png',
                'color': '0xFFE6F2EA',
              },
            },
          ],
        };

        when(
          () => mockApiConsumer.graphql(query: any(named: 'query')),
        ).thenAnswer((_) async => mockResponse);

        final result = await dataSource.getProductList();

        expect(result.length, 1);
        expect(result.first.name, 'Fresh Organic Broccoli');
        expect(result.first.rating, 4.5);
        expect(result.first.category.name, 'Vegetables');
      },
    );

    test('getProductList does not ask for reviews', () async {
      when(
        () => mockApiConsumer.graphql(query: any(named: 'query')),
      ).thenAnswer((_) async => {'products': <Object>[]});

      await expectLater(dataSource.getProductList(), throwsA(anything));

      final query =
          verify(
                () => mockApiConsumer.graphql(
                  query: captureAny(named: 'query'),
                ),
              ).captured.single
              as String;
      expect(query, isNot(contains('review')));
    });

    test('getProductReviews parses reviews with user data', () async {
      final mockResponse = {
        'productReviews': [
          {
            'id': '101',
            'rating': 5.0,
            'comment': 'Excellent quality!',
            'created_at': '2026-08-30T10:00:00.000Z',
            'user': {
              'name': 'John Doe',
              'email': 'john@example.com',
              'phone': '987654321',
              'image_path': 'assets/blank_profile_picture.png',
            },
          },
        ],
      };

      when(
        () => mockApiConsumer.graphql(
          query: any(named: 'query'),
          variables: any(named: 'variables'),
        ),
      ).thenAnswer((_) async => mockResponse);

      final result = await dataSource.getProductReviews('1');

      expect(result.length, 1);
      expect(result.first.comment, 'Excellent quality!');
      expect(result.first.rating, 5.0);
      expect(result.first.user.name, 'John Doe');
      expect(
        result.first.user.imagePath,
        'assets/blank_profile_picture.png',
      );
    });

    test('getCategoryList parses categories correctly', () async {
      final mockResponse = {
        'categories': [
          {
            'id': '1',
            'name': 'Vegetables',
            'image_path': 'assets/vegetables.png',
            'color': '0xFFE6F2EA',
          },
        ],
      };

      when(
        () => mockApiConsumer.graphql(query: any(named: 'query')),
      ).thenAnswer((_) async => mockResponse);

      final result = await dataSource.getCategoryList();

      expect(result.length, 1);
      expect(result.first.name, 'Vegetables');
    });

    test('getCartItems parses cart items correctly', () async {
      final mockResponse = {
        'cart': [
          {
            'id': '1',
            'quantity': 3,
            'product': {
              'id': '1',
              'name': 'Broccoli',
              'image_path': 'assets/broccoli.png',
              'amount': '1 kg',
              'description': 'Fresh',
              'discount': 0.0,
              'price': 4.99,
              'is_new': true,
              'is_favorite': false,
              'color': '0xFFE6F2EA',
              'rating': 4.8,
              'locally_sourced': true,
              'pesticide_free': false,
              'category': {
                'id': '1',
                'name': 'Vegetables',
                'image_path': 'assets/vegetables.png',
                'color': '0xFFE6F2EA',
              },
            },
          },
        ],
      };

      when(
        () => mockApiConsumer.graphql(query: any(named: 'query')),
      ).thenAnswer((_) async => mockResponse);

      final result = await dataSource.getCartItems(isFavorites: false);

      expect(result.length, 1);
      expect(result.first.id, '1');
      expect(result.first.quantity, 3);
      expect(result.first.product.name, 'Broccoli');
    });
  });

  group('cart changes use the cart item id directly', () {
    test('updateQuantity is one request carrying the cart item id', () async {
      when(
        () => mockApiConsumer.graphql(
          query: any(named: 'query'),
          variables: any(named: 'variables'),
        ),
      ).thenAnswer(
        (_) async => {
          'updateCartItem': {'id': 'cart_1'},
        },
      );

      await dataSource.updateQuantity(testCartItem, 5);

      final captured = verify(
        () => mockApiConsumer.graphql(
          query: any(named: 'query'),
          variables: captureAny(named: 'variables'),
        ),
      ).captured;
      expect(captured, [
        {'id': 'cart_1', 'quantity': 5},
      ]);
    });

    test('removeFromCart is one request carrying the cart item id', () async {
      when(
        () => mockApiConsumer.graphql(
          query: any(named: 'query'),
          variables: any(named: 'variables'),
        ),
      ).thenAnswer((_) async => {'removeFromCart': true});

      await dataSource.removeFromCart(testCartItem);

      final captured = verify(
        () => mockApiConsumer.graphql(
          query: any(named: 'query'),
          variables: captureAny(named: 'variables'),
        ),
      ).captured;
      expect(captured, [
        {'id': 'cart_1'},
      ]);
    });
  });
}
