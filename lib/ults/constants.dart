 class Constants{

  static const String baseUrl = "https://648a17fb5fa58521cab0cbe6.mockapi.io/api/v1/";
  static const String messageUrl = "${baseUrl}message";
  static const String videoUrl = "${baseUrl}video";

  static const String fontName = "times-new-roman-14";
  static const double textTitleSize = 24;
  static const double textBodySize = 18;
  static const double borderRadius = 10;

  static const String listenTopic = "pub/dt/#";
  static const String publishToOldDevice = "api/mqtt/test";
  static const String publishToNewDevice = "api/mqtt/newDevice/";
  static const String newDevice = "#newDevice#";
 }