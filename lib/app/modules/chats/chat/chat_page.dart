import 'package:cuidapet_fornecedor/app/models/chat_message_model.dart';
import 'package:cuidapet_fornecedor/app/models/chat_model.dart';
import 'package:cuidapet_fornecedor/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'chat_controller.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chat;
  const ChatPage({Key key, this.chat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState(this.chat);
}

class _ChatPageState extends ModularState<ChatPage, ChatController> {
  //use 'controller' variable to access controller'
  //
  final ChatModel model;
  final ScrollController _scrollController = ScrollController();

  _ChatPageState(this.model);

  @override
  void initState() {
    controller.getChat(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          model.nome,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Observer(
              builder: (_) {
                final List<ChatMessageModel> msgs = controller.mensagens?.data;

                if (msgs == null) return SizedBox.shrink();

                //esperar que a tela carregue, para movimentar ela
                Future.delayed(
                    Duration.zero,
                    () => _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent));

                //*CRIA LISTA SOB DEMANDA DA TELA
                return ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: msgs.length,
                    itemBuilder: (_, index) {
                      final msg = msgs[index];
                      if (msg.fornecedor != null) {
                        return ListTile(
                          trailing: CircleAvatar(
                            backgroundImage:
                                NetworkImage(model.fornecedor.logo),
                          ),
                          title: Text(model.fornecedor.nome,
                              textAlign: TextAlign.end),
                          subtitle:
                              Text(msg.mensagem, textAlign: TextAlign.end),
                        );
                      } else {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: ThemeUtils.primaryColorLight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset("lib/assets/images/logo.png"),
                            ),
                          ),
                          title: Text(model.nome),
                          subtitle: Text(msg.mensagem),
                        );
                      }
                    });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: controller.messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: CircleAvatar(
                    minRadius: 25,
                    child: IconButton(
                      onPressed: () => controller.sendMessage(),
                      icon: Icon(Icons.send),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
