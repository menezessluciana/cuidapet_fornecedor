import 'dart:convert';
import 'dart:io';

import 'package:cuidapet_fornecedor/app/models/chat_model.dart';
import 'package:cuidapet_fornecedor/app/modules/chats/chat/chat_controller.dart';
import 'package:cuidapet_fornecedor/app/repositories/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PushMessageConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> configure() async {
    final initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'br.com.lucianamenezes.cuidapet_fornecedor',
        'cuidapet_fornecedor',
        'CuidaPet Fornecedor',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker');

    final iOSPlataformChannelSpecifics = IOSNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlataformChannelSpecifics);

    if (Platform.isIOS) {
      await _fcm.requestNotificationPermissions(IosNotificationSettings());
      _fcm.onIosSettingsRegistered.listen((settings) {
        print('Configurações do iOS registrada $settings');
      });
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        String payload;

        if (Platform.isIOS) {
          payload = message['payload'];
        } else {
          payload = message['data']['payload'];
        }

        bool showMessage = true;

        try {
          //transformando o payload(json) em map<string,dynamic>
          final payloadData = json.decode(payload);
          if (payloadData['type'] == 'CHAT_MESSAGE') {
            //* se não tiver no modulo de chat, vai dar erro ao pegar a instancia do controller pois é uma dependencia do modulo.
            var chatController = Modular.get<ChatController>();
            if (chatController.chat.id == payloadData['data']['id']) {
              showMessage = false;
            }
          }
        } on ModularError {
          //Se não está no modulo, exibe a mensagem
          showMessage = true;
        }
        //Se o usuário tiver na tela do fornecedor que está recebendo a mensagem no chat, nao mostra a notificação
        if (showMessage) {
          String title, body;
          if (Platform.isIOS) {
            try {
              title = message['aps']['alert']['title'];
              body = message['aps']['alert']['body'];
            } on NoSuchMethodError {
              title = message['notification']['title'];
              body = message['notification']['body'];
            }
          } else {
            title = message['notification']['title'];
            body = message['notification']['body'];
          }
          await _flutterLocalNotificationsPlugin.show(
              99, title, body, platformChannelSpecifics,
              payload: payload);
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    String deviceId = await _fcm.getToken();
    final prefs = await SharedPrefsRepository.instance;
    prefs.registerDeviceId(deviceId);
  }

  Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    print(title);
  }

  //Quando clicar na notificação
  Future _onSelectNotification(String payload) {
    var chatController;
    if (payload != null) {
      final data = json.decode(payload);
      if (data['type'] == 'CHAT_MESSAGE') {
        final model = ChatModel.fromJson(data['chat']);
        bool abrirChat = true;
        try {
          chatController = Modular.get<ChatController>();
          if (chatController.chat.id == model.id) {
            abrirChat = false;
          }
        } on ModularError {
          abrirChat = true;
        }

        if (abrirChat) {
          Modular.to.pushNamed('/chats/chat', arguments: model);
        }
      }
    }
  }
}
