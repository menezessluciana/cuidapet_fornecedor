import 'package:cuidapet_fornecedor/app/modules/home/home_module.dart';
import 'package:cuidapet_fornecedor/app/modules/main_page/main_page.dart';
import 'package:cuidapet_fornecedor/app/repositories/user_repository.dart';
import 'package:cuidapet_fornecedor/app/services/user_service.dart';
import 'package:cuidapet_fornecedor/app/shared/auth_store.dart';
import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet_fornecedor/app/app_widget.dart';

import 'modules/login/login_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => AuthStore()),
        Bind((i) => UserRepository()),
        Bind((i) => UserService(i()))
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (context, args) => MainPage()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/login', module: LoginModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
