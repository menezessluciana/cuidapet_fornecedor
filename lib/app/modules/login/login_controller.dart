import 'package:cuidapet_fornecedor/app/core/exceptions/cuidapet_exceptions.dart';
import 'package:cuidapet_fornecedor/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @observable
  bool obscureText = true;

  @action
  void showPassword() {
    obscureText = !obscureText;
  }

  @action
  Future<void> login() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        // await _service.login(false,
        //     email: loginController.text, senha: senhaController.text);
        Loader.hide();
        Modular.to.pushReplacementNamed('/');
      } on AcessoNegadoException catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', 'Login ou senha inválidos');
      } catch (e) {
        Loader.hide();
        Get.snackbar('Erro', 'Erro ao realizar login');
      }
    }
  }
}
