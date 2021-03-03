import 'package:flutter/material.dart';
import 'package:flutter_example_code/api/auth.dart';
import 'package:flutter_example_code/utils/cookie_manager.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);
  Future<String> _authUser(LoginData data) async{
    print('Name: ${data.name}, Password: ${data.password}');
    var res = await AuthApi.login(data.name,data.password,true);
    if(res) return null;
    return '登录失败';
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      return '该功能待完成';
    });
  }
  String _emailValidator(String email){
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'BookStore',
      onLogin: _authUser,
      onSignup: _authUser,
      emailValidator: _emailValidator,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed('/');
      },
    messages: LoginMessages(
      usernameHint: 'Username',
    ),
      onRecoverPassword: _recoverPassword,
    );
  }
}