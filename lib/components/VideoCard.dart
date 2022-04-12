import 'package:city_girls/models/videos.dart';
import 'package:flutter/material.dart';
import '../config/index.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({@required Videos this.video});
  final Videos video;

  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      if (!await launch(video.url)) throw 'Could not launch ${video.url}';
    }

    var convertedTime = GetTimeAgo.parse(video.createdAt);
    // var format = DateFormat.yMd('ar');
    // var dateString = format.format(video.createdAt);
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        _launchURL();
      },
      child: Container(
          width: SizeConfig.blockSizeHorizontal * 90,
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
          height: SizeConfig.blockSizeVertical * 45,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Card(
            elevation: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                ClipRRect(
                  child: Hero(
                      tag: video.id,
                      child: Stack(children: [
                        Image(
                          image: AssetImage('images/gradient.png'),
                          width: SizeConfig.blockSizeHorizontal * 90,
                          height: SizeConfig.blockSizeVertical * 25,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            top: SizeConfig.blockSizeVertical * 7,
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 90,
                              height: SizeConfig.blockSizeVertical * 25,
                              child: Text(
                                '${video.title}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Positioned(
                          top: SizeConfig.blockSizeVertical * 7,
                          left: SizeConfig.blockSizeHorizontal * 37,
                          child: Icon(
                            Icons.play_circle_outlined,
                            color: Colors.black.withOpacity(0.3),
                            size: SizeConfig.blockSizeHorizontal * 20,
                          ),
                        ),
                      ])),
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 10,
                  width: SizeConfig.blockSizeHorizontal * 90,
                  child: Text(
                    '${video.desc}',
                    overflow: TextOverflow.clip,
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 1)
              ],
            ),
          )),
    );
  }
}
