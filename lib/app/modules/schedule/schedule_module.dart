import 'schedule_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'schedule_page.dart';

class ScheduleModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ScheduleController(i.get(), i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (_, args) => SchedulePage(schedule: args.data),
        ),
      ];

  static Inject get to => Inject<ScheduleModule>.of();
}
