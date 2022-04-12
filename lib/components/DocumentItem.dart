import 'package:city_girls/components/BtnSmPrimary.dart';
import 'package:city_girls/models/Document.dart';
import 'package:flutter/material.dart';
import '../config/index.dart';

import 'package:url_launcher/url_launcher.dart';

class DocumentItem extends StatelessWidget {
  const DocumentItem({@required Document this.document});
  final Document document;

  Widget build(BuildContext context) {
    _launchURL() async {
      if (!await launch(document.url)) throw 'Could not launch ${document.url}';
    }

    SizeConfig().init(context);
    return Container(
        width: SizeConfig.blockSizeHorizontal * 90,
        margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
        height: SizeConfig.blockSizeVertical * 45,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Card(
          elevation: 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 2,
              ),
              Container(
                color: Colors.red[500],
                width: SizeConfig.blockSizeHorizontal * 90,
                height: SizeConfig.blockSizeVertical * 25,
                child: Icon(
                  Icons.picture_as_pdf,
                  color: Colors.white,
                  size: SizeConfig.blockSizeHorizontal * 25,
                ),
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 4,
                width: SizeConfig.blockSizeHorizontal * 90,
                child: Text(
                  '${document.title}',
                  style: TextStyle(color: Colors.black54, fontSize: 26),
                ),
              ),
              Text('${document.desc}'),
              IconButton(
                  onPressed: () {
                    _launchURL();
                  },
                  icon: Icon(
                    Icons.download,
                    size: 36,
                  )),
              SizedBox(height: SizeConfig.blockSizeVertical * 1)
            ],
          ),
        ));
  }
}
