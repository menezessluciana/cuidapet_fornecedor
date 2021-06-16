import 'package:json_annotation/json_annotation.dart';

part 'provider_service_model.g.dart';

@JsonSerializable()
class ProviderServiceModel {
  int id;
  String nome;
  double valor;

  ProviderServiceModel({
    this.id,
    this.nome,
    this.valor,
  });

  factory ProviderServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ProviderServiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderServiceModelToJson(this);
}
