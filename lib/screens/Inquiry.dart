import 'package:city_girls/models/Service.dart';
import 'package:city_girls/screens/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:city_girls/controllers/index.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import '../providers/EmailProviders.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../config/index.dart';

import '../components/index.dart';

class Inquiry extends StatefulWidget {
  const Inquiry({@required Service this.service});
  final Service service;

  @override
  _InquiryState createState() => _InquiryState();
}

class _InquiryState extends State<Inquiry> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = new ScrollController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController about = TextEditingController();
  String _email;

  @override
  void dispose() {
    _scrollController.dispose();
    name.dispose();
    phone.dispose();
    about.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EmailProviders inquiry = Provider.of<EmailProviders>(context);
    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          strokeWidth: SizeConfig.blockSizeHorizontal * 1,
          color: Color(0xffE36A6A),
        )
      ],
    );

    var InquiryExec = () {
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        final Future<Map<String, dynamic>> response = inquiry.Inquiry(
            _email,
            name ?? "",
            widget.service.email ?? "",
            phone ?? "",
            about,
            widget.service.serviceName);

        response.then((response) {
          if (response['status']) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response['message']),
              duration: Duration(seconds: 3),
            ));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Navigation()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response['message']),
                duration: Duration(seconds: 3),
              ),
            );
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('inquiry failed'),
            duration: Duration(seconds: 6),
          ),
        );
      }
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black54,
            )),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
              width: SizeConfig.blockSizeHorizontal * 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  border: Border.all(
                      color: Colors.black.withOpacity(0.3), width: 1)),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    TextfieldPackage(
                      label: 'Name (Required)',
                      hint: "eg Sharon Banda",
                      maxLines: 0,
                      textController: name,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 10,
                            top: SizeConfig.blockSizeVertical * 4,
                            bottom: SizeConfig.blockSizeVertical * 1),
                        child: Text(
                          'Email',
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
                          validator: (input) =>
                              validateEmail(input) ? null : "Enter valid email",
                          //allocation of email to textfield
                          onSaved: (value) => _email = value,
                          decoration: InputDecoration(
                            hintText: 'hello@freshideas.co.zw',
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                          )),
                    ),
                    TextfieldPackage(
                      label: 'Phone',
                      hint: "eg 0772 111 111",
                      textController: phone,
                    ),
                    TextfieldPackage(
                      label: 'Message',
                      hint: "eg Im inquiring about ",
                      maxLines: 5,
                      textController: about,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    inquiry.InquiryStatus == StatusInquiry.Sending
                        ? loading
                        : InkWell(
                            child: BtnSmPrimary(
                              name: 'Send',
                            ),
                            onTap: () {
                              InquiryExec();
                            },
                          ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 12,
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
