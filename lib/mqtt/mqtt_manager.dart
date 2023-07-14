// ignore: depend_on_referenced_packages
// ignore_for_file: avoid_print

import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:mqtt_client/mqtt_client.dart';
// ignore: depend_on_referenced_packages
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:video_box_demo/models/message_model.dart';
import 'package:video_box_demo/mqtt/state/mqtt_app_state.dart';
import '../api/api_manager.dart';
import '../ults/constants.dart';
import '../video_box_demo/main/video_box_controller.dart';

class MQTTManager {
  final MQTTAppState currentState;
  MqttServerClient? _client;
  final String _identifier;
  final String _host;
  final APIManager _apiManager;

  MQTTManager({
    required String host,
    required String identifier,
    required MQTTAppState state,
  })  : _identifier = identifier,
        _host = host,
        currentState = state,
        _apiManager = APIManager();

  void initializeMQTTClient() {
    _client = MqttServerClient(_host, _identifier);
    _client!.port = 1883;
    _client!.keepAlivePeriod = 20;
    _client!.onDisconnected = onDisconnected;
    _client!.secure = false;
    _client!.logging(on: true);

    /// Add the successful connection callback
    _client!.onConnected = onConnected;
    _client!.onSubscribed = onSubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    _client!.connectionMessage = connMess;
  }

  void connect() async {
    assert(_client != null);
    currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
    await _client!.connect();
  }

  void disconnect() {
    _client!.disconnect();
  }

  void publish(Message message, String deviceId, bool isNew) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(jsonEncode(message));
    if (!isNew) {
      _client!.publishMessage(
        Constants.publishToOldDevice,
        MqttQos.atMostOnce,
        builder.payload!,
        retain: false,
      );
    } else {
      String newConnection = Constants.publishToNewDevice + deviceId;
      _client!.publishMessage(
        newConnection,
        MqttQos.atMostOnce,
        builder.payload!,
        retain: false,
      );
    }
  }

  void onSubscribed(String topic) {}

  void onDisconnected() {
    if (_client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {}
    currentState.clearListMessage();
    currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
  }

  void onConnected() {
    currentState.setAppConnectionState(MQTTAppConnectionState.connected);
    _client!.subscribe(Constants.listenTopic, MqttQos.atMostOnce);

    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

      List<int> bytes = recMess.payload.message;
      String pt = utf8.decode(bytes);
      print("pt $pt");
      Message message = Message.fromJson(jsonDecode(pt));

      Get.find<VideoController>().setMessage(message);
      Get.find<VideoController>().isShowingNewsFeed.value = false;

      updateMessageContent(pt);
    });
  }


  void updateMessageContent(String pt) {
    currentState.setReceivedText(pt);
  }
}
