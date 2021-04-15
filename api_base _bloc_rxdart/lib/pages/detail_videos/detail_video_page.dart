import 'package:api_base/pages/videos/video_model.dart';
import 'package:api_base/pages/videos/video_page.dart';
import 'package:api_base/resources/widgets/play_audio_widget.dart';
import 'package:api_base/resources/widgets/video_player_item.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:video_player/video_player.dart';

class DetailVideoPage extends StatefulWidget {
  final VideoModel videoModel;

  const DetailVideoPage({Key key, this.videoModel}) : super(key: key);
  @override
  _DetailVideoPageState createState() => _DetailVideoPageState();
}

class _DetailVideoPageState extends State<DetailVideoPage> {
  FlickManager flickManager;
  String linkVideo ;
  AudioPlayer player;
  double statusBarHeight ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player = AudioPlayer();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.videoModel.url_video),

    );

  }

  @override
  void dispose() {
    // TODO: implement dispose
    flickManager.dispose();
    super.dispose();
    player.dispose();
    player.stop();
    player.pause();


  }
  @override
  Widget build(BuildContext context) {
    statusBarHeight  = MediaQuery.of(context).padding.top ;
    bool isAudio = false;
    linkVideo = widget.videoModel.url_video;
    linkVideo.substring(linkVideo.length - 3)=='mp3' ? isAudio = true : isAudio = false;
    print(linkVideo.substring(linkVideo.length - 3));
    int rate = 5;
    int grid_rate = 8;
    MediaQuery.of(context).size.height >= 900 ? grid_rate = 7 : grid_rate = 8;

    //isAudio ? rate = 14: rate = 5 ;


    return Scaffold(
      backgroundColor: Color(0xffEEF3FA),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: statusBarHeight),
          child: Column(
            children: [
              Expanded(
                  flex: rate,
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          child: linkVideo.substring(linkVideo.length - 3)=='mp3' ?
                          PlayAudioWidget(videoModel: widget.videoModel, audioPlayer: player,)
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: VideoPlayerItem(videoModel: widget.videoModel, flickManager: flickManager,),
                              ),

                              Container(
                                child: SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.videoModel.title ,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Colors.black.withOpacity(0.6)
                                          ),),

                                        Text(widget.videoModel.author.toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        //horizontal_line(context)
                                      ],
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 20, left: 10),
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent
                                ),
                                child: Icon(Icons.arrow_back_ios,
                                  color: linkVideo.substring(linkVideo.length - 3)=='mp3' ? Colors.black : Colors.white70,
                                  size: 20,),
                              ),
                              onTap: (){
                                player.stop();
                                var route = MaterialPageRoute(builder: (context)=> VideoPage());
                                Navigator.push(context, route);
                              },
                            )
                        ),

                      ],
                    ),
                  )
              ),


            ],
          ),
        ),

      ),

    ) ;


  }
}
