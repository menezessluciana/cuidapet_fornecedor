import 'package:json_annotation/json_annotation.dart';
part 'provider_model.g.dart';

@JsonSerializable()
class ProviderModel {
  int id;
  String nome;
  String logo;

  ProviderModel(
    this.id,
    this.nome,
    this.logo,
  );

  factory ProviderModel.fromJson(Map<String, dynamic> json) =>
      _$ProviderModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderModelToJson(this);
}
