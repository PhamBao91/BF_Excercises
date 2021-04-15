import 'package:api_base/data_resources/api_services.dart';
import 'package:api_base/pages/videos/video_model.dart';

class Repository {
  final ApiServices apiServices = ApiServices();
  Future<List<VideoModel>> fetchAllVideo() => apiServices.getVideoList();
}