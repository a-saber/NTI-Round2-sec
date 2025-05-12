import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nti_r2/core/models/default_response_model.dart';
import 'package:nti_r2/core/network/api_helper.dart';
import 'package:nti_r2/core/network/end_points.dart';
import 'package:nti_r2/features/add_task/data/models/get_tasks_response_model.dart';

class TasksRepo
{
  // singletone
  TasksRepo._internal();
  static final TasksRepo _repo = TasksRepo._internal();
  factory TasksRepo() => _repo;

  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, String>> addTask({required TaskModel task})async
  {
    try
    {

      var response = await apiHelper.postRequest(
        endPoint: EndPoints.addTask,
        isProtected: true,
        data: await task.toJson()
      );
      DefaultResponseModel responseModel = DefaultResponseModel.fromJson(response.data);

      if(responseModel.status != null && responseModel.status == true)
      {
        return Right(responseModel.message??"Task added successfully");
      }
      else
      {
        throw Exception("Something went wrong");
      }

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