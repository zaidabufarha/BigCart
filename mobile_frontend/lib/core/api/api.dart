import 'package:big_cart/core/di/injection.dart';
import 'package:big_cart/features/auth/presentation/pages/welcome_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gql/ast.dart';
import 'package:gql/language.dart';
import 'package:big_cart/core/session/user_local_data_source.dart';
import 'package:injectable/injectable.dart';

abstract class ApiConsumer {
  Future<dynamic> graphql({
    required String query,
    Map<String, dynamic>? variables,
  });

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> put({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> patch({
    required String path,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> delete({required String path});
}

/// Sends a generated document (documentNodeQuery…/documentNodeMutation…),
/// fragments included, and returns the `data` map for its generated
/// `fromJson`.
extension GraphQLDocuments on ApiConsumer {
  Future<Map<String, dynamic>> request(
    DocumentNode document, {
    Map<String, dynamic>? variables,
  }) async {
    final data = await graphql(
      query: printNode(document),
      variables: variables,
    );
    return Map<String, dynamic>.from(data as Map);
  }
}

@LazySingleton(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  final Dio dio;
  final UserLocalDataSource session;

  DioConsumer({required this.dio, required this.session});

  @override
  Future<dynamic> graphql({
    required String query,
    Map<String, dynamic>? variables,
  }) async {
    try {
      final response = await dio.post(
        '/graphql',
        data: {
          'query': query,
          'variables': variables,
        },
      );
      final data = response.data;
      if (data is Map &&
          data.containsKey('errors') &&
          (data['errors'] as List).isNotEmpty) {
        final message =
            data['errors'][0]['message']?.toString() ?? 'GraphQL error';
        debugPrint('--- [GraphQL Error] ---: $message');
        final lower = message.toLowerCase();
        if (lower.contains('not authorized') ||
            lower.contains('jwt') ||
            lower.contains('expired')) {
          await session.clearCache();
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const WelcomePage()),
            (route) => false,
          );
        }
        throw Exception(message);
      }
      return data is Map && data.containsKey('data') ? data['data'] : data;
    } on DioException catch (e) {
      if (e.response?.data is Map && e.response?.data['errors'] != null) {
        final errors = e.response!.data['errors'] as List;
        if (errors.isNotEmpty) {
          final message = errors[0]['message']?.toString() ?? 'GraphQL error';
          debugPrint('--- [GraphQL Error] ---: $message');
          throw Exception(message);
        }
      }
      final message = e.message ?? e.toString();
      debugPrint('--- [GraphQL Error] ---: $message');
      throw Exception(message);
    }
  }

  @override
  Future<dynamic> delete({required String path}) async {
    final response = await dio.delete(path);
    return response;
  }

  @override
  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(path, queryParameters: queryParameters);
    return response;
  }

  @override
  Future<dynamic> patch({
    required String path,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.patch(
      path,
      queryParameters: queryParameters,
      data: data,
    );
    return response;
  }

  @override
  Future<dynamic> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.post(
      path,
      queryParameters: queryParameters,
      data: data,
    );
    return response;
  }

  //put is like post but at a specific lcation
  @override
  Future<dynamic> put({
    required String path,
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.put(
      path,
      queryParameters: queryParameters,
      data: data,
    );
    return response;
  }
}
