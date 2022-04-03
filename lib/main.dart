import 'package:flutter/material.dart';
import 'package:movlive/screens/live_radio_channel_screen.dart';
import 'package:movlive/screens/radio_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movlive',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const RadioChannelTabBar(),
    );
  }
}
