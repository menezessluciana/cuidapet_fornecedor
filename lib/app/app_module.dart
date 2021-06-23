import 'package:cuidapet_fornecedor/app/modules/main_page/main_page.dart';
import 'package:cuidapet_fornecedor/app/modules/schedules/schedules_module.dart';
import 'package:cuidapet_fornecedor/app/repositories/chat_repository.dart';
import 'package:cuidapet_fornecedor/app/repositories/user_repository.dart';
import 'package:cuidapet_fornecedor/app/services/chat_service.dart';
import 'package:cuidapet_fornecedor/app/services/user_service.dart';
import 'package:cuidapet_fornecedor/app/shared/auth_store.dart';
import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet_fornecedor/app/app_widget.dart';

import 'modules/chats/chats_module.dart';
import 'modules/login/login_module.dart';
import 'modules/schedule/schedule_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => AuthStore()),
        Bind((i) => UserRepository()),
        Bind((i) => UserService(i())),
        Bind((i) => ChatRepository()),
        Bind((i) => ChatService(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (context, args) => MainPage()),
        ModularRouter('/login', module: LoginModule()),
        ModularRouter('/schedules', module: SchedulesModule()),
        ModularRouter('/schedule', module: ScheduleModule()),
        ModularRouter('/chats', module: ChatsModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
