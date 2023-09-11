import 'package:dio/dio.dart';
import 'package:my_money_app/src/http/app_dio.dart';

import '../model/login_model.dart';

class LoginRepository {
  // your local adress where backend is running, change if necessary
  String baseUrl = "http://192.168.15.113:5432/auth/login";

  Future<Response<Map<String, dynamic>>> sendData(LoginModel loginData) async {
    Dio clientHttp = await AppDio.getConnection(isAuth: false);

    return clientHttp.post(baseUrl, data: loginData.toJson());
  }
}
