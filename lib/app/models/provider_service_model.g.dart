// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderServiceModel _$ProviderServiceModelFromJson(Map<String, dynamic> json) {
  return ProviderServiceModel(
    id: json['id'] as int,
    nome: json['nome'] as String,
    valor: (json['valor'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ProviderServiceModelToJson(
        ProviderServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'valor': instance.valor,
    };
