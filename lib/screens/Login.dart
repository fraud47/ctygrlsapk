import 'package:flutter/material.dart';
import '../config/index.dart';
import '../components/index.dart';
import '../screens/index.dart';
import '../controllers/index.dart';
import 'package:provider/provider.dart';
import '../models/index.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email, _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          strokeWidth: SizeConfig.blockSizeHorizontal * 2,
          color: Color(0xffE36A6A),
        )
      ],
    );
    var loginExec = () {
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        final Future<Map<String, dynamic>> response =
            auth.login(_email, _password);
        response.then((response) {
          if (response['status']) {
            User user = response['user'];
            UserPreference prefs = new UserPreference();
            prefs.saveUser(user);

            var of = Provider.of<UserProvider>(context, listen: false);
            of.setUser(user);

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Navigation(
                        user: user,
                      )),
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
            content: Text('invalid login details'),
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
                      vertical: SizeConfig.blockSizeVertical * 8),
                  child: Text(
                    'CITYGIRLS_zw',
                    style: primaryHeadingLg,
                  ),
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
                      validator: (input) => validatePassword(input)
                          ? null
                          : "Enter valid password",
                      //allocation of password to textfield
                      onSaved: (value) => _password = value,
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
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),

                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : InkWell(
                        onTap: () {
                          loginExec();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 60,
                          height: SizeConfig.blockSizeVertical * 7,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Text(
                            'Login',
                            style: robotoBtnstyleWhite,
                          ),
                        ),
                      ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Container(
                    height: SizeConfig.blockSizeHorizontal * 8,
                    width: SizeConfig.blockSizeHorizontal * 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffC1EAED),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Text(
                      'sign Up',
                      style: robotoSmBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
