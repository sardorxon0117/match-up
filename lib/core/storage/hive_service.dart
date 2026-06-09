import 'package:hive_flutter/hive_flutter.dart';
import 'package:matchup/core/app_constants/constants.dart';

class HiveService {
  var _isLogin = Hive.box(AppConstants.isLoginBox);

  void saveLogin() async {
    await _isLogin.put(AppConstants.isLoginKey, true);
  }

  bool isLogin() {
    return _isLogin.get(AppConstants.isLoginKey);
  }


}
