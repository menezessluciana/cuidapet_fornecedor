import 'package:cuidapet_fornecedor/app/models/chat_message_model.dart';
import 'package:cuidapet_fornecedor/app/models/chat_model.dart';
import 'package:cuidapet_fornecedor/app/services/chat_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'chat_controller.g.dart';

@Injectable()
class ChatController = _ChatControllerBase with _$ChatController;

abstract class _ChatControllerBase with Store {
  final ChatService _service;
  TextEditingController messageController = TextEditingController();

  _ChatControllerBase(this._service);

  @observable
  ChatModel chat;

  @observable
  ObservableStream<List<ChatMessageModel>> mensagens;

  @action
  void getChat(ChatModel model) {
    chat = model;
    final msgs = _service.getMessages(chat);
    mensagens = msgs.asObservable();
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      _service.sendMessage(chat, messageController.text);
      messageController.text = '';
    }
  }
}
