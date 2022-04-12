import 'package:city_girls/controllers/videoController.dart';

import 'package:city_girls/models/videos.dart';
import 'package:flutter/foundation.dart';

class VideoProvider extends ChangeNotifier {
  List<Videos> _videos = [];

  getVideos() async {
    List<Videos> videos = await VideoController.getAll();
    if (videos != null) {
      _videos = videos;
      notifyListeners();
    }
  }

  set videos(value) => this._videos = value;
  get videos => _videos;
}
