import 'package:my_money_app/src/shared/model/lib/src/shared/model/user_model.dart';

class AuthenticatedUser {
  static Future<UserModel> getUserData() async {
    UserModel userData = UserModel(
        fullName: "Gustavo Gomes",
        email: "gustavogomes@gmail.com",
        id: "ab73f8e9-1f74-40ad-808c-4d18317047b5");

    return userData;
  }
}
