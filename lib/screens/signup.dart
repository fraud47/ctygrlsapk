import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../config/index.dart';
import '../components/index.dart';
import '../screens/index.dart';
import '../controllers/index.dart';
import 'package:provider/provider.dart';

import 'package:path/path.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password;
  String imgUrl;
  final _formKey = GlobalKey<FormState>();
  String dropdownValue;




  TextEditingController fullname = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


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

  Future<bool> postCloudinary() async {
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
        return true;
      } on CloudinaryException catch (e) {
        print(e.message);
        return false;
        print(e.request);
      }
    }
  }



  @override
  void dispose() {
    fullname.dispose();
    surname.dispose();
    email.dispose();
    role.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          strokeWidth: SizeConfig.blockSizeHorizontal * 1,
          color: Color(0xffE36A6A),
        )
      ],
    );
    var signUpExec = () async {
      final form = _formKey.currentState;

      if (form.validate()) {
        form.save();
       if (await postCloudinary()){


         final Future<Map<String, dynamic>> response = auth.register(
           email.text,
           password.text,
           dropdownValue,
           fullname.text,
           surname.text,
           imgUrl
         );
         response.then((response) {
           if (response['status']) {
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                 backgroundColor: primary,
                 content: Text(response['message']),
                 duration: Duration(seconds: 6),
               ),
             );
             Navigator.pop(context);
           } else {
             ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                 backgroundColor: primary,
                 content: Text(response['message']),
                 duration: Duration(seconds: 5),
               ),
             );
           }
         });
       }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Failed'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 4),
                  child: Text(
                    'CITYGIRLS_zw',
                    style: primaryHeadingLg,
                  ),
                ),
                Text('By registering you can get extra features',
                    style: robotoSmBlackBold),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 10,
                        top: SizeConfig.blockSizeVertical * 2,
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
                    controller: email,
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

                // password field
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 10,
                        top: SizeConfig.blockSizeVertical * 4,
                        bottom: SizeConfig.blockSizeVertical * 1),
                    child: Text(
                      'password',
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
                    controller:password ,
                      validator: (input) => validatePassword(input)
                          ? null
                          : "Enter valid password",

                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '123hghSF.?',
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
                  label: 'Name',
                  hint: "eg Tawanda",
                  maxLines: 0,
                  textController: fullname,
                ),
                TextfieldPackage(
                  label: 'Surname',
                  hint: "eg Ndemera",
                  maxLines: 0,
                  textController: surname,
                ),

                Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                  width: SizeConfig.blockSizeHorizontal * 80,
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black.withOpacity(0.3)),
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
                      "Account Type ",
                      style: roboto18Black,
                    ),
                    dropdownColor: Color(0xffE1E1E1),
                    focusColor: Colors.black54,
                    elevation: 6,
                    icon: Icon(Icons.person),
                    underline: SizedBox(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['Business', 'Customer']
                        .map<DropdownMenuItem<String>>((String value) {
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
                InkWell(
                  onTap: (){getImage();

                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(SizeConfig.blockSizeVertical*1),
                    height: SizeConfig.blockSizeVertical*8,
                    width: SizeConfig.blockSizeVertical*8,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7.0)),border: Border.all(color:  Colors.black.withOpacity(0.3))),
                    child: path==''?Text('Add Profile Image',textAlign: TextAlign.center,):Image.file(File(path)),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                auth.registeredInStatus == Status.Registering
                    ? loading
                    : InkWell(
                        onTap: () {
                          signUpExec();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 60,
                          height: SizeConfig.blockSizeVertical * 6,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Text(
                            'Sign Up',
                            style: robotoBtnstyleWhite,
                          ),
                        ),
                      ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Navigation()),
                    );
                  },
                  child: Container(
                    height: SizeConfig.blockSizeHorizontal * 8,
                    width: SizeConfig.blockSizeHorizontal * 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffC1EAED),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Text(
                      'Skip',
                      style: robotoSmBlack,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: SizeConfig.blockSizeHorizontal * 8,
                    width: SizeConfig.blockSizeHorizontal * 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffC1EAED),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Row(children: [
                      Icon(Icons.chevron_left),
                      Text(
                        'Back to login',
                        style: robotoSmBlack,
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Text(
                  'By continuing you agree to our',
                  style: robotoSmBlack,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Text(
                  'Terms and conditions',
                  style: robotoSmBlueUnderline,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
