import 'package:flutter/cupertino.dart';

import '../model/register_data_model.dart';
import '../repositories/register_repository.dart';

class RegisterService {
  final RegisterRepository repository = RegisterRepository();

  Future<bool> sendRegisterData(
    String name,
    String email,
    String password,
  ) async {
    try {
      RegisterDataModel registerData = RegisterDataModel(
        fullName: name,
        email: email,
        password: password,
      );

      await repository.sendRegisterData(registerData);
      return true;
    } catch (exception) {
      debugPrint(exception.toString());
      return false;
    }
  }
}
