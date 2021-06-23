import 'package:cuidapet_fornecedor/app/models/chat_model.dart';
import 'package:cuidapet_fornecedor/app/services/chat_service.dart';
import 'package:cuidapet_fornecedor/app/services/schedule_service.dart';
import 'package:cuidapet_fornecedor/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'schedule_controller.g.dart';

@Injectable()
class ScheduleController = _ScheduleControllerBase with _$ScheduleController;

abstract class _ScheduleControllerBase with Store {
  final ScheduleService _service;
  final ChatService _chatService;

  _ScheduleControllerBase(this._service, this._chatService);

  Future<void> changeScheduleStatus(
      String scheduleStatus, int scheduleId) async {
    try {
      Loader.show();
      await _service.changeScheduleStatus(scheduleStatus, scheduleId);
      Loader.hide();
      Get.snackbar('Sucesso', 'Status alterado');
      Future.delayed(
          Duration(seconds: 3),
          () async => await Modular.to
              .pushNamedAndRemoveUntil('/', ModalRoute.withName('/')));
    } catch (e) {
      Loader.hide();
      Get.snackbar('Erro', 'Ocorreu um erro ao salvar o status');
    }
  }

  Future<List<ChatModel>> getChats() async {
    var chats = await _chatService.getChats();
    return chats;
  }

  Future<void> getScheduleChat(int scheduleId) async {
    var chats = await getChats();

    var hasCreatedChat = chats.any((c) {
      return c.agendamentoId == scheduleId;
    });

    if (hasCreatedChat) {
      var chat = chats.where((c) => c.agendamentoId == scheduleId);
      Modular.to.pushNamed('chats/chat', arguments: chat.first);
    } else {
      await _chatService.initChat(scheduleId);
      var chats = await getChats();
      var chat = chats.where((c) => c.agendamentoId == scheduleId);
      Modular.to.pushNamed('chats/chat', arguments: chat.first);
    }
  }
}
