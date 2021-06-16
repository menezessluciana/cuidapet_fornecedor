import 'package:json_annotation/json_annotation.dart';

import 'package:cuidapet_fornecedor/app/models/category_model.dart';

part 'provider_model.g.dart';

@JsonSerializable()
class ProviderModel {
  int id;
  String nome;
  String logo;
  String endereco;
  String telefone;
  double latitude;
  double longitude;
  CategoryModel category;

  ProviderModel(
    this.id,
    this.nome,
    this.logo,
    this.endereco,
    this.telefone,
    this.latitude,
    this.longitude,
    this.category,
  );

  factory ProviderModel.fromJson(Map<String, dynamic> json) =>
      _$ProviderModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderModelToJson(this);
}
