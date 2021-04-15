import 'package:api_base/blocs/video_bloc.dart';
import 'package:api_base/data_resources/api_services.dart';
import 'package:api_base/pages/detail_videos/detail_video_page.dart';
import 'package:api_base/resources/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'video_model.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {


  final videoBloc = VideoBloc();
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoBloc.fetchAllVideos();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoBloc.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final videoList = Provider.of<List<VideoModel>>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarVideoTitle),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder(
          stream: videoBloc.allVideo,
          builder: (context, snapshot)
          {
            if((snapshot.hasError)||(!snapshot.hasData))
              return Center(
                child: CircularProgressIndicator(),
              );
            List<VideoModel> videoList = snapshot.data;
            return GridView.builder
              (gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0),
                itemBuilder: (BuildContext context, int index){
                  return videoWidget(
                      videoList[index]
                  );
                });


          },
        ),

        /*
        child: FutureBuilder(
          future: ApiServices().getVideoList(),
          builder: (context, snapshot)
          {
            if((!snapshot.hasData)||(snapshot.hasError))
              return Center(
                child: Text("Loading....."),
              );
            List<VideoModel> videoList  = snapshot.data;
            return GridView.builder
              (gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0),
                itemBuilder: (BuildContext context, int index){
                return videoWidget(
                    videoList[index]

                );
                });
          },
        ),

         */


      ),
    );
  }
  // Wiget Video
 videoWidget(VideoModel videoModel){
    return GestureDetector(
      child: Container(
        child: Image.network(
          videoModel.url_photo,
          fit: BoxFit.cover,
        ),
      ),
      onTap: (){
      var route = MaterialPageRoute(builder: (context)=> DetailVideoPage(videoModel: videoModel,));
      Navigator.push(context, route);
      },
    );

 }

 videoListWidget({List<VideoModel> videoList})
 {
   List<Widget> videoListWidget = [] ;
   for (int i = 0; i< videoList.length; i++)
     {
       videoListWidget.add(videoWidget(videoList[i]));
     }
   return videoListWidget;
 }
}
