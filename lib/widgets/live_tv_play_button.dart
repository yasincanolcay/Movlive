import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movlive/utils/channel.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class BouncingButton extends StatefulWidget {
  final int index;
  const BouncingButton({Key? key, required this.index}) : super(key: key);
  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;
  final List<StreamSubscription> _subscriptions = [];
  late AssetsAudioPlayer _assetsAudioPlayer;
  bool isPlaying = false;
  double width = 70;
  Icon icon = Icon(
    Icons.play_circle,
    color: Colors.white,
  );
  final audios = [
    Audio.network(
      channelUrl[0],
      metas: Metas(
        id: 'Alem fm',
        title: 'Alem fm',
        artist: 'canlı',
        album: 'Movlive',
        // image: MetasImage.network('https://www.google.com')
        image: MetasImage.network(
            'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
      ),
    ),
    Audio.network(
      channelUrl[1],
      metas: Metas(
        id: 'Power fm',
        title: 'Power fm',
        artist: 'canlı',
        album: 'Movlive',
        // image: MetasImage.network('https://www.google.com')
        image: MetasImage.network(
            'https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
      ),
    ),
    Audio.network(
      channelUrl[2],
      metas: Metas(
        id: 'Kral fm',
        title: 'Kral fm',
        artist: 'canlı',
        album: 'Movlive',
        // image: MetasImage.network('https://www.google.com')
        image: MetasImage.network(
            'https://images.unsplash.com/photo-1485726696757-76885c99f0f5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
      ),
    ),
    Audio.network(
      channelUrl[3],
      metas: Metas(
        id: 'Best fm',
        title: 'Best fm',
        artist: 'canlı',
        album: 'Movlive',
        // image: MetasImage.network('https://www.google.com')
        image: MetasImage.network(
            'https://images.unsplash.com/photo-1648554138014-6e8bedf46ed3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80'),
      ),
    ),
    Audio.network(
      channelUrl[4],
      metas: Metas(
        id: 'Karadeniz tr',
        title: 'Karadeniz tr',
        artist: 'canlı',
        album: 'Movlive',
        // image: MetasImage.network('https://www.google.com')
        image: MetasImage.network(
            'https://images.unsplash.com/photo-1599244906207-340e4cf1b2bd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=406&q=80'),
      ),
    ),
    Audio.network(
      channelUrl[5],
      metas: Metas(
        id: 'Fenomen fm',
        title: 'Fenomen fm',
        artist: 'canlı',
        album: 'Movlive',
        // image: MetasImage.network('https://www.google.com')
        image: MetasImage.network(
            'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
      ),
    ),
  ];

  void openPlayer() async {
    try{
        await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: widget.index),
      showNotification: true,
      autoStart: false,
    );
    }catch(e){
    }
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    //_subscriptions.add(_assetsAudioPlayer.playlistFinished.listen((data) {
    //  print('finished : $data');
    //}));
    //openPlayer();
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));

    openPlayer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
    _assetsAudioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return StreamBuilder(
        stream: _assetsAudioPlayer.current,
        builder: (context, playing) {
        
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: GestureDetector(
                  onTapDown: _tapDown,
                  onTapUp: _tapUp,
                  onTap: () {
                    _onlyTap();
                  },
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButton(),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _animatedButton() {
    return Container(
      height: 70,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x80000000),
            blurRadius: 12.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(170, 108, 8, 190),
            Color.fromARGB(170, 153, 80, 116),
            Color.fromARGB(170, 85, 26, 223),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: icon),
          isPlaying == true
              ? Text(
                  ' Oynatılıyor...',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                )
              : Container(),
        ],
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller!.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller!.reverse();
  }

  void _onlyTap() async {
    if (isPlaying == true) {
      _assetsAudioPlayer.pause();
      isPlaying = false;
      setState(() {
        icon = Icon(
          Icons.play_circle,
          color: Colors.white,
        );
        width = 70;
      });
    } else {
      _assetsAudioPlayer.play();
      isPlaying = true;
      setState(() {
        icon = Icon(
          Icons.pause_circle,
          color: Colors.white,
        );
        width = 150;
      });
    }
  }
}
