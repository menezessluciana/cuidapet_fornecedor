import 'package:cuidapet_fornecedor/app/models/access_token_model.dart';
import 'package:cuidapet_fornecedor/app/models/confirm_login_model.dart';
import 'package:cuidapet_fornecedor/app/repositories/security_storage_repository.dart';
import 'package:cuidapet_fornecedor/app/repositories/shared_prefs_repository.dart';
import 'package:cuidapet_fornecedor/app/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserService {
  final UserRepository _repository;

  UserService(this._repository);

  Future<void> login(String email, String password) async {
    try {
      final prefs = await SharedPrefsRepository.instance;
      final fireAuth = FirebaseAuth.instance;
      AccessTokenModel accessTokenModel;

      accessTokenModel = await _repository.login(email, password);
      await fireAuth.signInWithEmailAndPassword(
          email: email, password: password);

      prefs.registerAcessToken(accessTokenModel.accessToken);
      final ConfirmLoginModel confirmModel = await _repository.confirmLogin();
      prefs.registerAcessToken(confirmModel.accessToken);
      SecurityStorageRepository()
          .registerRefreshToken(confirmModel.refreshToken);
    } on PlatformException catch (e) {
      print('Erro ao fazer login no firebase $e');
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
