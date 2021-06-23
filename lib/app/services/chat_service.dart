import 'package:cuidapet_fornecedor/app/models/chat_message_model.dart';
import 'package:cuidapet_fornecedor/app/models/chat_model.dart';
import 'package:cuidapet_fornecedor/app/repositories/chat_repository.dart';

class ChatService {
  final ChatRepository _repository;

  ChatService(this._repository);

  Future<void> initChat(int scheduleId) {
    return _repository.initChat(scheduleId);
  }

  Future<List<ChatModel>> getChats() {
    return _repository.getUserChats();
  }

  Stream<List<ChatMessageModel>> getMessages(ChatModel chat) {
    return _repository.getMessages(chat);
  }

  void sendMessage(ChatModel model, String message) {
    _repository.sendMessageChat(model, message);
    _repository.notifyUser(model, message);
  }
}
