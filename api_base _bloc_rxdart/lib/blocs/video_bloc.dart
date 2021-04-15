import 'package:api_base/data_resources/repository/repository.dart';
import 'package:api_base/pages/videos/video_model.dart';
import 'package:rxdart/rxdart.dart';

class VideoBloc {
  final _repository = Repository();

  // Tạo Stream
 final videoSubject  = PublishSubject<List<VideoModel>>();

 // nhúng data từ Data Layer vào Stream
 fetchAllVideos () async {
   List<VideoModel> videoList = await _repository.fetchAllVideo();
   videoSubject.sink.add(videoList);
 }

 // xuất Stream
  Stream<List<VideoModel>> get allVideo => videoSubject.stream;

 // dispose Bloc
 dispose()
 {
   videoSubject.close();
 }









}