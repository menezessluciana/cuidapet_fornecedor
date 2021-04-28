import 'package:cuidapet_fornecedor/app/core/theme_cuidapet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.addKey(Modular.navigatorKey),
      title: 'Cuidapet Fornecedor',
      theme: ThemeCuidapet.theme(),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Modular.generateRoute,
      navigatorObservers: [GetObserver()],
    );
  }
}
