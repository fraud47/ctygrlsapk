import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../config/index.dart';

import '../models/index.dart';
import 'dart:convert' as convert;
import 'package:provider/provider.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;
  get loggedInStatus => this._loggedInStatus;

  set loggedInStatus(value) => this._loggedInStatus = value;

  get registeredInStatus => this._registeredInStatus;

  set registeredInStatus(value) => this._registeredInStatus = value;

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    try {
      Response response = await post(
        AppUrl.Login,
        body: convert.jsonEncode(loginData),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> responseData =
              convert.jsonDecode(response.body);

          print(responseData);

          var userToken = responseData['accessToken'];
          User user = User.fromJson(responseData);

          _loggedInStatus = Status.LoggedIn;
          notifyListeners();

          result = {'status': true, 'message': 'Successful', 'user': user};
          break;
        case 401:
        case 404:
        case 500:
          _loggedInStatus = Status.NotLoggedIn;
          notifyListeners();
          final Map<String, dynamic> responseData =
              convert.jsonDecode(response.body);
          result = {
            'status': false,
            'message': responseData['message'],
            'token': null
          };
          break;
      }
    } on SocketException catch (e) {
      result = {'status': false, 'message': "$e", 'token': null};
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
    }

    return result;
  }

// registration

  Future<Map<String, dynamic>> register(String email, String password,
      String role, String Fullname, String surname,img) async {
    var result;

    final Map<String, dynamic> signUpdata = {
      'email': email,
      'password': password,
      'fullname': Fullname,
      'surname': surname,
      'role': role,
      'img': img
    };

    _registeredInStatus = Status.Registering;
    notifyListeners();

    try {
      Response response = await post(
        AppUrl.register,
        body: convert.jsonEncode(signUpdata),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> responseData =
              convert.jsonDecode(response.body);

          _registeredInStatus = Status.Registered;
          notifyListeners();

          return result = {'status': true, 'message': 'Successful'};

          break;
        case 401:
        case 404:
        case 500:
          _registeredInStatus = Status.NotRegistered;
          notifyListeners();
          final Map<String, dynamic> responseData =
              convert.jsonDecode(response.body);
          result = {
            'status': false,
            'message': responseData['message'],
          };
          break;
      }
    } on SocketException catch (e) {
      result = {'status': false, 'message': "$e"};
      _registeredInStatus = Status.NotRegistered;
      notifyListeners();
    }
    // if (response.statusCode == 200) {
    // } else {
    //   _loggedInStatus = Status.NotLoggedIn;
    //   notifyListeners();
    //   result = {
    //     'status': false,
    //     'message': convert.jsonDecode(response.body)['error']
    //   };
    // }

    return result;
  }
}
