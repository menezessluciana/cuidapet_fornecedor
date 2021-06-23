import 'package:cuidapet_fornecedor/app/models/chat_model.dart';
import 'package:cuidapet_fornecedor/app/services/chat_service.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'chats_controller.g.dart';

@Injectable()
class ChatsController = _ChatsControllerBase with _$ChatsController;

abstract class _ChatsControllerBase with Store {
  final ChatService _chatService;

  _ChatsControllerBase(this._chatService);

  @observable
  ObservableFuture<List<ChatModel>> chatFuture;

  @action
  void getChats() {
    chatFuture = ObservableFuture(_chatService.getChats());
  }
}
