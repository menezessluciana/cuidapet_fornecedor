import 'package:cuidapet_fornecedor/app/models/provider_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  int id;
  int usuario;
  String nome;
  @JsonKey(name: 'nome_pet')
  String nomePet;
  ProviderModel fornecedor;
  @JsonKey(name: 'agendamento_id')
  int agendamentoId;

  ChatModel();

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
