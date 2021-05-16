// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    email: json['email'] as String,
    avatar: json['avatar'] as String,
    imgAvatar: json['imgAvatar'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'avatar': instance.avatar,
      'imgAvatar': instance.imgAvatar,
    };
