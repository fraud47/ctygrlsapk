import 'package:city_girls/controllers/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/index.dart';
import '../components/index.dart';

class ReadService extends StatefulWidget {
  @override
  State<ReadService> createState() => _ReadServiceState();
}

class _ReadServiceState extends State<ReadService> {
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

  bool value = false;
  bool value2 = false;

  String dropdownValue;
  String categoryItem;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    UserProvider user = Provider.of<UserProvider>(context);
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
        title: Text('Edit Service'),
      ),
      body: FutureBuilder(
          future: ServiceController.userService(user.user.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else if (snapshot.data == null)
                  return Text("no services",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ));
                else {
                  return Center(
                    child: Form(
                      key: _formKey,
                      child: Container(
                          width: SizeConfig.blockSizeHorizontal * 90,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.3),
                                  width: 1)),
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

                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1,
                                ),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 80,
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.blockSizeHorizontal * 3),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.3)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    menuMaxHeight:
                                        SizeConfig.blockSizeHorizontal * 80,
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
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
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
                                      horizontal:
                                          SizeConfig.blockSizeHorizontal * 3),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.3)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: DropdownButton<String>(
                                    value: categoryItem,
                                    menuMaxHeight:
                                        SizeConfig.blockSizeHorizontal * 80,
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
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
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
                                        right:
                                            SizeConfig.blockSizeHorizontal * 50,
                                        top: SizeConfig.blockSizeHorizontal * 4,
                                        bottom:
                                            SizeConfig.blockSizeVertical * 1),
                                    child: Text(
                                      'Social Media',
                                      textAlign: TextAlign.left,
                                      style: robotoSmLabel,
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right:
                                          SizeConfig.blockSizeHorizontal * 20,
                                      left: SizeConfig.blockSizeHorizontal * 8,
                                      top: SizeConfig.blockSizeHorizontal * 1,
                                      bottom: SizeConfig.blockSizeVertical * 1),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                      right:
                                          SizeConfig.blockSizeHorizontal * 55,
                                      left: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeHorizontal * 1,
                                      bottom: SizeConfig.blockSizeVertical * 1),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                      right:
                                          SizeConfig.blockSizeHorizontal * 55,
                                      left: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeHorizontal * 1,
                                      bottom: SizeConfig.blockSizeVertical * 1),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                InkWell(
                                  child: BtnSmPrimary(
                                    name: 'Create Service',
                                  ),
                                  onTap: () {},
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 12,
                                )
                              ],
                            ),
                          )),
                    ),
                  );
                }
            }
          }),
    );
  }
}
