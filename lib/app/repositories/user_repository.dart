import 'package:cuidapet_fornecedor/app/core/dio/custom_dio.dart';
import 'package:cuidapet_fornecedor/app/models/access_token_model.dart';

class UserRepository {
  Future<AccessTokenModel> login(String email, String password) {
    CustomDio.instance.post('/login', data: {
      'login': email,
      'senha': password,
    }).then((res) => AccessTokenModel.fromJson(res.data));
  }
}
