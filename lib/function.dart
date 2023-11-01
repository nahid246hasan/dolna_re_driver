import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

Future<int> reqPermission()
async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.camera,
    //add more permission to request here.
  ].request();

  if(statuses[Permission.location]!.isDenied){ //check each permission status after.
    print("Location permission is denied.");
    return 0;
  }

  else if(statuses[Permission.camera]!.isDenied){ //check each permission status after.
    print("Camera permission is denied.");
    return 0;
  }
  else{
    return 1;
  }


}



Future<void> gpsCheck() async {
  bool serviceEnabled;


  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    Fluttertoast.showToast(
        msg: "Please turn on your gps",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Timer(Duration(seconds: 1), () async {
      await Geolocator.openLocationSettings();
    });

  }
  else{
    Fluttertoast.showToast(
        msg: "GPS is on",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.

    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
    else{

    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
Future<String> getLocationName(var lat,var lng) async
{

  List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
  String palcename = placemarks.last.toString();
  return "$palcename";
}

//String s="http://10.0.2.2:8000/api";
String s="https://dolnabd.com/api";


Future<String> verifyPhnToken(String serial,String device, String name) async {
  String url = s+'/otp/token';
  Map<String, String> headers = {"Content-type": "application/json"};

  String json = '{"serial": "'+serial+'","device":"'+device+'","name": "'+name+'"}';
  print(json);
  var response = await http.post(Uri.parse(url),  headers: headers,body: json);

  String body = response.body.toString();
  print(body);
  return body;

}

Future<String> sendPhnToken(String phn,String serial, String token) async {
  String url = s+'/otp';
  Map<String, String> headers = {"Content-type": "application/json"};

  String json = '{"phone": "'+phn+'","serial":"'+serial+'","token": "'+token+'"}';
  print(json);
  var response = await http.post(Uri.parse(url),  headers: headers,body: json);

  String body = response.body.toString();
  print(body);
  return body;

}

Future<String> verifyPhnOtp(String phn,String otp ) async {
  String url = s+'/otp/verify';
  Map<String, String> headers = {"Content-type": "application/json"};

  String json = '{"phone": "'+phn+'","otp":'+otp+'}';
  print(json);
  var response = await http.post(Uri.parse(url),  headers: headers,body: json);

  String body = response.body.toString();
  return body;

}

Future<String> getDriverDetails(String id) async {
  String url = s+'/Driver/Get/Details/'+id;
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json'};



  var response = await http.get(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<String> saveDriverDetails(String id,String name,String userPhn ,String usermail,String address,String nid,String pic) async {
  String url = s+'/Driver/Create';
  Map<String, String> headers = {"Content-type": "application/json"};

  String json = '{"FirebaseID": "'+id+'","Name":"'+name+'","Phone": "'+userPhn+'","Email": "'+usermail+'","Address" : "'+address+'","NID": "'+nid+'","Photo": "'+pic+'"}';
  print(json);
  var response = await http.post(Uri.parse(url),  headers: headers,body: json);

  String body = response.body.toString();
  return body;

}

Future<String> saveCarDetails(String id,String model,String color ,String car_no,String type,bool ac,String condition,String pic) async {
  String url = s+'/Car/Create';
  Map<String, String> headers = {"Content-type": "application/json"};

  String json = '{"DriverID": "'+id+'","Model":"'+model+'","Color": "'+color+'","RegistrationNumber": "'+car_no+'","Type": "'+type+'","isAC" : '+ac.toString()+',"Condition": "'+condition+'","Pictures": "'+pic+'"}';
  print(json);
  var response = await http.post(Uri.parse(url),  headers: headers,body: json);

  String body = response.body.toString();
  return body;

}
Future<String> updateCarDetails(String id,String model,String color ,String car_no,String type,bool ac,String condition,String pic) async {
  String url = s+'/Car/Update/'+id;
  Map<String, String> headers = {"Content-type": "application/json"};

  String json = '{"DriverID": "'+id+'","Model":"'+model+'","Color": "'+color+'","RegistrationNumber": "'+car_no+'","Type": "'+type+'","isAC" : '+ac.toString()+',"Condition": "'+condition+'","Pictures": "'+pic+'"}';
  print(json);
  var response = await http.put(Uri.parse(url),  headers: headers,body: json);

  String body = response.body.toString();
  return body;

}



Future<String> updateDriverDetails(String id,String name,String userPhn ,String usermail,String address,String nid,String pic) async {
  String url = s+'/Driver/Update/'+id;
  Map<String, String> headers = {"Content-type": "application/json"};

  String json = '{"FirebaseID": "'+id+'","Name":"'+name+'","Phone": "'+userPhn+'","Email": "'+usermail+'","Address" : "'+address+'","NID": "'+nid+'","Photo": "'+pic+'"}';
  print(json);
  var response = await http.put(Uri.parse(url),  headers: headers,body: json);

  String body = response.body.toString();
  return body;

}

Future<String> getCarDetails(String id) async {
  String url = s+'/Car/Get/Details/'+id;
  Map<String, String> headers = {"Content-type": "application/json", 'Accept': 'application/json'};



  var response = await http.get(Uri.parse(url), headers: headers);
  //print(response);
  String body = response.body.toString();
  //print(body);
  return body;



}
Future<List<String>> uploadFiles(List<File> _images,String id,List<String> name) async {
  int i=-1;
  var imageUrls = await Future.wait(_images.map((_image) {

   i++;

   return uploadFile(_image,id,name[i]);
  }));


  return imageUrls;
}

Future<String> uploadFile(File _image,String id,String i) async {
  Reference storageReference = FirebaseStorage.instance
      .ref()
      .child('$id/$i');
  UploadTask uploadTask = storageReference.putFile(_image);
  await uploadTask;

  return await storageReference.getDownloadURL();
}

