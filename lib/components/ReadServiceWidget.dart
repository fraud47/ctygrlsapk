import 'package:flutter/material.dart';
import '../config/index.dart';

class ReadServiceWidget extends StatelessWidget {
  const ReadServiceWidget(
      {@required String this.heading, @required String this.item});
  final String heading;
  final String item;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
          right: SizeConfig.blockSizeHorizontal * 10,
          left: SizeConfig.blockSizeHorizontal * 8,
          top: SizeConfig.blockSizeHorizontal * 1,
          bottom: SizeConfig.blockSizeVertical * 1),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          heading,
          textAlign: TextAlign.left,
          style: robotoBoldmdLabel,
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 40,
          child: Text(
            item,
            textAlign: TextAlign.left,
            style: roboto18Black,
            overflow: TextOverflow.clip,
          ),
        ),
      ]),
    );
  }
}
