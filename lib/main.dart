import 'package:danpark/models/app_provider.dart';
import 'package:danpark/screens/on_boarding_screen.dart';
import 'package:danpark/screens/phone_number_registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/phone_number_registration.dart';
void main() async {
  //final sharedPrefs = await SharedPreferences.getInstance();
  // bool goToHome = await sharedPrefs.getBool('goToHome') ?? false;
  //  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //  FlutterNativeSplash.remove();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DanPark());
}

class DanPark extends StatelessWidget {
  //get goToHome => null;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)=>AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:OnBoardingScreen(),
      ),
    );
  }
}


//goToHome? PhoneNumberRegistration() :

