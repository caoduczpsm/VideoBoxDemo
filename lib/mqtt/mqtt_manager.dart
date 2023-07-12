// ignore: depend_on_referenced_packages
import 'package:mqtt_client/mqtt_client.dart';
// ignore: depend_on_referenced_packages
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:video_box_demo/mqtt/state/mqtt_app_state.dart';

import '../api/api_manager.dart';
import '../api/message_model.dart';

class MQTTManager {
  // Private instance of client
  final MQTTAppState _currentState;
  MqttServerClient? _client;
  final String _identifier;
  final String _host;
  final APIManager _apiManager;

  static const String listenTopic = "pub/dt/#";
  static const String publishToOldDevice = "api/mqtt/test";
  static const String publishToNewDevice = "api/mqtt/newDevice/";
  static const String newDevice = "#newDevice#";

  // Constructor
  // ignore: sort_constructors_first
  MQTTManager(
      {required String host,
      required String identifier,
      required MQTTAppState state})
      : _identifier = identifier,
        _host = host,
        _currentState = state,
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

  // Connect to the host
  // ignore: avoid_void_async
  void connect() async {
    assert(_client != null);
    _currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
    await _client!.connect();
  }

  void disconnect() {
    _client!.disconnect();
  }

  void publish(Message message, String deviceId, bool isNew) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message.message!);
    if (!isNew) {
      // Use QoS 0 for publishing
      _client!.publishMessage(
          publishToOldDevice, MqttQos.atMostOnce, builder.payload!,
          retain: false);
    } else {
      String newConnection = publishToNewDevice + deviceId;
      _client!.publishMessage(
          newConnection, MqttQos.atMostOnce, builder.payload!,
          retain: false);
    }
  }

  /// The subscribed callback
  void onSubscribed(String topic) {}

  /// The unsolicited disconnect callback
  void onDisconnected() {
    if (_client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {}
    _currentState.clearListMessage();
    _currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
  }

  /// The successful connect callback
  void onConnected() {
    _currentState.setAppConnectionState(MQTTAppConnectionState.connected);
    // Use QoS 0 for subscribing
    _client!.subscribe(listenTopic, MqttQos.atMostOnce);
    //_client!.subscribe('api/mqtt/newDevice/#', MqttQos.atLeastOnce);

    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      // ignore: avoid_as
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _currentState.setReceivedText(pt);

      if (pt.contains(newDevice)) {
        List<String> parts = pt.split(",");
        String deviceId = parts[0];
        _apiManager.getMessages().then((List<Message> messages) {
          for (Message message in messages) {
            publish(message, deviceId, true);
          }
        });
      } else if (pt == "#playVideo#") {
        getMessageMQTT(Message(message: pt));
      } else {
        _apiManager.submit(pt);
        publish(Message(message: pt), "", false);
      }
    });
  }

  Message getMessageMQTT(Message message) {
    return message;
  }
}
