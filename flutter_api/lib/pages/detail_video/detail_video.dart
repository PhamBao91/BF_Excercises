import 'package:flutter/material.dart';
import 'package:flutter_api/pages/home_page/video_model.dart';
import 'package:flutter_api/resources/strings.dart';
class DetailVideo extends StatefulWidget {
  final VideoModel videoModel;

  const DetailVideo({Key key, @required this.videoModel}) : super(key: key); 
  
  @override
  _DetailVideoState createState() => _DetailVideoState();
}

class _DetailVideoState extends State<DetailVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detailVideoAppBarTitle),
      ),
      body: Container(     
      padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            imageWidget(widget.videoModel),
            titleWidget(widget.videoModel),
            descriptionWidget(widget.videoModel)
          ],
        ),
      ),
    );
  }
  
  imageWidget(VideoModel videoModel){
    
    return Image.network(videoModel.url_photo, fit: BoxFit.cover,);
  }
  
  titleWidget(VideoModel videoModel){
    return Text(videoModel.title);
  }

  descriptionWidget(VideoModel videoModel){
    return Text(videoModel.description);
  }
}
