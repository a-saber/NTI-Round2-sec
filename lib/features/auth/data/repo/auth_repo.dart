import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nti_r2/core/network/api_helper.dart';
import 'package:nti_r2/core/network/end_points.dart';

class AuthRepo
{
  ApiHelper apiHelper = ApiHelper();

   Future<Either<String, void>> register({required String username, required String password})async
  {
    try
    {
      await apiHelper.postRequest(
        endPoint: EndPoints.register,
        data:
        {
          'username': username,
          'password': password
        }
      );
      return Right(null);
    }
    catch(e)
    {
      if(e is DioException)
      {
        if(e.response != null && e.response?.data['message'] != null) {
          return Left(e.response?.data['message']);
        }
      }

      print("Error ${e.toString()}");
      return Left(e.toString());
    }
  }

}