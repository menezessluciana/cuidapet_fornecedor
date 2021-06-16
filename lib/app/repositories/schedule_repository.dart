import 'package:cuidapet_fornecedor/app/core/dio/custom_dio.dart';
import 'package:cuidapet_fornecedor/app/models/schedule_model.dart';

class ScheduleRepository {
  Future<List<ScheduleModel>> getSchedules() {
    return CustomDio.authInstance.get('/agendamentos/fornecedor').then((res) =>
        res.data.map<ScheduleModel>((s) => ScheduleModel.fromJson(s)).toList());
  }

  Future<void> changeScheduleStatus(String status, int id) {
    return CustomDio.authInstance.put('/agendamento/$id/status/$status');
  }
}
