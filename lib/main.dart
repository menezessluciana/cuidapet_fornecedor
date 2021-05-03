import 'package:flutter/material.dart';
import 'package:cuidapet_fornecedor/app/app_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  //* O MAIN EXECUTA ASSIM QUE STARTA A APLICAÇÃO
  //*Inicializa o app ANTES do runApp
  WidgetsFlutterBinding.ensureInitialized();
  //*Definindo apenas uma orientação para o app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(ModularApp(module: AppModule()));
}
