import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User();

  void setUser(User user) async {
    _user = await user;
    notifyListeners();
  }

  get user => this._user;
}
