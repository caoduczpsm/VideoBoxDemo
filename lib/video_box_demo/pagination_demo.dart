import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_box_demo/video_box_demo/right_part.dart';
import '../api/api_manager.dart';
import '../api/message_model.dart';
import 'left_part.dart';

class MainPart extends StatefulWidget {
  const MainPart({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainPartState createState() => _MainPartState();
}

class _MainPartState extends State<MainPart> {
  Message? _selectedMessage;
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    fetchMessage();
  }

  Stream<List<Message>> fetchMessage() async* {
    // This loop will run forever to check for new data from API
    while (true) {
      List<Message> messages = await APIManager().getMessages();
      yield messages; // Emit the messages as a stream
      await Future.delayed(const Duration(seconds: 1)); // Pause for 1 second
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Demo Video Box'),
        ),
        body: StreamBuilder<List<Message>>(
          stream: fetchMessage(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              _messages = snapshot.data!;
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: LeftPart(
                            messages: _messages,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedMessage =
                                    Message(message: "#playVideo#");
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent),
                            ),
                            child: const Text(
                              'Play Video',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 70),
                    child: const VerticalDivider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      child: RightPart(
                        selectedMessage: _selectedMessage,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
