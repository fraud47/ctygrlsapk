import 'package:city_girls/models/Service.dart';
import 'package:city_girls/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import '../config/index.dart';
import 'package:get_time_ago/get_time_ago.dart';

class CardItem extends StatelessWidget {
  const CardItem({@required Service this.service});
  final Service service;

  @override
  Widget build(BuildContext context) {
    var convertedTime = GetTimeAgo.parse(service.createdAt);
    // var format = DateFormat.yMd('ar');
    // var dateString = format.format(service.createdAt);
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        // print(service.id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ServiceDetail(
                      service: service,
                    )));
      },
      child: Container(
          width: SizeConfig.blockSizeHorizontal * 90,
          height: SizeConfig.blockSizeVertical * 35,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Card(
            elevation: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfilePicture(
                      name: '${service.serviceName}',
                      radius: 31,
                      fontsize: 21,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${service.serviceName}",
                            style: robotoBtnstyle,
                          ),
                          Text('${convertedTime}')
                        ]),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                      bottom: SizeConfig.blockSizeVertical * 0.5),
                  child: Text(
                    '${service.websiteUrl}',
                    style: robotoSmBlueUnderline,
                  ),
                ),
                ClipRRect(
                  child: Hero(
                      tag: service.id,
                      child: (service.logoUrl == null || service.logoUrl == "")
                          ? Image(
                              image: AssetImage('images/dummy.jpg'),
                              width: SizeConfig.blockSizeHorizontal * 80,
                              height: SizeConfig.blockSizeVertical * 15,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              '${service.logoUrl}',
                              width: SizeConfig.blockSizeHorizontal * 80,
                              height: SizeConfig.blockSizeVertical * 15,
                              fit: BoxFit.cover,
                            )),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.grey,
                    ))
              ],
            ),
          )),
    );
  }
}
