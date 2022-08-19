//import 'package:danpark/screens/phone_number_registration.dart';
import 'package:danpark/screens/phone_number_registration.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {


  final controller = PageController();
  bool isEndPage =false;
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  final onboarding = <Widget> [
    onBoardingScreenContent(
        'images/parking.jpg',
        'We make parking effortless',
        'No coins? No Problem. Instantly pay for your parking session wherever you are.',
        Colors.greenAccent
    ),
    onBoardingScreenContent(
        'images/parking3.jpg',
        'Recieve timely notifications',
        'with a live countdown timer, smart parking reminders, and the options to extend on the move, you never worried about getting ticket again.',
        Colors.greenAccent
    ),
    onBoardingScreenContent(
        'images/parking4.jpg',
        'Enable Location services   ',
        'The parking experience really comes to life with time saving features like parking with maps and nearby locations(available in selected regions).',
        Colors.greenAccent
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 60),
        child: PageView.builder(
          itemCount: 3,
          controller: controller,
          onPageChanged: (index) {
            setState((){
              isEndPage = index==2;
            });
          },
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(0),
                child: onboarding[index]
            );
          },
        ),
      ),
      bottomSheet: isEndPage? Container(
        height: 60,
        child: TextButton(
            onPressed: () async {
              final sharedPrefs=  await SharedPreferences.getInstance();
              sharedPrefs.setBool('goToHome', true);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PhoneNumberRegistration()));
            },
            style: TextButton.styleFrom(
                primary: Colors.greenAccent
            ),
            child: Center(
              child: Text(
                'Get Start',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
      )
          : Container(
        height: 60,
        color: Colors.greenAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: (){
                  controller.jumpToPage(2);
                },
                style: TextButton.styleFrom(
                    primary: Colors.white70
                ),
                child: Text('SKIP',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
            SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                spacing: 16,
                activeDotColor: Colors.black26,
                radius: 10,
                dotHeight: 12,
                dotWidth: 12,
              ),
              onDotClicked: (index) {
                controller.animateToPage(index,
                    duration: Duration(
                        milliseconds: 500
                    ),
                    curve: Curves.easeInOut
                );
              },
            ),
            TextButton(
              onPressed: (){
                controller.nextPage(duration: Duration(
                  milliseconds: 500,
                ),
                    curve: Curves.easeInOut
                );
              },
              style: TextButton.styleFrom(
                  primary: Colors.white70
              ),
              child: Text(
                'NEXT',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}

 onBoardingScreenContent(final String imageUrl,final String title,final String subTitle,final Color color){
  return Container(
    color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        const SizedBox(
          height: 70,
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.teal.shade700,
          ),
        ),
        // const SizedBox(
        //   height: 5,
        // ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 10
          ),
          child: Text(
            subTitle,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
        )
      ],
    ),
  );
}
// class onBoardingScreenContent extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String subTitle;
//   final Color color;
//   onBoardingScreenContent({required this.imageUrl,
//     required this.title,
//     required this.subTitle,
//     required this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: color,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             imageUrl,
//             fit: BoxFit.cover,
//             width: double.infinity,
//           ),
//           const SizedBox(
//             height: 70,
//           ),
//           Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 28,
//               color: Colors.teal.shade700,
//             ),
//           ),
//           // const SizedBox(
//           //   height: 5,
//           // ),
//           Container(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 40,
//                 vertical: 10
//             ),
//             child: Text(
//               subTitle,
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 18,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
