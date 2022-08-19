import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);

  BaseMapController _mapController = MapController(
    initMapWithUserPosition: true,
    initPosition: GeoPoint(latitude: 8.9806, longitude: 38.7578),
    areaLimit: BoundingBox( east: 10.4922941, north: 47.8084648, south: 45.817995, west: 5.9559113,),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         OSMFlutter(
          controller: _mapController,
          trackMyPosition: false,
          initZoom: 12,
          minZoomLevel: 8,
          maxZoomLevel: 14,
          stepZoom: 1.0,
          userLocationMarker: UserLocationMaker(
            personMarker: MarkerIcon(
              icon: Icon(
                Icons.location_history_rounded,
                color: Colors.red,
                size: 48,
              ),
            ),
            directionArrowMarker: MarkerIcon(
              icon: Icon(
                Icons.double_arrow,
                size: 48,
              ),
            ),
          ),
          roadConfiguration: RoadConfiguration(
            startIcon: MarkerIcon(
              icon: Icon(
                Icons.person,
                size: 64,
                color: Colors.brown,
              ),
            ),
            roadColor: Colors.yellowAccent,
          ),
          markerOption: MarkerOption(
              defaultMarker: MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                  size: 56,
                ),
              )
          ),
        ),

        ],
      ),
      bottomSheet: Container(
          padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30)
            )
        ),
        height: 200,
        width: double.infinity,
         child: Column(
           children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [

                   Container(
                     width: 200,
                     height: 60,

                     decoration: BoxDecoration(
                       color: Colors.greenAccent,
                       borderRadius: BorderRadius.circular(15)
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         Text(
                             "Dan Parking",
                           style: TextStyle(
                             color: Colors.white38
                           ),
                         ),

                         Text('2:30 AM - 6:30 AM',
                         style: TextStyle(
                           color: Colors.white,
                           letterSpacing:2
                         ),
                         )
                       ],
                     ),
                   ),
                   Container(
                     width: 100,
                     height: 60,

                     decoration: BoxDecoration(
                         color: Colors.greenAccent,
                         borderRadius: BorderRadius.circular(15)
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         Text(
                           "Total Cost",
                           style: TextStyle(
                               color: Colors.white38
                           ),
                         ),

                         Text('100 ETB',
                           style: TextStyle(
                               color: Colors.white,
                               letterSpacing:2
                           ),
                         )
                       ],
                     ),
                   )

                ],
              ),
             SizedBox(
               height:50,
             ),
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent
              ),
                 onPressed: (){},
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.verified_user_rounded),
                     SizedBox(
                       width: 10,
                     ),
                     Text('Book your Space now',
                     style: TextStyle(
                       fontWeight: FontWeight.w900
                     ),)
                   ],
                 )
             )
           ],
         ),
      ),
    );
  }
}

