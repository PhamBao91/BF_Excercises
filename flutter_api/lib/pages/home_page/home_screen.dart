import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/data_resources/api_services.dart';
import 'package:flutter_api/pages/detail_video/detail_video.dart';
import 'package:flutter_api/resources/strings.dart';

import 'video_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(videoAppBarTitle),
      ),
      body:Container(
        child: FutureBuilder(
            future: ApiServices().getVideoList(),
            builder: (context, snapshot){
              if((snapshot.hasError)||(!snapshot.hasData))
                return Center(
                  child: Text("Loading.."),
                );
              List<VideoModel> videoList = snapshot.data;
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0),
                  itemBuilder: (context, index){
                    return GestureDetector(
                      child: Image.network(
                        videoList[index].url_photo,
                        fit: BoxFit.cover,
                      ),
                      onTap: (){
                        var route = MaterialPageRoute(builder: (context)
                        => DetailVideo(videoModel: videoList[index],));
                        Navigator.push(context, route);
                      },
                    );

                  });

            }),
      ) ,
    );
  }
}
