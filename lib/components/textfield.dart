import 'package:flutter/material.dart';
import '../config/index.dart';

class TextfieldPackage extends StatefulWidget {
  const TextfieldPackage(
      {@required String this.label,
      @required String this.hint,
      @required int this.maxLines,
      TextEditingController this.textController,
      VoidCallback this.callback,
      String this.msg});

  final String label;
  final VoidCallback callback;
  final String msg;

  final String hint;
  final int maxLines;
  final TextEditingController textController;

  @override
  _TextfieldPackageState createState() => _TextfieldPackageState();
}

class _TextfieldPackageState extends State<TextfieldPackage> {
  var _label;
  bool complete = false;

  var _maxlines;
  var focusNode = FocusNode();
  @override
  void initState() {
    _label = widget.label;

    focusNode.addListener(() {
      print(focusNode.hasFocus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool tick = false;

    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 10,
                top: SizeConfig.blockSizeVertical * 4,
                bottom: SizeConfig.blockSizeVertical * 1),
            child: Text(
              _label,
              textAlign: TextAlign.left,
              style: robotoSmLabel,
            ),
          ),
        ]),
        Container(
          width: SizeConfig.blockSizeHorizontal * 80,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: TextFormField(
            validator: (String name) {
    if (name.isEmpty) {
    return "${widget.label} name cannot be empty";
    }},
              controller: widget.textController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: widget.hint,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              )),
        )
      ],
    );
  }
}
