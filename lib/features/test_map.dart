import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationMapScreen extends StatefulWidget {
  @override
  _CurrentLocationMapScreenState createState() => _CurrentLocationMapScreenState();
}

class _CurrentLocationMapScreenState extends State<CurrentLocationMapScreen> {
  GoogleMapController? _mapController;
 LatLng? _currentPosition;
   Marker? _currentLocationMarker;

  Set<Marker> _markers = {}; // <Marker>
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void test()
  {
    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(31.0, 30.5),
          zoom: 5,
        ),
      ),
      duration: Duration(seconds: 2),
    );
    print(_markers.add(
        Marker(
          markerId: MarkerId('1'),
          position: LatLng(31.0, 30.5),
          infoWindow: InfoWindow(title: 'go there'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          draggable: true,
          onDrag: (pos)
          {
            print("object");
            _markers.add(
              Marker(
                  markerId: MarkerId('2'),
                  position: LatLng(31.0, 30.5),
                  infoWindow: InfoWindow(title: 'You are here'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),

              ),
            );
            setState(() {

            });
          }


        ),
    ));

    setState(() {

    });
  }
  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _currentLocationMarker = Marker(
        markerId: MarkerId('currentLocation'),
        position: _currentPosition!,
        infoWindow: InfoWindow(title: 'You are here'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
      _markers.add(_currentLocationMarker!);


    if (_mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
    }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Current Location')),
      body: 
      _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          :
      Column(
        children: [
          Expanded(
            child: GoogleMap(
              polylines: {
                Polyline(
                  polylineId: PolylineId('1'),
                  points: [
                    LatLng(31.0, 30.5),
                    LatLng(37, 30.5),
                  ]
                )
              },
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 5,
              ),
               myLocationEnabled: true,
              // myLocationButtonEnabled: false,
              onMapCreated: (controller) => _mapController = controller,
             markers: _markers,
             // markers: _currentLocationMarker != null ? {_currentLocationMarker!} : {},
            ),
          ),
          TextButton(onPressed: test, child: Text('goto'))
        ],
      ),
    );
  }
}
