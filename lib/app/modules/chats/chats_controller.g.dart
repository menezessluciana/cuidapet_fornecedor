// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatsController on _ChatsControllerBase, Store {
  final _$chatFutureAtom = Atom(name: '_ChatsControllerBase.chatFuture');

  @override
  ObservableFuture<List<ChatModel>> get chatFuture {
    _$chatFutureAtom.reportRead();
    return super.chatFuture;
  }

  @override
  set chatFuture(ObservableFuture<List<ChatModel>> value) {
    _$chatFutureAtom.reportWrite(value, super.chatFuture, () {
      super.chatFuture = value;
    });
  }

  final _$_ChatsControllerBaseActionController =
      ActionController(name: '_ChatsControllerBase');

  @override
  void getChats() {
    final _$actionInfo = _$_ChatsControllerBaseActionController.startAction(
        name: '_ChatsControllerBase.getChats');
    try {
      return super.getChats();
    } finally {
      _$_ChatsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chatFuture: ${chatFuture}
    ''';
  }
}
