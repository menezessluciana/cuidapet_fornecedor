import 'package:cuidapet_fornecedor/app/modules/schedules/schedules_controller.dart';
import 'package:cuidapet_fornecedor/app/repositories/schedule_repository.dart';
import 'package:cuidapet_fornecedor/app/services/schedule_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'schedules_page.dart';

class SchedulesModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ScheduleRepository()),
        Bind((i) => ScheduleService(i.get())),
        Bind((i) => SchedulesController(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => SchedulesPage()),
      ];

  static Inject get to => Inject<SchedulesModule>.of();
}
