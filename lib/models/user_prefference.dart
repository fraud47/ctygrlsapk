import '/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fullname', user.fullname);

    prefs.setString('id', user.id);
    prefs.setString('surname', user.surname);
    prefs.setString('email', user.email);
    prefs.setString('fullname', user.fullname);
    prefs.setBool('service', user.service);
    prefs.setString('accessToken', user.accessToken);
    prefs.setString('role', user.role);

    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var fullname = prefs.getString('fullname');
    var service = prefs.getBool('service');
    var surname = prefs.getString('surname');
    var email = prefs.getString('email');
    var accessToken = prefs.getString('accessToken');
    var role = prefs.getString('role');

    return User(
        id: id,
        fullname: fullname,
        surname: surname,
        service: service,
        email: email,
        accessToken: accessToken,
        role: role);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('fullname');
    prefs.remove('surname');
    prefs.remove('service');
    prefs.remove('email');
    prefs.remove('id');
    prefs.remove('accessToken');
    prefs.remove('role');
  }
}
