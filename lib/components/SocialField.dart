import 'package:flutter/material.dart';
import '../config/index.dart';

class SocialField extends StatelessWidget {
  const SocialField({
    @required String this.name,
    TextEditingController this.textController,
  });

  // Notice the variable type

  final String name;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: EdgeInsets.only(
          right: SizeConfig.blockSizeHorizontal * 15,
          left: SizeConfig.blockSizeHorizontal * 8,
          top: SizeConfig.blockSizeHorizontal * 1,
          bottom: SizeConfig.blockSizeVertical * 1),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          width: SizeConfig.blockSizeHorizontal * 20,
          child: TextField(
            decoration: InputDecoration(hintText: name),
          ),
        ),
        Container(
          width: SizeConfig.blockSizeHorizontal * 20,
          child: TextFormField(
            controller: textController,
            decoration: InputDecoration(hintText: 'eg @fr'),
          ),
        ),
        Text(
          'Add',
          textAlign: TextAlign.left,
          style: robotoSmBlack,
        ),
      ]),
    );
  }
}
