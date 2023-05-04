import 'package:shared_preferences/shared_preferences.dart';

class User {
  String? name;
  static Future saveAuth(id, name, email, phoneNumber, address_id, role, createdAt, updatedAt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
    prefs.setString('name', name);
    prefs.setString('email', email);
    prefs.setString('phone_number', phoneNumber);
    prefs.setString('address_id', address_id);
    prefs.setString('role', role);
    prefs.setString('created_at', createdAt);
    prefs.setString('updated_at', updatedAt);
  }

  /// ---------------------------
  ///  Key Parameter to get user data
  /// ---------------------------
  ///  'id' to get id
  ///
  ///  'name' to get name
  ///
  ///  'email' to get email
  ///
  ///  'phone_number' to get phone_number
  ///
  ///  'adress_id' to get adress_id
  ///
  ///  'role' to get role
  static Future getUser(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.get(key);
    return result;
  }

  static getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('name');
  }
}
