import 'package:flutter/foundation.dart';
import 'package:niaz_shopping/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static final SharedPreferences pref = locator.get();
  static final ValueNotifier authChangeNotifire = ValueNotifier(null);

  // see intro pages for first time
  changeIntroState() {
    pref.setBool("showIntro", false);
  }

  Future<bool> getIntroState() async {
    return pref.getBool("showIntro") ?? true;
  }

  // user ID
  static void saveId(String id) async {
    pref.setString('access_id', id);
    authChangeNotifire.value = id;
  }

  static String readId() {
    print(pref.getString('access_id'));
    return pref.getString('access_id') ?? '';
  }

  // user sendCode
  static void saveCode(String code) async {
    pref.setString('access_code', code);
    authChangeNotifire.value = code;
  }

  static String readCode() {
    print(pref.getString('access_code'));
    return pref.getString('access_code') ?? '';
  }

  // user name
  static void saveName(String name) async {
    pref.setString('access_name', name);
    authChangeNotifire.value = name;
  }

  static String readName() {
    print(pref.getString('access_name'));
    return pref.getString('access_name') ?? '';
  }

  // user phone
  static void savePhone(String phone) async {
    pref.setString('access_phone', phone);
    authChangeNotifire.value = phone;
  }

  static String readPhone() {
    print(pref.getString('access_phone'));
    return pref.getString('access_phone') ?? '';
  }

  // user phone
  static void saveToken(String token) async {
    pref.setString('access_token', token);
    authChangeNotifire.value = token;
  }

  static String readToken() {
    print(pref.getString('access_token'));
    return pref.getString('access_token') ?? '';
  }

  // logout
  static void logOut() {
    pref.clear();
    authChangeNotifire.value = null;
  }
}
