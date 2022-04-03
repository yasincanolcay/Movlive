import 'package:flutter/material.dart';
import 'package:movlive/screens/radio_channel.dart';
import 'package:movlive/utils/channel.dart';
import 'package:movlive/widgets/live_tv_play_button.dart';

class LiveRadioChannelScreen extends StatefulWidget {
  const LiveRadioChannelScreen({Key? key}) : super(key: key);

  @override
  State<LiveRadioChannelScreen> createState() => _LiveRadioChannelScreenState();
}

class _LiveRadioChannelScreenState extends State<LiveRadioChannelScreen> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: channel.length,
          itemBuilder: (context, index) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width > 600 ? width * 0.3 : 0,
                    vertical: width > 600 ? 10 : 0,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black87,
                      image: DecorationImage(
                          image: NetworkImage(imagesUrl[index]),
                          fit: BoxFit.cover,
                          opacity: 0.4)),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Positioned(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(120, 0, 0, 0)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Icon(
                                  Icons.music_note,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(120, 0, 0, 0),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 11, bottom: 11, right: 15),
                                child: Text(
                                  channel[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        left: 0,
                      ),
                      Positioned(
                        child: BouncingButton(
                          index: index,
                        ),
                        right: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: BottomAppBar(
        color: Colors.purple,
      ),
    );
  }
}
