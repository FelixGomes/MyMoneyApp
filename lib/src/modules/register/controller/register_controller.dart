import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/components/app_snackbar.dart';
import '../service/register_service.dart';
part 'register_controller.g.dart';

class RegisterController = _RegisterController with _$RegisterController;

abstract class _RegisterController with Store {
  RegisterService service = RegisterService();

  @observable
  bool isLoading = false;

  @observable
  bool isSuccess = false;

  late String name;
  late String email;
  late String password;
  late BuildContext buildContext;

  @action
  Future<void> checkData({
    required String nameController,
    required String emailController,
    required String passwordController,
    required String passwordCheckController,
    required BuildContext buildContext,
  }) async {
    this.buildContext = buildContext;
    if (passwordController.compareTo(passwordCheckController) == 0) {
      name = nameController;
      email = emailController;
      password = passwordController;
      await validate();
    } else {
      AppSnackbar.openMessage(
          context: buildContext,
          message: "A confirmação da senha está incorreta.");
    }
  }

  @action
  Future<void> validate() async {
    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      isLoading = true;
      await sendData();
      isLoading = false;
    } else {
      AppSnackbar.openMessage(
          context: buildContext,
          message: "Todos os campos devem ser preenchidos.");
    }
  }

  @action
  Future<void> sendData() async {
    isSuccess = await service.sendRegisterData(
      name,
      email,
      password,
    );
    if (isSuccess) {
      AppSnackbar.openMessage(
          context: buildContext, message: "Cadastro realizado com sucesso!");
    }
  }
}
