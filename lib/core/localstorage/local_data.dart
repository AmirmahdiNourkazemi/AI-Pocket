import 'dart:convert';
import 'package:appro_chat/feature/status/data/model/status_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static final ValueNotifier<String> firstTokenNotifier = ValueNotifier('');
  static final ValueNotifier<String?> finalTokenNotifier = ValueNotifier(null);
  static final ValueNotifier<bool> isDark = ValueNotifier(false);
  static final ValueNotifier<bool> showIntro = ValueNotifier(false);
  static final ValueNotifier<StatusModel?> statusNotifier = ValueNotifier(null);
  static final ValueNotifier<Map<String, DateTime>> dateSelector =
      ValueNotifier({});
  static final ValueNotifier<String> ImageUrlNotifier = ValueNotifier('');
  static final ValueNotifier<int?> freeUsageCount = ValueNotifier(1);
  static final ValueNotifier<int?> storeMessageCount = ValueNotifier(1);

  Future<void> saveTheme(bool theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', theme);
    loadTheme();
  }

  Future<void> loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark.value = prefs.getBool('theme') ?? false;
  }

  Future<void> saveIntro(bool theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('intro', theme);
    loadIntro();
  }

  Future<void> loadIntro() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    showIntro.value = prefs.getBool('intro') ?? false;
  }

  Future<void> saveDateSelector(Map<String, DateTime> dateSelector) async {
    final prefs = await SharedPreferences.getInstance();

    // Convert DateTime to String before saving
    final jsonString = jsonEncode(
      dateSelector.map((key, value) => MapEntry(key, value.toIso8601String())),
    );

    await prefs.setString('dateSelector', jsonString);
    await loadDateSelector();
  }

  Future<Map<String, DateTime>> loadDateSelector() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('dateSelector');

    if (jsonString == null) {
      return {}; // return empty map if not found
    }

    // Decode JSON and convert String back to DateTime
    final Map<String, dynamic> decoded = jsonDecode(jsonString);
    dateSelector.value = decoded.map(
      (key, value) => MapEntry(key, DateTime.parse(value)),
    );

    return dateSelector.value;
  }

// ----------------------------------------------------------
  Future<void> saveStoreMessageCount(int count) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('storeMessageCount', count);
    loadStoreMessageCount();
  }

  Future<int?> loadStoreMessageCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    storeMessageCount.value = prefs.getInt('storeMessageCount');
  }

  Future<void> saveApproToken(String firstToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('approToken', firstToken);
    loadApproToken();
  }

  Future<void> loadApproToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    firstTokenNotifier.value = prefs.getString('approToken') ?? '';
  }

  Future<void> saveFinalToken(String finalToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('finalToken', finalToken);
    loadFinalToken();
  }

  Future<void> loadFinalToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    finalTokenNotifier.value = prefs.getString('finalToken');
  }

  Future<void> saveStatus(StatusModel status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String statusJson = jsonEncode(status.toJson());
    prefs.setString('statusEntity', statusJson);
    statusNotifier.value = status;
    loadStatus();
  }

  Future<StatusModel?> loadStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? statusJson = prefs.getString('statusEntity');

    if (statusJson != null) {
      Map<String, dynamic> statusMap = jsonDecode(statusJson);
      return statusNotifier.value = StatusModel.fromJson(statusMap);
    }
    return null; // Return null if not found
  }

  Future<void> saveImageUrl(String image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('image', image);
    loadImageUrl();
  }

  Future<void> loadImageUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ImageUrlNotifier.value = prefs.getString('image') ?? '';
  }

  Future<void> saveFreeUsageCount(int number) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('freeUsageCount', number);
    loadFreeUsageCount();
  }

  Future<int?> loadFreeUsageCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    freeUsageCount.value = prefs.getInt('freeUsageCount');
  }

  // Future<void> logOut() async {
  //   locator<UserLocalData>().clearUser();
  // }
}
