import 'package:dio/dio.dart';
import 'result.dart';
import 'package:logging/logging.dart';
import '../error_string.dart';

abstract class ApiService {
  Future<Result<T>> get<T>(String endpoint, {Map<String, dynamic>? data});
  Future<Result<T>> post<T>(String endpoint, {dynamic data});
  Future<Result<T>> put<T>(String endpoint, {dynamic data});
  Future<Result<T>> delete<T>(String endpoint);
}

class DioApiService implements ApiService{
  static final DioApiService _instance = DioApiService._internal();

  static DioApiService get instance => _instance;

  late Dio dio;

  String baseUrl;

  final _log = Logger('DioApiService');

  DioApiService._internal({
    this.baseUrl = 'https://serpapi.com/search'
  }) {
    initDio();
  }

  void initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (e, handler) {
          handler.next(e);
        },
      ),
    );
  }

  @override
  Future<Result<T>> get<T>(String path, {dynamic data, Options? options}) async {
    try {
      final Response response =  await dio.get(path, queryParameters: data, options: options);
      print(response);
      return _handleResponse<T>(response);
    } on DioException catch(e) {
      _log.severe('请求$path失败: ${e.toString()}');
      return Result.failure(_handleDioError(e));
    } catch (e) {
      _log.severe('网络$path错误: ${e.toString()}');
      return Result.failure(ErrorStrings.friendlyError);
    }
  }

  @override
  Future<Result<T>> post<T>(String path, {dynamic data, Options? options}) async {
    try {
      final Response response = await dio.post(path, data: data, options: options);
      return _handleResponse<T>(response);
    } on DioException catch(e) {
      _log.severe('请求$path失败: ${e.toString()}');
      return Result.failure(_handleDioError(e));
    } catch (e) {
      _log.severe('网络$path错误: ${e.toString()}');
      return Result.failure(ErrorStrings.friendlyError);
    }
  }

  @override
  Future<Result<T>> put<T>(String path, {dynamic data, Options? options}) async {
    try{
      final Response response =  await dio.put(path, data: data, options: options);
      return _handleResponse<T>(response);
    } on DioException catch(e) {
      _log.severe('请求$path失败: ${e.toString()}');
      return Result.failure(_handleDioError(e));
    } catch (e) {
      _log.severe('网络$path错误: ${e.toString()}');
      return Result.failure(ErrorStrings.friendlyError);
    }
  }

  @override
  Future<Result<T>> delete<T>(String path, {dynamic data, Options? options}) async {
    try {
      final Response response =  await dio.delete(path, data: data, options: options);
      return _handleResponse<T>(response);
    } on DioException catch(e) {
      _log.severe('请求$path失败: ${e.toString()}');
      return Result.failure(_handleDioError(e));
    } catch (e) {
      _log.severe('网络$path错误: ${e.toString()}');
      return Result.failure(ErrorStrings.friendlyError);
    }
  }

  Result<T> _handleResponse<T>(Response response) {
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      return Result.success(response.data as T);
    } else {
      return Result.failure('错误代码: ${response.statusCode}');
    }
  }

  String _handleDioError(DioException e) {
    // Log the technical details for debugging
    _log.warning('Dio错误: ${e.type} - ${e.message}');

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ErrorStrings.timeoutError;
      case DioExceptionType.badCertificate:
        _log.severe('验证失败: ${e.message}');
        return ErrorStrings.serverError;
      case DioExceptionType.cancel:
        return ErrorStrings.friendlyError;
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return ErrorStrings.networkError;
      case DioExceptionType.badResponse:
        return _handleBadResponse(e);
    }
  }

  String _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    // Log technical details for debugging
    _log.warning('Bad response: $statusCode - $data');

    switch (statusCode) {
      case 400:
      case 422:
        final serverMessage = _extractErrorMessage(data);
        if (serverMessage != null) {
          _log.info('服务器验证错误: $serverMessage');
        }
        return ErrorStrings.apiError;
      case 401:
        return ErrorStrings.unauthorizedError;
      case 403:
      case 404:
        return ErrorStrings.apiError;
      case 500:
      case 502:
      case 503:
        return ErrorStrings.serverError;
      default:
        return ErrorStrings.friendlyError;
    }
  }

  String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] ?? data['error'] ?? data['detail'];
    }
    return null;
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError;
  }
}