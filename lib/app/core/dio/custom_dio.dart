//Encapsulando o dio - SINGLE - APENAS UMA INSTANCIA
import 'package:cuidapet_fornecedor/app/core/dio/auth_interceptor_wrapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomDio {
  static CustomDio _simpleInstance;
  static CustomDio _authInstance;

  Dio _dio;

  BaseOptions options = BaseOptions(
      baseUrl: DotEnv().env['base_url'],
      connectTimeout: int.parse(DotEnv().env['dio_connectTimeout']),
      receiveTimeout: int.parse(DotEnv().env['dio_receiveTimeout']));

  //Construtor privado - NÃO DEIXA CRIAR UMA INSTANCIA DA CLASSE
  CustomDio._() {
    _dio = Dio(options);
  }

  CustomDio._auth() {
    _dio = Dio(options);
    _dio.interceptors.add(AuthInterceptorWrapper());
  }

  static Dio get instance {
    //Se for nulo, cria uma nova instancia. Não é inicializada, então a primeira vez será null.
    _simpleInstance ??= CustomDio._();
    return _simpleInstance._dio;
  }

  //criando uma instancia autenticada
  static Dio get authInstance {
    _authInstance ??= CustomDio._auth();
    return _authInstance._dio;
  }
}
