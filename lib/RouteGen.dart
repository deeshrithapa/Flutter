import 'package:flutter/material.dart';

import 'View/News/NewsUI.dart';
import 'View/maps/mappage.dart';

class RouteGen{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case '/' : // map sample
        return MaterialPageRoute(builder: (_) => const MapSample());
      case '/newsui':
        return MaterialPageRoute(builder: (_) => NewsUI());
      case '/newsdetail':
        return MaterialPageRoute(builder: (_) => NewsUI());
      default:
        return _errorRoute(); // if routing error

    }
  }

  static Route <dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}