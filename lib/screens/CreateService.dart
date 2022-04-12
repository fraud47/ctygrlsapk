import 'dart:io';
import 'package:path/path.dart';
import 'package:city_girls/controllers/index.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../config/index.dart';
import '../components/index.dart';

class CreateService extends StatefulWidget {
  @override
  State<CreateService> createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  final _formKey = GlobalKey<FormState>();

  String imgUrl;
  String dropdownValue;
  String categoryItem;
  final ScrollController _scrollController = new ScrollController();
  TextEditingController _serviceName = TextEditingController();
  TextEditingController _categoryItem = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _websiteUrl = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _ig = TextEditingController();
  TextEditingController _fb = TextEditingController();
  TextEditingController _tw = TextEditingController();
  TextEditingController _yt = TextEditingController();

  bool value = false;
  bool value2 = false;
  bool uploading = false;
  bool uploaded = false;


  // late Future<PickedFile?> pickedFile = Future.value(null);


  var path = '';
  var imgname = '';

  void getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        setState(() {
          path = image.path;
          imgname = basename(image.path);
        });
      }
    });
  }

  Future<String> postCloudinary() async {
    if (path == null) {
      exit(0);
    } else {
      final cloudinary =
          CloudinaryPublic('citygirls9qmb', 'cljwqn0f', cache: false);
      try {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(path,
              resourceType: CloudinaryResourceType.Image),
        );
        setState(() {
          imgUrl = response.secureUrl;
        });
        return response.secureUrl;
      } on CloudinaryException catch (e) {
        print(e.message);
        return "";
        print(e.request);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _serviceName.dispose();
    _categoryItem.dispose();
    _desc.dispose();
    _websiteUrl.dispose();
    _email.dispose();
    _phone.dispose();
    _ig.dispose();
    _fb.dispose();
    _tw.dispose();
    _yt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          strokeWidth: SizeConfig.blockSizeHorizontal * 2,
          color: Color(0xffE36A6A),
        )
      ],
    );
    UserProvider user = Provider.of<UserProvider>(context);

    postService() {
      setState(() {
        uploading = true;
      });
      final Future<Map<String, dynamic>> response =
          ServiceController.postService(
              accessToken: user.user.accessToken,
              serviceName: _serviceName.text,
              logoUrl: imgUrl ?? "",
              description: _desc.text,
              location: dropdownValue,
              category: categoryItem,
              websiteUrl: _websiteUrl.text,
              email: _email.text,
              phoneNumber: _phone.text,
              available: value,
              published: value2,
              userId: user.user.id,
              socialmedia: [_ig.text, _fb.text, _yt.text, _tw.text]);
      response.then((response) => {
            if (response['result'])
              {
                setState(() {
                  uploading = false;
                  uploaded = true;
                }),
                Navigator.pop(context),
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: primary,
                    content: Text('successfull'),
                    duration: Duration(seconds: 6),
                  ),
                )
              }
            else
              {
                setState(() {
                  uploading = false;
                  uploaded = false;
                }),
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: primary,
                    content: Text('failed'),
                    duration: Duration(seconds: 6),
                  ),
                )
              }
          });
    }

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
        titleTextStyle: robotoBtnstyle,
        title: Text('New Service'),
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
                      label: 'Service Name',
                      hint: "name your service",
                      maxLines: 0,
                      textController: _serviceName,
                    ),
                    TextfieldPackage(
                      label: 'About',
                      hint: "describe your service",
                      maxLines: 3,
                      textController: _desc,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 60,
                        top: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      child: Text(
                        'Choose image',
                        textAlign: TextAlign.left,
                        style: robotoSmLabel,
                      ),
                    ),
                    Row(children: [
                      InkWell(
                        onTap: () {
                          getImage();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * 10,
                              left: SizeConfig.blockSizeHorizontal * 5,
                              top: SizeConfig.blockSizeHorizontal * 2,
                              bottom: SizeConfig.blockSizeVertical * 1),
                          child: Container(
                            alignment: Alignment.center,
                            width: SizeConfig.blockSizeHorizontal * 25,
                            height: SizeConfig.blockSizeVertical * 6,
                            decoration: BoxDecoration(
                                color: Color(0xffD4D0D0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            child: Text(
                              'Choose File',
                              style: robotoSmBlack,
                            ),
                          ),
                        ),
                      ),
                      path == ''
                          ? Text(
                              "no image",
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontSize: 12),
                            )
                          : Text('Image selected'),
                      TextButton(
                          onPressed: () {
                            postCloudinary();
                          },
                          child: Text('upload'))
                    ]),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 80,
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        menuMaxHeight: SizeConfig.blockSizeHorizontal * 80,
                        hint: Text(
                          "Choose your location",
                          style: roboto18Black,
                        ),
                        dropdownColor: Color(0xffE1E1E1),
                        focusColor: Colors.black54,
                        elevation: 6,
                        icon: ImageIcon(
                          AssetImage('images/locationicon.png'),
                          color: primary,
                        ),
                        underline: SizedBox(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>[
                          'Harare',
                          'Mutare',
                          'Norton',
                          'Bulawayo'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: roboto18Black,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 3,
                    ),
                    // category
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 80,
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: DropdownButton<String>(
                        value: categoryItem,
                        menuMaxHeight: SizeConfig.blockSizeHorizontal * 80,
                        hint: Text(
                          "Choose the Category",
                          style: roboto18Black,
                        ),
                        dropdownColor: Color(0xffE1E1E1),
                        focusColor: Colors.black54,
                        elevation: 6,
                        icon: Icon(
                          Icons.category,
                          color: primary,
                        ),
                        underline: SizedBox(),
                        onChanged: (String newValue) {
                          setState(() {
                            categoryItem = newValue;
                          });
                        },
                        items: <String>[
                          'Fashion',
                          'Beauty',
                          'Travel',
                          'Lifestyle',
                          'Health',
                          'Design',
                          'Entertainment',
                          'Money',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: roboto18Black,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    TextfieldPackage(
                      label: 'Website',
                      hint: "eg www.freshideas.co.zw",
                      maxLines: 0,
                      textController: _websiteUrl,
                    ),
                    TextfieldPackage(
                      label: 'Email',
                      hint: "eg hell@freshideas.co.zw",
                      maxLines: 0,
                      textController: _email,
                    ),
                    TextfieldPackage(
                      label: 'Phone',
                      hint: "+2637*******",
                      maxLines: 0,
                      textController: _phone,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 50,
                            top: SizeConfig.blockSizeHorizontal * 4,
                            bottom: SizeConfig.blockSizeVertical * 1),
                        child: Text(
                          'Social Media',
                          textAlign: TextAlign.left,
                          style: robotoSmLabel,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.blockSizeHorizontal * 20,
                          left: SizeConfig.blockSizeHorizontal * 8,
                          top: SizeConfig.blockSizeHorizontal * 1,
                          bottom: SizeConfig.blockSizeVertical * 1),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Platform',
                              textAlign: TextAlign.left,
                              style: robotoSmBlack,
                            ),
                            Text(
                              'Username',
                              textAlign: TextAlign.left,
                              style: robotoSmBlack,
                            ),
                          ]),
                    ),
                    SocialField(
                      name: 'instagram',
                      textController: _ig,
                    ),
                    SocialField(
                      name: 'facebook',
                      textController: _fb,
                    ),
                    SocialField(
                      name: 'twitter',
                      textController: _tw,
                    ),
                    SocialField(
                      name: 'Youtube',
                      textController: _yt,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.blockSizeHorizontal * 55,
                          left: SizeConfig.blockSizeHorizontal * 3,
                          top: SizeConfig.blockSizeHorizontal * 1,
                          bottom: SizeConfig.blockSizeVertical * 1),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              value: this.value,
                              onChanged: (bool value) {
                                setState(() {
                                  this.value = value;
                                });
                              },
                            ),
                            Text(
                              'Available',
                              textAlign: TextAlign.left,
                              style: robotoSmBlack,
                            ),
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.blockSizeHorizontal * 55,
                          left: SizeConfig.blockSizeHorizontal * 3,
                          top: SizeConfig.blockSizeHorizontal * 1,
                          bottom: SizeConfig.blockSizeVertical * 1),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              value: this.value2,
                              onChanged: (bool value) {
                                setState(() {
                                  this.value2 = value;
                                });
                              },
                            ),
                            Text(
                              'Published',
                              textAlign: TextAlign.left,
                              style: robotoSmBlack,
                            ),
                          ]),
                    ),
                    uploading
                        ? loading
                        : InkWell(
                            child: BtnSmPrimary(
                              name: 'Create Service',
                            ),
                            onTap: () {
                              postService();
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
