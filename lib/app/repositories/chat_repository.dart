import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuidapet_fornecedor/app/core/dio/custom_dio.dart';
import 'package:cuidapet_fornecedor/app/models/chat_message_model.dart';
import 'package:cuidapet_fornecedor/app/models/chat_model.dart';

class ChatRepository {
  //conexao com o firebase
  final Firestore _firestore = Firestore.instance;

  Future<void> initChat(int scheduleId) async {
    await CustomDio.authInstance.post('/agendamento/$scheduleId/iniciar-chat');
  }

  Future<List<ChatModel>> getUserChats() {
    return CustomDio.authInstance.get('/chats/usuario').then((res) =>
        res.data.map<ChatModel>((c) => ChatModel.fromJson(c)).toList());
  }

  Stream<List<ChatMessageModel>> getMessages(ChatModel chat) {
    return _firestore
        .collection('chat')
        .document(chat.id.toString())
        .collection('messages')
        .orderBy('data_mensagem', descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.documents
          .map((m) => ChatMessageModel(
              usuario: m['usuario'],
              fornecedor: m['fornecedor'],
              mensagem: m['mensagem']))
          .toList();
    });
  }

  void sendMessageChat(ChatModel model, String message) {
    final data = <String, dynamic>{
      'mensagem': message,
      'data_mensagem': DateTime.now(),
      'fornecedor': model.fornecedor.id,
    };

    _firestore
        .collection('chat')
        .document(model.id.toString())
        .collection('messages')
        .add(data);
  }

  void notifyUser(ChatModel model, String message) {
    CustomDio.authInstance.post('/chats/notificar',
        data: {'chat': model.id, 'mensagem': message, 'para': 'U'});
  }
}
