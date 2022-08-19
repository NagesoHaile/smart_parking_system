import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController codeController = TextEditingController();




  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}