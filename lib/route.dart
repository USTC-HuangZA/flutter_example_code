import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flutter_example_code/login.dart';

RouteFactory customRoute(){
  return  (RouteSettings settings){
    return MaterialPageRoute(builder: (context){
      String routeName = settings.name;
      var args = settings.arguments;
      print("Open page: $routeName");
      //add your pages here
      switch(routeName){
        case '/': return MyHomePage(title: 'Flutter BookStore');
        case '/login': return LoginScreen();
        default: return LoginScreen();
      }
    });
  };
}