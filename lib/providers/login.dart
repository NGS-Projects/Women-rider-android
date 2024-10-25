import 'package:flutter/foundation.dart';


import 'package:womentaxi/untils/export_file.dart';


class LoginProvider extends ChangeNotifier {

  String _errorMessage = '';


  String get errorMessage => _errorMessage;


  setErrorMessage(String message) {

    _errorMessage = message;


    notifyListeners();

  }

}

