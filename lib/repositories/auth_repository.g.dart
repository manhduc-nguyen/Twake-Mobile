// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRepository _$AuthRepositoryFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'token',
    'refresh_token',
    'expiration',
    'refresh_expiration'
  ]);
  return AuthRepository()
    ..accessToken = json['token'] as String
    ..refreshToken = json['refresh_token'] as String
    ..accessTokenExpiration = json['expiration'] as int
    ..refreshTokenExpiration = json['refresh_expiration'] as int
    ..twakeConsole = json['twake_console'] as String
    ..authMode = json['auth_mode'] as String
    ..socketIOHost = json['socket_io_host'] as String;
}

Map<String, dynamic> _$AuthRepositoryToJson(AuthRepository instance) =>
    <String, dynamic>{
      'token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expiration': instance.accessTokenExpiration,
      'refresh_expiration': instance.refreshTokenExpiration,
      'twake_console': instance.twakeConsole,
      'auth_mode': instance.authMode,
      'socket_io_host': instance.socketIOHost,
    };
