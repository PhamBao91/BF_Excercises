import 'package:flutter_api/data_resources/api_urls.dart';
import 'package:flutter_api/pages/home_page/video_model.dart';
import 'package:flutter_api/resources/strings.dart';
import 'package:flutter_api/resources/utils/logs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class ApiServices {

  // get Video List
  getVideoList() async {
    List<VideoModel> videoList = [];
    var fullVideoUrl = ApiUrls().videoApiUrl;

    var response = await http.get(fullVideoUrl);
    //Logs().printLog(string: response.body.toString());

   // print(response.toString());


   // Logs().printJson(json: body);

    if(response.statusCode == 200){

      var body = json.decode(response.body);
      List listJson = body['list'];
      //Logs().printJson(json: listJson[0]);
      for(int i = 0; i < listJson.length ; i++ )
        {
          //var json = listJson[i];
          print("Here");
          VideoModel videoModel = VideoModel.fromJson(listJson[i]);
          print("Độ dài:" + videoList.length.toString());
          videoList.add(videoModel);

        }


    }
    else throw Exception(errorFromApi);
    return videoList;
  }

}