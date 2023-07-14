
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:video_box_demo/models/message_model.dart';
import 'package:marquee/marquee.dart';

import '../../ults/constants.dart';

class SosNews extends StatelessWidget {
  const SosNews({Key? key, required this.message}) : super(key: key);

  final Message message;

  final textTitleStyle = const TextStyle(
      color: Colors.red,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: Constants.fontName);

  final textContentStyle = const TextStyle(
      color: Colors.black54, fontSize: 18, fontFamily: Constants.fontName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Marquee(
                blankSpace: 50,
                text: message.payload!.TieuDe!,
                style: textTitleStyle,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                message.payload!.NoiDungTomTat!,
                textAlign: TextAlign.justify,
                maxLines: 10,
                style: textContentStyle,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
