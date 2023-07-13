// ignore: depend_on_referenced_packages
import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_box_demo/ults/constants.dart';
import '../../models/message_model.dart';

class NewsFeedPart extends StatefulWidget {
  const NewsFeedPart({Key? key, required this.messages}) : super(key: key);

  final List<Message> messages;

  @override
  // ignore: library_private_types_in_public_api
  State<NewsFeedPart> createState() => _NewsFeedPartState();
}

class _NewsFeedPartState extends State<NewsFeedPart> {
  int currentIndex = -1;

  void updateIndex() {
    setState(() {
      currentIndex =
          currentIndex < widget.messages.length - 1 ? currentIndex + 1 : 0;
    });
    Timer(const Duration(seconds: 10), updateIndex);
  }

  void previousPage() {
    setState(() {
      currentIndex =
          currentIndex > 0 ? currentIndex - 1 : widget.messages.length - 1;
    });
  }

  void nextPage() {
    setState(() {
      currentIndex =
          currentIndex < widget.messages.length - 1 ? currentIndex + 1 : 0;
    });
  }

  @override
  void initState() {
    super.initState();
    updateIndex();
  }

  final textTitleStyle = const TextStyle(
      fontSize: Constants.textTitleSize,
      fontWeight: FontWeight.bold,
      fontFamily: Constants.fontName);
  final textDescriptionStyle = const TextStyle(
      fontSize: Constants.textBodySize, fontFamily: Constants.fontName);
  final currentPageTextStyle = const TextStyle(
      fontSize: Constants.textBodySize,
      color: Colors.blueAccent,
      fontWeight: FontWeight.bold,
      fontFamily: Constants.fontName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 19,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, -1.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: RotationTransition(
                      turns: Tween<double>(
                        begin: -0.125,
                        end: 0.0,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Container(
                    key: ValueKey<int>(currentIndex),
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            child: Center(
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: CachedNetworkImage(
                                      imageUrl: widget
                                          .messages[currentIndex].imageUrl!,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Column(
                              children: [
                                Text(
                                  widget.messages[currentIndex].message!,
                                  style: textTitleStyle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  widget.messages[currentIndex].description!,
                                  style: textDescriptionStyle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: previousPage,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text(
                    '${currentIndex + 1}',
                    style: currentPageTextStyle,
                  ),
                  Text(
                    ' / ${widget.messages.length}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: nextPage,
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
