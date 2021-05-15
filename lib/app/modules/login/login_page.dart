import 'dart:io';
import 'package:cuidapet_fornecedor/app/shared/components/cuidapet_textformfield.dart';
import 'package:cuidapet_fornecedor/app/shared/theme_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil.screenWidthDp,
          height: ScreenUtil.screenHeightDp,
          child: Stack(
            children: [
              Container(
                width: ScreenUtil.screenWidthDp,
                height: ScreenUtil.screenHeightDp < 700
                    ? 800
                    : ScreenUtil.screenHeightDp * .95,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('lib/assets/images/login_background.png'),
                      fit: BoxFit.fill),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: Platform.isIOS
                        ? ScreenUtil.statusBarHeight + 30
                        : ScreenUtil.statusBarHeight),
                //* Double infinity pode ser usado pois o pai está limitando o tamanho da largura
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset('lib/assets/images/logo.png',
                        //*SETWIDTH A LARGURA FICA PROPORCIONAL COM O TAMANHO DO DEVICE
                        width: ScreenUtil().setWidth(400),
                        fit: BoxFit.fill),
                    _buildForm()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            CuidapetTextFormField(
                controller: controller.loginController,
                label: 'Login',
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Login obrigatório';
                  }
                  return null;
                }),
            SizedBox(height: 20),
            Observer(builder: (_) {
              return CuidapetTextFormField(
                  controller: controller.senhaController,
                  obscureText: controller.obscureText,
                  label: 'Senha',
                  suffixIcon: IconButton(
                      onPressed: () => controller.showPassword(),
                      icon: controller.obscureText
                          ? Icon(Icons.lock)
                          : Icon(Icons.lock_open)),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Senha obrigatória';
                    } else if (value.length < 6) {
                      return 'Senha precisa ter pelo menos 6 caracteres';
                    }
                    return null;
                  });
            }),
            Container(
              width: ScreenUtil.screenWidthDp,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(10),
              height: 60,
              child: RaisedButton(
                onPressed: () async {
                  FirebaseMessaging _fcm = FirebaseMessaging();
                  _fcm.requestNotificationPermissions();
                  print(await _fcm.getToken());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: ThemeUtils.primaryColor,
                child: Text('Entrar',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
