import 'package:flutter/material.dart';

import 'map_screen.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List locations = [
    // ayat train station
    {
      "location name": "Ayat train Station",
      "latitude": 9.021328,
      "longitude": 38.87198,
    },
    // cmc
    {
      "location name": "CMC",
      "latitude": 9.021121,
      "longitude": 38.872594,
    },
    //civil service university
    {
      "location name": "Civil Service University",
      "latitude": 9.023256,
      "longitude": 38.833048,
    },
    //megenagna
    {
      "location name": "Megenagna",
      "latitude": 9.020906,
      "longitude": 38.802237,
    },
    //estifanos
    {
      "location name": "St. Estifanos",
      "latitude": 9.011081,
      "longitude": 38.748706,
    },
    //kality
    {
      "location name": "Kality",
      "latitude": 9.937995,
      "longitude": 38.763034,
    },
    //gofa
    {
      "location name": "Gofa mebrat hayil",
      "latitude": 8.963972,
      "longitude": 38.743009,
    },
    // gerji roba
    {
      "location name": "Gerji Roba",
      "latitude": 8.994746,
      "longitude": 38.813554,
    },
    // bole michael
    {
      "location name": "Bole Michael",
      "latitude": 8.981614,
      "longitude": 38.777223,
    },
    //ayer tena
    {
      "location name": "Ayer tena bus station",
      "latitude": 8.983132,
      "longitude": 38.698259,
    },
    // merkato
    {
      "location name": "Mercato",
      "latitude": 9.030587,
      "longitude": 38.739649,
    },
    //arat kilo
    {
      "location name": "Arat kilo",
      "latitude": 9.034403,
      "longitude": 38.763093,
    },
    // meskel square
    {
      "location name": "Meskele Square",
      "latitude": 8.981717,
      "longitude": 38.760118,
    },
  ];
  Position? currentUserPosition;
  var myLocation= '';
  var distanceInMeter;
   List distanceList = [];
   List sortedLocation = [];

     getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location Service are disabled');
    }
     permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
        permission = await Geolocator.requestPermission();
        if(permission == LocationPermission.denied){
          return Future.error('Location Permissioin denied');
        }
      }
      if(permission == LocationPermission.deniedForever){
        return Future.error("Location permission are denied permanently, we can not request permission");
      }

       var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      for(var location in locations){
       var distance = await Geolocator.distanceBetween(position.latitude, position.longitude,
           location['latitude'], location['longitude']);
       var locationName = location['location name'];
       var roundedDistance = (distance/1000).toStringAsFixed(2);
       distanceList.add(roundedDistance);

      }

      setState(() {

      });
   }

  @override
  void initState() {
    // // TODO: implement initState

   getLocation();
   distanceList.sort();
    super.initState();
  }

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
                              onPressed: (){
                                //print(getLocation());
                              },
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
                      " ${distanceList[0]}km away"
                    ),
                    Divider(
                      indent:70,
                    ),
                    ParkingSpot(
                        'images/parking.jpg',
                        'Merkato',
                        'DanParking',
                        "${distanceList[1]}km away"
                    ),
                    Divider(
                      indent:70,
                    ),
                    ParkingSpot(
                        'images/parking2.jpg',
                        'Saris',
                        'DanParking',
                        "${distanceList[2]}km away"
                    ),
                    Divider(
                      indent:70,
                    ),
                    ParkingSpot(
                        'images/splash.png',
                        'Estifanos',
                        'DanParking',
                        "${distanceList[3]}km away"
                    ),
                    Divider(
                      indent:70,
                    ),
                    ParkingSpot(
                        'images/parking4.jpg',
                        'Megenagna',
                        'DanParking',
                        "${distanceList[4]}km away"
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

