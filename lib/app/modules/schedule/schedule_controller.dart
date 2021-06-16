import 'package:cuidapet_fornecedor/app/services/schedule_service.dart';
import 'package:cuidapet_fornecedor/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'schedule_controller.g.dart';

@Injectable()
class ScheduleController = _ScheduleControllerBase with _$ScheduleController;

abstract class _ScheduleControllerBase with Store {
  final ScheduleService _service;

  _ScheduleControllerBase(this._service);

  Future<void> changeScheduleStatus(
      String scheduleStatus, int scheduleId) async {
    try {
      Loader.show();
      await _service.changeScheduleStatus(scheduleStatus, scheduleId);
      Loader.hide();
      Get.snackbar('Sucesso', 'Status alterado');
      Future.delayed(
          Duration(seconds: 3),
          () async => await Modular.to
              .pushNamedAndRemoveUntil('/', ModalRoute.withName('/')));
    } catch (e) {
      Loader.hide();
      Get.snackbar('Erro', 'Ocorreu um erro ao salvar o status');
    }
  }
}
