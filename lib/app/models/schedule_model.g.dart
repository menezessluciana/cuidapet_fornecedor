// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) {
  return ScheduleModel(
    json['id'] as int,
    json['nome'] as String,
    json['nomePet'] as String,
    json['dataAgendamento'] == null
        ? null
        : DateTime.parse(json['dataAgendamento'] as String),
    json['status'] as String,
    (json['servicos'] as List)
        ?.map((e) => e == null
            ? null
            : ProviderServiceModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'nomePet': instance.nomePet,
      'dataAgendamento': instance.dataAgendamento?.toIso8601String(),
      'status': instance.status,
      'servicos': instance.servicos,
    };
