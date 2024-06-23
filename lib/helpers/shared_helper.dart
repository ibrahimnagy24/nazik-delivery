// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:flutter_base/utility/utility.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_base/features/auth/login/model/user_model.dart';
import 'package:flutter_base/helpers/translation/all_translation.dart';
import 'package:flutter_base/navigation/custom_navigation.dart';
import 'package:flutter_base/navigation/routes.dart';
import 'package:flutter_base/core/enums.dart';

class CachingKey extends Enum<String> {
  const CachingKey(super.val);
  static const CachingKey USER = CachingKey('USER');
  static const CachingKey TOKEN = CachingKey('REAL_TOKEN');
  static const CachingKey IS_LOGIN = CachingKey('IS_LOGIN');
  static const CachingKey SKIP = CachingKey('SKIP');
  static const CachingKey PERSONAL_ID = CachingKey('PERSONAL_ID');
  static const CachingKey SITE_ID = CachingKey('SITE_ID');
  static const CachingKey URL_CODE = CachingKey('URL_CODE');
  static const CachingKey USER_LAT = CachingKey('USER_LAT');
  static const CachingKey USER_LONG = CachingKey('USER_LONG');
  static const CachingKey CHECK_LOCATION = CachingKey('CHECK_LOCATION');
  static const CachingKey ADDRESS = CachingKey('ADDRESS');
  static const CachingKey COUNTRY = CachingKey('COUNTRY');
  static const CachingKey COUNTRY_NAME = CachingKey('COUNTRY_NAME');
  static const CachingKey IS_OPEN_SITTING = CachingKey('IS_OPEN_SITTING');
  static const CachingKey USER_SECOND = CachingKey('USER_SECOND');
  static const CachingKey USER_MINUTE = CachingKey('USER_MINUTE');
  static const CachingKey USER_HOURS = CachingKey('USER_HOURS');
}

class SharedHelper {
  static SharedHelper? sharedHelper = SharedHelper();
  static Box? box;
  static init() async {
    if (box == null) {
      await Hive.initFlutter();
      box = await Hive.openBox('testBox');
      sharedHelper = SharedHelper();
    }
  }

  removeData(CachingKey key) async {
    box?.delete(key.value);
  }

  Future<UserModel> getUser() async {
    UserModel user;
    user = UserModel().fromJson(jsonDecode(box?.get(CachingKey.USER.value)!))
        as UserModel;
    log('USER INFO >>> ${user.toJson()}');
    return user;
  }

  clear(CachingKey key) async {
    box?.clear();
  }

  logout() async {
    String currentLang = await allTranslations.getPreferredLanguage();
    box?.clear();
    CustomNavigator.push(Routes.SPLASH, clean: true);
    SharedHelper.sharedHelper?.writeData(CachingKey.SKIP, true);
    allTranslations.setNewLanguage(currentLang, true);
    allTranslations.setPreferredLanguage(currentLang);
  }

  Future<void> writeData(CachingKey key, value) async {
    cprint("Saving => $value local => with key ${key.value}");
    if (value is String) {
      box?.put(key.value, value);
    } else if (value is int) {
      box?.put(key.value, value);
    } else if (value is bool) {
      box?.put(key.value, value);
    } else if (value is double) {
      box?.put(key.value, value);
    } else {
      return;
    }
  }

  Future<bool> readBoolean(CachingKey key) async {
    return Future.value(box?.get(key.value) ?? false);
  }

  Future<double> readDouble(CachingKey key) async {
    return Future.value(box?.get(key.value) ?? 0.0);
  }

  Future<int> readInteger(CachingKey key) async {
    return Future.value(box?.get(key.value) ?? 0);
  }

  Future<String> readString(CachingKey key) async {
    return Future.value(box?.get(key.value) ?? "");
  }
}
