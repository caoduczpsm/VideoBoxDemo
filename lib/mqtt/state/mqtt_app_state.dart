import 'package:flutter/cupertino.dart';

enum MQTTAppConnectionState { connected, disconnected, connecting }

class MQTTAppState with ChangeNotifier {
  MQTTAppConnectionState _appConnectionState = MQTTAppConnectionState.disconnected;
  final List<String> _historyText = [];

  void setReceivedText(String text) {
    _historyText.add(text);
    notifyListeners();
  }

  void setAppConnectionState(MQTTAppConnectionState state) {
    _appConnectionState = state;
    notifyListeners();
  }

  void clearListMessage() {
    _historyText.clear();
    notifyListeners();
  }

  List<String> get getHistoryText => _historyText.toList();

  MQTTAppConnectionState get getAppConnectionState => _appConnectionState;
}
