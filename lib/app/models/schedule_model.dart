import 'package:cuidapet_fornecedor/app/models/provider_service_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_model.g.dart';

@JsonSerializable()
class ScheduleModel {
  int id;
  String nome;
  String nomePet;
  DateTime dataAgendamento;
  String status;
  List<ProviderServiceModel> servicos;

  ScheduleModel(
    this.id,
    this.nome,
    this.nomePet,
    this.dataAgendamento,
    this.status,
    this.servicos,
  );

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);
}
