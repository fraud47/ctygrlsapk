import 'package:city_girls/config/index.dart';
import 'package:city_girls/models/videos.dart';

import '../models/videos.dart';

import 'package:dio/dio.dart';
import '../config/urls.dart';

Dio dio = Dio();

class VideoController {
  // location

  static Future<List<Videos>> getAll() async {
    try {
      Response response;

      response = await dio.get(
        AppUrl.allVideos,
      );

      if (response.statusCode == 200) {
        List<Videos> videos =
            response.data.map<Videos>((item) => Videos.fromJson(item)).toList();
        print(videos);
        print('vids');
        return videos;
      }
    } catch (e) {
      return null;
    }
  }
}
