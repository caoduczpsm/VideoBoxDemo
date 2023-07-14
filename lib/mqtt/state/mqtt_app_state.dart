import 'package:flutter/cupertino.dart';

enum MQTTAppConnectionState { connected, disconnected, connecting }

class MQTTAppState with ChangeNotifier {
  MQTTAppConnectionState _appConnectionState = MQTTAppConnectionState.disconnected;
  final List<String> historyText = [];

  void setReceivedText(String text) {
    historyText.add(text);
    notifyListeners();
  }

  void setAppConnectionState(MQTTAppConnectionState state) {
    _appConnectionState = state;
    notifyListeners();
  }

  void clearListMessage() {
    historyText.clear();
    notifyListeners();
  }

  List<String> get getHistoryText => historyText.toList();

  MQTTAppConnectionState get getAppConnectionState => _appConnectionState;
}
