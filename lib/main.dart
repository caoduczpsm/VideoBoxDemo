import 'package:flutter/material.dart';
import 'package:video_box_demo/video_box_demo/pagination_demo.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:video_box_demo/video_box_demo/plash_screen.dart';
import 'mqtt/state/mqtt_app_state.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/mainPart':
            return MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider<MQTTAppState>(
                  create: (_) => MQTTAppState(),
                  child: const MainPart(),
                ));
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
      // home: ChangeNotifierProvider<MQTTAppState>(
      //   create: (_) => MQTTAppState(),
      //   child: const MainPart(),
      // )
    );
  }
}