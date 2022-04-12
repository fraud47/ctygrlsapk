import 'package:flutter/material.dart';
import '../config/index.dart';

class accessBtn extends StatelessWidget {
  accessBtn({@required String this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SizeConfig().init(context);

    return Container(
      width: SizeConfig.blockSizeHorizontal * 80,
      height: SizeConfig.blockSizeVertical * 8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5)),
      child: TextButton(
        child: Text(
          name,
          style: robotoBtnstyle,
        ),
        onPressed: null,
      ),
    );
  }
}
