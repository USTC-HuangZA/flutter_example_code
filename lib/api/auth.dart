import 'package:flutter_example_code/api/request.dart';
import 'package:flutter_example_code/utils/cookie_manager.dart';
import 'package:flutter_example_code/store/user_info.dart';

class AuthApi{
  static Future login(username, password, remember) async {
    final request = {
      "username": username,
      "password": password,
      "remember": remember
    };
    final response = await globalRequest.dio.post('/login', data: request);
    //get cooking from response
    print(response.data);
    final cookies = response.headers.map['set-cookie'];
    if (cookies != null) {
      print('cookiesGet:$cookies');
      for(var cookie in cookies){
        final token = cookie.split(';')[0]; //it depends on how your server sending cookie
        final key = token.split('=')[0];
        final value = token.split('=')[1];
        CookieManager.setString(key, value);
      }
    }
    if(response.data['status'] == 0){
      var data = response.data['data'];
      UserInfo.setInfo(data['userId'],data['username'],data['userType']);
      return true;
    }
    return false;
  }
  static Future<bool> checkSession() async{
    final response = await globalRequest.dio.post('/checkSession', data: {});
    print(response.data);
    if(response.data['status'] == 0){
      var data = response.data['data'];
      UserInfo.setInfo(data['userId'],data['username'],data['userType']);
      return true;
    }else return false;
  }
}

