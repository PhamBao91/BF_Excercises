import 'package:api_base/data_resources/api_urls.dart';
import 'package:api_base/pages/videos/video_model.dart';
import 'package:api_base/resources/strings.dart';
import 'package:api_base/resources/utils/logs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show convert, json;

class ApiServices{

  // Get the Video List
  Future<List<VideoModel>> getVideoList() async {
    List<VideoModel> videoList = [];
    var fullVideoUrl = ApiUrls().videoApiUrl;
    print(fullVideoUrl);

    var response = await http.get(fullVideoUrl);
    // Check Error from Backend
    Log().printLog(response.body.toString());
    // Get Body of Json File
    // Check structure of Api block
    var body = json.decode(response.body);
    Log().printJson(json: body);
    if(body['code'] == "success")
      {
        List mapList = body['list'];

        for(int i= 0; i<mapList.length; i++)
          {
            VideoModel videoModel = VideoModel.fromJson(mapList[i]);
            videoList.add(videoModel);
          }

      }
     else  throw Exception(apiLoadError);

     return videoList;

    }






}