import 'package:cuidapet_fornecedor/app/models/chat_model.dart';
import 'package:cuidapet_fornecedor/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'chats_controller.dart';

class ChatsPage extends StatefulWidget {
  final String title;
  const ChatsPage({Key key, this.title = "Chats"}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends ModularState<ChatsPage, ChatsController> {
  @override
  void initState() {
    super.initState();
    controller.getChats();
  }
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Observer(builder: (_) {
        return FutureBuilder<List<ChatModel>>(
            future: controller.chatFuture,
            builder: (_, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container();
                  break;
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case ConnectionState.done:
                  return _buildListChats(snapshot);
                  break;
                default:
                  return Container();
              }
            });
      }),
    );
  }

  Widget _buildListChats(AsyncSnapshot<List<ChatModel>> snapshot) {
    final chats = snapshot.data;

    if (snapshot.hasError) {
      return Center(
        child: Text('Erro ao buscar chats'),
      );
    }

    if (snapshot.hasData && chats.isEmpty) {
      return Center(
        child: Text('Nenhum chat encontrado'),
      );
    }
    return ListView.separated(
      itemBuilder: (_, index) {
        var chat = chats[index];
        return ListTile(
          onTap: () => Modular.to.pushNamed('/chats/chat/', arguments: chat),
          leading: CircleAvatar(
            backgroundColor: ThemeUtils.primaryColorLight,
            radius: 25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset("lib/assets/images/logo.png"),
            ),
          ),
          title: Text(chat.nome),
          subtitle: Text(chat.nomePet),
        );
      },
      separatorBuilder: (_, __) {
        return Divider();
      },
      itemCount: chats.length,
    );
  }
}
