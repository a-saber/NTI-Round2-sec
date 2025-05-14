import 'package:dio/dio.dart';
import 'package:nti_r2/core/cache/cache_data.dart';
import 'package:nti_r2/core/network/end_points.dart';

class ApiHelper
{
  // singleton
  static final ApiHelper _instance = ApiHelper._init();
  factory ApiHelper() => _instance;

  ApiHelper._init();

  Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    )
  );

  Future<Response> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false
}) async
  {
    return await dio.post(
      endPoint,
      data: isFormData? FormData.fromMap(data??{}): data,
      options: Options(
        headers:
        {
          if(isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
        }
      )
    );
  }
  Future<Response> getRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false
  }) async
  {
    return await dio.get(
        endPoint,
        data: isFormData? FormData.fromMap(data??{}): data,
        options: Options(
            headers:
            {
              if(isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
            }
        )
    );
  }

}
/*
import 'api_response.dart';
import 'end_points.dart';

class APIHelper {
  // singleton
  static final APIHelper _apiHelper = APIHelper._internal();

  factory APIHelper() {
    return _apiHelper;
  }

  APIHelper._internal();

  // declaring dio
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseURL,
      connectTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  )..interceptors.add(
    InterceptorsWrapper(
        onRequest: (options, handler) {
          // ignore: avoid_print
          print("--- Headers : ${options.headers.toString()}");
          // ignore: avoid_print
          try {
            print("data : ${(options.data as FormData).fields.toString()}");
          }
          catch(e)
          {
            print("data : ${options.data.toString()}");
          }
          // ignore: avoid_print
          print("method : ${options.method}");
          // ignore: avoid_print
          print("EndPoint : ${options.path}");
          return handler.next(options); // Continue request
        },
        onError: (error, handler)async
        {
          print("------ ON ERROR ${error.toString()} \n---- BODY ${error.response?.data.toString()}");
          ApiResponse apiResponse = ApiResponse.fromError(error);
          if(apiResponse.message.contains('Token has expired.'))
          {
            // refresh token
            try {
              var response = await dio.post(
                EndPoints.refreshToken,
                options: Options(
                  headers: {
                    'Authorization': 'Bearer ${CacheData.refreshToken}'
                  }),
              );
              ApiResponse apiResponse = ApiResponse.fromResponse(response);
              if (apiResponse.status) {
                // must update token
                await CacheHelper.saveData(key: CacheKeys.accessToken, value: apiResponse.data['access_token']);
                CacheData.accessToken = apiResponse.data['access_token'];
                // Retry original request

                final options = error.requestOptions;
                if (options.data is FormData) {
                  final oldFormData = options.data as FormData;

                  // Convert FormData to map so it can be rebuilt
                  final Map<String, dynamic> formMap = {};
                  for (var entry in oldFormData.fields) {
                    formMap[entry.key] = entry.value;
                  }

                  // Add files if any
                  for (var file in oldFormData.files) {
                    formMap[file.key] = file.value;
                  }

                  // Rebuild new FormData
                  options.data = FormData.fromMap(formMap);
                }
                options.headers['Authorization'] = 'Bearer ${CacheData.accessToken}';
                final response = await dio.fetch(options);
                return handler.resolve(response);
              }
              else
              {
                // must logout
                CacheHelper.removeData(key: CacheKeys.accessToken);
                CacheHelper.removeData(key: CacheKeys.refreshToken);
                MyNavigator.goTo(destination: ()=>LoginView(), isReplace: true);
                return handler.next(error);
              }

            } catch (e) {
              CacheHelper.removeData(key: CacheKeys.accessToken);
              CacheHelper.removeData(key: CacheKeys.refreshToken);
              MyNavigator.goTo(destination: ()=>LoginView(), isReplace: true);
              return handler.next(error);
            }

          }
          return handler.next(error);

        }


    ),
  );


  // get request

  Future<ApiResponse> getRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.get(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: await getDefaultOptions(isAuthorized: isAuthorized),
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  // post

  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var options = await getDefaultOptions(isAuthorized: isAuthorized);
      var response = await dio.post(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: options,
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      // ignore: avoid_print
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.put(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: await getDefaultOptions(isAuthorized: isAuthorized),
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isAuthorized = true,
  }) async {
    try {
      var response = await dio.delete(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: await getDefaultOptions(isAuthorized: isAuthorized),
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<Options> getDefaultOptions({required bool isAuthorized, bool refreshToken = false}) async {

    return Options(
      headers: {
        if (isAuthorized)
          "Authorization": "Bearer ${CacheHelper.getData(key: refreshToken?CacheKeys.refreshToken:CacheKeys.accessToken)}",
      },
    );
  }
}
*/
/*
import 'package:dio/dio.dart';
import 'package:ecommerce/core/network/api_helper.dart';
import 'package:ecommerce/core/network/end_points.dart';

class ApiResponse {
  final bool status;
  final int statusCode;
  final dynamic data;
  final String message;

  ApiResponse({
    required this.status,
    required this.statusCode,
    this.data,
    required this.message,
  });

  // Factory method to handle Dio responses
  factory ApiResponse.fromResponse(Response response) {
    return ApiResponse(
      status: response.data["status"] ?? false,
      statusCode: response.statusCode ?? 500,
      data: response.data,
      message: response.data["message"] ?? 'An error occurred.',
    );
  }

  // Factory method to handle Dio or other exceptions
  factory ApiResponse.fromError(dynamic error) {
    // ignore: avoid_print
    print(error.toString());
    if (error is DioException) {
      // ignore: avoid_print
      return ApiResponse(
        status: false,
        data: error.response?.data,
        statusCode:
        error.response != null ? error.response!.statusCode ?? 500 : 500,
        message: _handleDioError(error),
      );
    } else {
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: 'An error occurred.',
      );
    }
  }
  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout, please try again.";
      case DioExceptionType.sendTimeout:
        return "Send timeout, please check your internet.";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout, please try again later.";
      case DioExceptionType.badResponse:
        return _handleServerError(error.response);
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionError:
        return "No internet connection.";
      default:
        return "Unknown error occurred.";
    }
  }

  /// Handling errors from the server response
  static String _handleServerError(Response? response) {
    if (response == null) return "No response from server.";
    if (response.data is Map<String, dynamic>) {
      if (response.data["message"] != null)
      {
        print("----- Handle Server Error ${response.data["message"]}");
        return response.data["message"] ;
      }
      return "An error occurred.";
    }
    return "Server error: ${response.statusMessage}";
  }
}
*/
