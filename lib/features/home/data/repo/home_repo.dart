import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nti_r2/core/network/api_helper.dart';
import 'package:nti_r2/core/network/api_response.dart';
import 'package:nti_r2/core/network/end_points.dart';
import 'package:nti_r2/features/home/data/models/user_model.dart';

class HomeRepo
{
  // singleton
  static final HomeRepo _instance = HomeRepo._internal();
  factory HomeRepo() => _instance;
  HomeRepo._internal();

  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, UserModel>> getUserData() async
  {
    try
    {
      ApiResponse response = await apiHelper.getRequest(endPoint: EndPoints.getUserData, isProtected: true);
      LoginResponseModel loginResponseModel =
      LoginResponseModel.fromJson(response.data);
      if(loginResponseModel.status != null && loginResponseModel.status == true)
      {
        // return user model
        if(loginResponseModel.user != null)
        {
          return Right(loginResponseModel.user!);
        }
        else
        {
          throw Exception("Login Failed\nTry Again later");
        }
      }
      else
      {
        throw Exception("Login Failed\nTry Again later");
      }
    }
    catch(e)
    {
      ApiResponse errorResponse = ApiResponse.fromError(e);
      return Left(errorResponse.message);
    }

  }
}