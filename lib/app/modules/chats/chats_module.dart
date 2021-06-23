import 'chat/chat_module.dart';
import 'chats_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'chats_page.dart';

class ChatsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ChatsController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => ChatsPage()),
        ModularRouter('/chat', module: ChatModule())
      ];

  static Inject get to => Inject<ChatsModule>.of();
}
