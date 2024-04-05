import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_project/ui/screens/home/home_screen.dart';
import 'package:to_do_project/ui/screens/splash/splash_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case'/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}

