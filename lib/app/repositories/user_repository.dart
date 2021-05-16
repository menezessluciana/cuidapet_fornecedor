import 'dart:io';

import 'package:cuidapet_fornecedor/app/core/dio/custom_dio.dart';
import 'package:cuidapet_fornecedor/app/models/access_token_model.dart';
import 'package:cuidapet_fornecedor/app/models/confirm_login_model.dart';
import 'package:cuidapet_fornecedor/app/models/user_model.dart';
import 'package:cuidapet_fornecedor/app/repositories/shared_prefs_repository.dart';

class UserRepository {
  Future<AccessTokenModel> login(String email, String password) {
    return CustomDio.instance.post('/login', data: {
      'login': email,
      'senha': password,
    }).then((res) => AccessTokenModel.fromJson(res.data));
  }

  Future<ConfirmLoginModel> confirmLogin() async {
    final prefs = await SharedPrefsRepository.instance;
    final deviceId = prefs.deviceId;

    return CustomDio.authInstance.patch('/login/confirmar', data: {
      'ios_token': Platform.isIOS ? deviceId : null,
      'android_token': Platform.isAndroid ? deviceId : null,
    }).then((res) => ConfirmLoginModel.fromJson(res.data));
  }

  Future<UsuarioModel> recoveryDataLoggedUser() {
    return CustomDio.authInstance
        .get('/usuario')
        .then((res) => UsuarioModel.fromJson(res.data));
  }
}
