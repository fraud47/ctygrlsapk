import 'package:city_girls/components/VideoCard.dart';
import 'package:city_girls/providers/videoProvider.dart';
import 'package:flutter/material.dart';
import '../config/index.dart';
import '../components/index.dart';
import '../providers/ServiceProvider.dart';
import 'package:provider/provider.dart';

import 'ServiceDetail.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({@required String this.name, @required String this.ey});

  final String name;
  final String ey;

  @override
  Widget build(BuildContext context) {
    VideoProvider video = Provider.of<VideoProvider>(context);
    var videos = video.videos;
    var length;
    length = videos.length;

    return ListView.builder(
      key: PageStorageKey(ey),
      itemBuilder: (BuildContext context, int index) {
        return VideoCard(
          video: videos[index],
        );
      },
      itemCount: length,
    );
  }
}
