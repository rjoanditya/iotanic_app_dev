import 'package:shared_preferences/shared_preferences.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? role;
  static Future saveAuth(id, name, email, role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', id);
    prefs.setString('name', name);
    prefs.setString('email', email);
    prefs.setString('role', role);
    // prefs.setString('phone_number', phoneNumber);
    // prefs.setString('address_id', address_id);
    // prefs.setString('created_at', createdAt);
    // prefs.setString('updated_at', updatedAt);
  }

  /// Retrieves a user data from the shared preferences based on the provided `key`.
  /// Returns a `Future` that resolves to the user data value.
  ///
  /// Parameters:
  /// - `key` (String): The key to retrieve the user data.
  ///
  /// Return Type:
  /// - `Future`: A `Future` that resolves to the user data value.
  ///
  /// Example
  ///
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
  ///
  Future getUser(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.get(key);
    return result;
  }

  static getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('name');
  }
}
