import 'package:flutter/material.dart';

import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> container = [
    // ParkingSpot(),
    // ParkingSpot(),
    // ParkingSpot(),
    // ParkingSpot(),

  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.car_rental),
            Text(
              'DanParking',
             style: TextStyle(
               fontSize: 24,
               fontWeight: FontWeight.bold,

             )
,            )
          ],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.greenAccent
              ),
              child: Center(child: Text('DanParking'),),),
            ListTile(
              title: Text('Vehicles'),
              leading: Icon(Icons.car_rental),
            ),
            ListTile(
              title: Text('Payment Options'),
              leading: Icon(Icons.payment),
            ),
            ListTile(
              title: Text('Parking History'),
              leading: Icon(Icons.history_rounded),
            ),
            Divider(),
            ListTile(
              title: Text('Account Settings'),
              leading: Icon(Icons.settings),
            ),
            ListTile(
              title: Text('Help Center'),
              leading: Icon(Icons.help),
            ),
            ListTile(
              title: Text('Submit Feedback'),
              leading: Icon(Icons.feedback),
            ),
            ListTile(
              title: Text('About DanParking'),
              leading: Icon(Icons.info_outline),
            ),
            Divider(),
            ListTile(
              title: Text('SIGN OUT'),
              leading: Icon(Icons.logout),
            )
          ],
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              
              width: double.infinity,
              decoration:  BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20) )
              ),
              child: Text(
                'Find and reserve \nthe right space',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color:Colors.white

                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                child: Column(
                  children: [

                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                               // SizedBox(
                               //   height: 10,
                               // ) ,

                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)
                              ),
                              suffixIcon: Icon(Icons.search),
                              hintText: 'Search by location or address'
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.greenAccent
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_pin),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Find nearby parking')
                                ],
                              )
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Recommended',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24
                            ),
                          ),
                          const Divider(
                            indent: 10,
                          ),
                        ]
                      ),
                    ),
                    ParkingSpot(
                      'images/dan-splash.jpg',
                      'CMC, Ethiopian Civil Service University',
                      'DanParking',
                      '0km'
                    ),
                    Divider(
                      indent:70,
                    ),
                    ParkingSpot(
                        'images/parking.jpg',
                        'Merkato',
                        'DanParking',
                        '24km'
                    ),
                    Divider(
                      indent:70,
                    ),
                    ParkingSpot(
                        'images/parking2.jpg',
                        'Saris',
                        'DanParking',
                        '18km'
                    ),
                    Divider(
                      indent:70,
                    ),
                    ParkingSpot(
                        'images/splash.png',
                        'Estifanos',
                        'DanParking',
                        '9km'
                    ),
                    Divider(
                      indent:70,
                    ),
                    ParkingSpot(
                        'images/parking4.jpg',
                        'Megenagna',
                        'DanParking',
                        '4km'
                    ),
                    Divider(
                      indent:70,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.greenAccent,
        selectedItemColor: Colors.white,
        items:  [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: 'Home',

          ),

          BottomNavigationBarItem(icon: Icon(Icons.wallet),label: 'Wallet'),

          BottomNavigationBarItem(icon: Icon(Icons.account_box_outlined),label: 'Account'),
        ],
      ),
    );
  }
}

class ParkingSpot extends StatelessWidget {
   final String leadingImageUrl;
   final String title;
   final String subTitle;
   final String distanceFromMyCurrentPosition;
  // ParkingSpot({Key? key}) : super(key: key);
   ParkingSpot(this.leadingImageUrl, this.title, this.subTitle, this.distanceFromMyCurrentPosition);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MapScreen()));
      },
      leading: Image.asset(leadingImageUrl),
       title: Text(title),
      subtitle: Text(subTitle),
      trailing: Text(distanceFromMyCurrentPosition),
    );
  }
}

