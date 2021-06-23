// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatController on _ChatControllerBase, Store {
  final _$chatAtom = Atom(name: '_ChatControllerBase.chat');

  @override
  ChatModel get chat {
    _$chatAtom.reportRead();
    return super.chat;
  }

  @override
  set chat(ChatModel value) {
    _$chatAtom.reportWrite(value, super.chat, () {
      super.chat = value;
    });
  }

  final _$mensagensAtom = Atom(name: '_ChatControllerBase.mensagens');

  @override
  ObservableStream<List<ChatMessageModel>> get mensagens {
    _$mensagensAtom.reportRead();
    return super.mensagens;
  }

  @override
  set mensagens(ObservableStream<List<ChatMessageModel>> value) {
    _$mensagensAtom.reportWrite(value, super.mensagens, () {
      super.mensagens = value;
    });
  }

  final _$_ChatControllerBaseActionController =
      ActionController(name: '_ChatControllerBase');

  @override
  void getChat(ChatModel model) {
    final _$actionInfo = _$_ChatControllerBaseActionController.startAction(
        name: '_ChatControllerBase.getChat');
    try {
      return super.getChat(model);
    } finally {
      _$_ChatControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chat: ${chat},
mensagens: ${mensagens}
    ''';
  }
}
