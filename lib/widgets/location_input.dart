import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class Locationinput extends StatefulWidget{
  const Locationinput({super.key});
  @override
  State<StatefulWidget> createState() {
    return _locationinputState();

  }
}
class _locationinputState extends State<Locationinput>{
  Location? _ispickedlocation;

  var _isgettinglocation = false;
  void _getcurrentlocation() async{
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isgettinglocation=true;
    });

    locationData = await location.getLocation();
    // final lat= locationData.latitude;
    // final long=locationData.longitude;
    //  as it use google map api i need a card for billing so from we only see the method by which we can apply that.
    // final url = Uri.parse('https:maps.googleapis....$lat,$long..something like that = OUR_API_KEY');
    // final response = await http.get(url);
    // final data =json.decode(response.body);
    // final address= data['results'][0]['formatted Address'];
    setState(() {
      _isgettinglocation=false;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    Widget previewContent= Text('No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onBackground,
      ),
    );
    if(_isgettinglocation){
      previewContent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              )
          ),
          child:previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getcurrentlocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get your Location'),
            ),
            TextButton.icon(
              onPressed: (){},
              icon: const Icon(Icons.map),
              label: const Text('Select On Map'),
            ),
          ],
        )
      ],
    );
  }
}
