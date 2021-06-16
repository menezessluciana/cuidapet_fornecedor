import 'package:cuidapet_fornecedor/app/models/schedule_model.dart';
import 'package:cuidapet_fornecedor/app/repositories/schedule_repository.dart';

class ScheduleService {
  final ScheduleRepository _repository;

  ScheduleService(this._repository);
  Future<List<ScheduleModel>> getSchedules() {
    return _repository.getSchedules();
  }

  Future<void> changeScheduleStatus(String status, int id) async {
    return _repository.changeScheduleStatus(status, id);
  }
}
