import 'dart:convert';

import 'package:cuidapet_fornecedor/app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/_ACCESS_TOKEN/';
  static const _DEVICE_ID = '/_DEVICE_ID/';
  static const _USER_DATA = '/_USER_DATA/';
  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository;
  }

  Future<void> registerAcessToken(String token) async {
    await prefs.setString(_ACCESS_TOKEN, token);
  }

  String get accessToken => prefs.get(_ACCESS_TOKEN);

  void registerDeviceId(String deviceId) async {
    await prefs.setString(_DEVICE_ID, deviceId);
  }

  String get deviceId => prefs.get(_DEVICE_ID);

  void registerUserData(UserModel usuario) async {
    //*JSON ENCODE = Transforma um objeto em uma string
    await prefs.setString(_USER_DATA, jsonEncode(usuario));
  }

  UserModel get userData {
    //* Não pode passar um valor null pro jsonDecode
    if (prefs.containsKey(_USER_DATA)) {
      //*JSON DECODE = Transforma string em um Map<String, dynamic>
      Map<String, dynamic> userMap = jsonDecode(prefs.getString(_USER_DATA));
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  Future<void> logout() async {
    await Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
  }
}
