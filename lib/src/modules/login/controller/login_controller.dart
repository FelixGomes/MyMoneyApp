import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/components/app_snackbar.dart';
import '../../../shared/helpers/validator.dart';
import '../service/login_service.dart';
part 'login_controller.g.dart';

class LoginController = _LoginController with _$LoginController;

abstract class _LoginController with Store {
  LoginService service = LoginService();

  @observable
  bool isLoading = false;

  @observable
  bool isSuccess = false;

  late String email;
  late String password;
  late BuildContext buildContext;

  @action
  Future<void> checkData({
    required String emailController,
    required String passwordController,
    required BuildContext buildContext,
  }) async {
    this.buildContext = buildContext;
    if (_validate(
        emailController: emailController,
        passwordController: passwordController)) {
      email = emailController;
      password = passwordController;
      isLoading = true;
      await sendData();
      isLoading = false;
    } else {
      AppSnackbar.openMessage(
        context: buildContext,
        message: "Verifique os dados preenchidos",
      );
    }
  }

  bool _validate({
    required String emailController,
    required String passwordController,
  }) {
    // todo: implement a minimum and maximum characters for the password
    return (Validator.isEmailValid(emailController) &&
        passwordController.isNotEmpty);
  }

  @action
  Future<void> sendData() async {
    Map result = await service.sendData(username: email, password: password);

    result.containsKey('success')
        ? isSuccess = true
        : getException(result['exception']);
  }

  @action
  void getException(int code) {
    switch (code) {
      case 400:
        AppSnackbar.openMessage(
          context: buildContext,
          message: "Dados inválidos",
        );
        break;
      case 401:
        AppSnackbar.openMessage(
          context: buildContext,
          message: "Acesso não autorizado",
        );
        break;
      case 500:
        AppSnackbar.openMessage(
          context: buildContext,
          message: "Internal server error",
        );
        break;
      default:
        AppSnackbar.openMessage(
          context: buildContext,
          message: "Erro inesperado, tente mais tarde",
        );
    }
  }
}
