import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import '../menu.dart';

class AnimationMail extends StatefulWidget {
  AnimationMail({Key key}) : super(key: key);

  @override
  _AnimationMailState createState() => _AnimationMailState();
}

class _AnimationMailState extends State<AnimationMail> {
  final riveFileName = 'assets/animations/mail.riv';
  Artboard _artboard;
  final timeout = Duration(seconds: 5);
  final ms = Duration(milliseconds: 1);

  Timer startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    // callback function
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Menu()));
  }

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  // loads a Rive file
  void _loadRiveFile() async {
    final bytes = await rootBundle.load(riveFileName);
    final file = RiveFile();

    if (file.import(bytes)) {
      setState(() => _artboard = file.mainArtboard
        ..addController(
          SimpleAnimation('mail'),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    startTimeout();
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Container(
              color: Colors.blue,
              child: _artboard != null
                  ? Rive(
                      artboard: _artboard,
                      fit: BoxFit.cover,
                    )
                  : Container()),
        ),
      ),
    );
  }
}
