import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static late String userId;
  static late final SharedPreferences prefs;
  static const uuid = Uuid();

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    userId = await getOrCreateUserId();
  }

  static Future<String> getOrCreateUserId() async {
    return 'Venti';
    // String? userId = prefs.getString('userId');

    // if (userId == null) {
    //   userId = uuid.v4();
    //   prefs.setString('userId', userId);
    // }

    // return userId;
  }
}
