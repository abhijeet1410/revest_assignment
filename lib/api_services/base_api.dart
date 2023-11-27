import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:revest_app/utils/shared_preference_helper.dart';
import 'package:http_parser/http_parser.dart' as p;
import 'package:revest_app/app_configs/api_routes.dart';
import 'package:revest_app/app_configs/environment.dart';
import 'package:revest_app/data_models/rest_error.dart';


enum RequestMethod { get, create, patch, remove }

class ApiCall {
  static Future<Response<T>> _generalApiCall<T>(
      String path, RequestMethod requestMethod,
      {String id = '',
        String basePath = Environment.baseApiUrl,
        Map<String, dynamic> query = const {},
        dynamic body = const {},
        bool isAuthNeeded = true,
        Options? extraOptions}) async {
    Dio _dio = Dio();

    if (isAuthNeeded &&
        SharedPreferenceHelper.user != null &&
        SharedPreferenceHelper.user!.accessToken != null) {
      _dio.options.headers['Authorization'] =
          SharedPreferenceHelper.user!.accessToken;
    }
    try {
      log('URL $requestMethod $basePath/$path/$id $query ${jsonEncode(body)} ${SharedPreferenceHelper.user?.accessToken}');

      Response<T> response;
      switch (requestMethod) {
        case RequestMethod.get:
          response =
          await _dio.get<T>('$basePath/$path', queryParameters: query);
          break;
        case RequestMethod.create:
          response = await _dio.post<T>('$basePath/$path/$id',
              data: body, queryParameters: query, options: extraOptions);
          break;
        case RequestMethod.patch:
          response = await _dio.patch<T>('$basePath/$path/$id',
              data: body, queryParameters: query, options: extraOptions);
          break;
        case RequestMethod.remove:
          response = await _dio.delete<T>('$basePath/$path/$id',
              queryParameters: query, options: extraOptions);
          break;
        default:
          throw ArgumentError('Invalid RequestMethod $requestMethod');
      }
      return response;
    } on SocketException {
      throw NoInternetError();
    } catch (error, s) {
      log('ERROR URL $basePath/$path/$id ${_dio.options.headers['Authorization']} ${jsonEncode(body)}',
          error: '$error', stackTrace: s);
      if ((error as dynamic).response == null) {
        throw NoInternetError();
      }
      if (error is DioError) {
        if (error.response?.statusCode == 502) {
          throw 'Server unreachable';
        } else {
          final restError = RestError.fromJson(error.response!.data);
          if (restError.code == 401) {

          }
          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }

  static Future<Response<T>> get<T>(String path,
      {String id = '',
        String basePath = Environment.baseApiUrl,
        Map<String, dynamic> query = const {},
        bool isAuthNeeded = true,
        Options? extraOptions}) async {
    return _generalApiCall<T>(path, RequestMethod.get,
        id: id, basePath: basePath, query: query, isAuthNeeded: isAuthNeeded);
  }

  static Future<Response<T>> post<T>(String path,
      {String id = '',
        String basePath = Environment.baseApiUrl,
        Map<String, dynamic> query = const {},
        dynamic body = const {},
        bool isAuthNeeded = true,
        Options? extraOptions}) async {
    return _generalApiCall<T>(path, RequestMethod.create,
        id: id,
        basePath: basePath,
        query: query,
        isAuthNeeded: isAuthNeeded,
        body: body,
        extraOptions: extraOptions);
  }

  static Future<Response<T>> patch<T>(
      String path, {
        String id = '',
        String basePath = Environment.baseApiUrl,
        Map<String, dynamic> query = const {},
        Map<String, dynamic> body = const {},
        bool isAuthNeeded = true,
        Options? extraOptions,
      }) async {
    return _generalApiCall<T>(path, RequestMethod.patch,
        id: id,
        basePath: basePath,
        query: query,
        isAuthNeeded: isAuthNeeded,
        extraOptions: extraOptions,
        body: body);
  }

  static Future<Response<T>> delete<T>(String path,
      {String id = '',
        String basePath = Environment.baseApiUrl,
        Map<String, dynamic> query = const {},
        Options? extraOptions}) async {
    return _generalApiCall<T>(path, RequestMethod.remove,
        id: id,
        basePath: basePath,
        query: query,
        isAuthNeeded: true,
        extraOptions: extraOptions);
  }
}
