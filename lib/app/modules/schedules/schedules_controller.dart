import 'package:cuidapet_fornecedor/app/models/schedule_model.dart';
import 'package:cuidapet_fornecedor/app/services/schedule_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'schedules_controller.g.dart';

@Injectable()
class SchedulesController = _SchedulesControllerBase with _$SchedulesController;

abstract class _SchedulesControllerBase with Store {
  final ScheduleService _service;
  final TextEditingController nameFilterController = TextEditingController();

  _SchedulesControllerBase(this._service);

  @observable
  ObservableFuture<List<ScheduleModel>> schedulesFuture;

  List<ScheduleModel> schedulesOriginal;

  @observable
  String selectedStatusFilter;

  @action
  Future<void> initPage() async {
    await getSchedules();
  }

  @action
  Future<void> getSchedules() async {
    selectedStatusFilter = null;
    nameFilterController.text = '';
    schedulesFuture = ObservableFuture(
        Future.delayed(Duration(seconds: 2), () => _service.getSchedules()));
    schedulesOriginal = await schedulesFuture;
  }

  void filterSchedulesByPetName() {
    _filterSchedules();
  }

  void _filterSchedules() {
    var schedules = schedulesOriginal;

    if (selectedStatusFilter != null) {
      schedules =
          schedules.where((e) => e.status == selectedStatusFilter).toList();
    }

    if (nameFilterController.text.isNotEmpty) {
      schedules = schedules
          .where((e) => e.nomePet
              .toLowerCase()
              .contains(nameFilterController.text.toLowerCase()))
          .toList();
    }

    schedulesFuture = ObservableFuture(Future.value(schedules));
  }

  @action
  void filterBySchedulesStatus(String status) {
    if (selectedStatusFilter == status) {
      selectedStatusFilter = null;
    } else {
      selectedStatusFilter = status;
    }
    _filterSchedules();
  }
}
