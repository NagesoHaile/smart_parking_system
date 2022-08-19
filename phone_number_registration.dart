
import 'package:danpark/models/app_provider.dart';
import 'package:danpark/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
final FirebaseAuth auth = FirebaseAuth.instance;
    enum ScreenState {
      SHOW_MOBILE_FORM_STATE,
      SHOW_OTP_FORM_STATE,
    }

class PhoneNumberRegistration extends StatefulWidget {
  const PhoneNumberRegistration({Key? key}) : super(key: key);

  @override
  State<PhoneNumberRegistration> createState() => _PhoneNumberRegistrationState();
}

class _PhoneNumberRegistrationState extends State<PhoneNumberRegistration> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  ScreenState currentState = ScreenState.SHOW_MOBILE_FORM_STATE;

  late String verificationId;
  late String smsCode;
  String completePhoneNumber = "";
  bool showloading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void signInWithAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
            setState(() {
              showloading = true;
            });
            try {
              final authCredential = await _auth.signInWithCredential(phoneAuthCredential);
              setState(() {
                showloading = false;
              });
              if(authCredential.user != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              }

            } on FirebaseAuthException catch(error) {
              setState(() {
                showloading = false;
              });
              showSnackBarText(error.toString());
            }
  }

    getMobilePhoneForm(context){
       return  SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(10.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SizedBox(
                 height: MediaQuery.of(context).size.height*0.06,
               ),
               Image(
                 image: AssetImage('images/phone_number_authentication.png'),
                 height: 200,

               ),
               SizedBox(
                 height: MediaQuery.of(context).size.height*0.02,
               ),
               Text(
                   'Welcome to Dan Parking',
                   style: TextStyle(
                       fontSize: 35,
                       fontWeight: FontWeight.bold
                   )
               ),
               SizedBox(
                 height: MediaQuery.of(context).size.height*0.01,
               ),
               Text(
                   'Enter your phone number and we will send you OTP to verify'
               ),
               SizedBox(
                 height: MediaQuery.of(context).size.height*0.02,
               ),
               IntlPhoneField(

                 controller: phoneNumberController,
                 decoration: InputDecoration(
                     labelText: "Phone Number",
                     border: OutlineInputBorder(
                         borderSide: BorderSide()
                     )
                 ),
                 initialCountryCode: 'ET',
                 onChanged: (phone){
                   print(phone.completeNumber);
                   setState(() {
                     completePhoneNumber = phone.completeNumber;
                   });
                 },
               ),

               SizedBox(
                 height: MediaQuery.of(context).size.height*0.04,
               ),
               ElevatedButton(
                 onPressed: () async {
                   if(phoneNumberController.text.isEmpty){
                     showSnackBarText('please insert phone number');
                   }else {
                     await _auth.verifyPhoneNumber(
                         phoneNumber: completePhoneNumber,
                         verificationCompleted: (AuthCredential credential){
                           setState(() {
                             showloading = false;
                           });
                           showSnackBarText('Congratulation Authentication completed.');

                         },
                         verificationFailed: (FirebaseAuthException exception){
                           setState(() {
                             showloading = false;
                           });
                           showSnackBarText(exception.toString());
                         },
                         codeSent: (String verificationId,  resendToken) async {
                           setState(() {
                             showloading = false;
                             currentState = ScreenState.SHOW_OTP_FORM_STATE;
                             this.verificationId= verificationId;
                           });

                         },
                         timeout: const Duration(seconds: 60),
                         codeAutoRetrievalTimeout: (String verificationId){
                           showSnackBarText('Authentication Timeout');
                         }
                     );
                   }
                 },
                 style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
                 child: Container(
                   height: 40.0,
                   child: Center(
                     child: showloading ? Center(child: CircularProgressIndicator(),):Text(
                       'Register',
                       style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                 ),
               ),
             ],
           ),
         ),
       );

    }

    getOtpFormWidget(context){
       return SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(10.0),
           child: Center(
             child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                   child: Image.asset(
                     'images/otp-security.png',
                     fit: BoxFit.cover,
                     width: double.infinity,
                     height: 200,
                   ),
                 ),
                 SizedBox(
                   height: 20,
                 ),
                 Container(
                     child: Column(
                       children: [
                         Text('Verification Code',
                           style: TextStyle(
                               fontWeight: FontWeight.bold,
                               color: Colors.green,
                               fontSize: 24
                           ),
                         ),
                         Text('Enter the code that have been sent to ${completePhoneNumber}',
                           style: TextStyle(
                             color: Colors.green,
                           ),
                         ),

                       ],
                     )
                 ),
                 SizedBox(
                   height: 30,
                 ),
                 Form(
                   child: Column(
                     children: [
                       TextFormField(
                         controller: codeController,
                         onChanged: (value){
                           if(value.length == 6){
                             FocusScope.of(context).nextFocus();
                           }
                           print(codeController.text);
                         },
                         style: Theme.of(context).textTheme.headline6,
                         keyboardType: TextInputType.number,
                         textAlign: TextAlign.center,
                         inputFormatters: [
                           // LengthLimitingTextInputFormatter(1),
                          // FilteringTextInputFormatter.digitsOnly,
                         ],
                         decoration: InputDecoration(
                             border: OutlineInputBorder()
                         ),
                       ),
                     ],
                   ),
                 ),
                 SizedBox(
                   height: 60,
                 ),

                 ElevatedButton(
                   onPressed: () {
                   PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
                       verificationId: verificationId,
                       smsCode: codeController.text
                   );
                   signInWithAuthCredential(authCredential);
                   },
                   style: ElevatedButton.styleFrom(
                       primary: Colors.greenAccent,

                   ),
                   child: Container(
                     height: 50.0,
                     child: Center(
                       child: Text(
                         'Confirm',
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                     ),
                   ),
                 )
               ],
             ),
           ),
         ),
       );
    }

  void showSnackBarText(String text){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(text,
              style: TextStyle(
                  color: Colors.red
              ),
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('Register'),
        centerTitle: true,

      ),
      body: showloading ? Center(child:  CircularProgressIndicator(),): currentState == ScreenState.SHOW_MOBILE_FORM_STATE ? getMobilePhoneForm(context) : getOtpFormWidget(context),
    );
  }
}
