import 'package:flutter/material.dart';
import 'package:movlive/screens/live_radio_channel_screen.dart';
import 'package:movlive/utils/global_variables.dart';

class RadioChannelTabBar extends StatefulWidget {
  const RadioChannelTabBar({ Key? key }) : super(key: key);

  @override
  State<RadioChannelTabBar> createState() => _RadioChannelTabBarState();
}

class _RadioChannelTabBarState extends State<RadioChannelTabBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movlive',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.movie),
            leadingWidth: 50,
            titleSpacing: 0,
            title: Text('Movlive'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.purple,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Kanallar', icon: Icon(Icons.radio)),
                Tab(text: 'Tv izle', icon: Icon(Icons.tv)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
                Items[0],
                Items[1],
            ],
          ),
        ),
      ),
    );
  }
}