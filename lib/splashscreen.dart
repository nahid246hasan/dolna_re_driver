
import 'dart:async';


import 'package:dolna_re_driver/function.dart';
import 'package:dolna_re_driver/home.dart';
import 'package:dolna_re_driver/login_page.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get_storage/get_storage.dart';
class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }

}
class SplashScreenState extends State<SplashScreen>{

  final sharedpreff = GetStorage();
  @override
  void initState() {



   // Timer(Duration(seconds: 5), () {
      reqPermission().then((value) {
        print(value);
        //gpsCheck().then((value1) {

          if(value==1){

            Timer(Duration(seconds: 1), () {

             if(sharedpreff.read("driver_id")==null){
               Navigator.pop(context);
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => LoginPage()),

               );
             }
             else{
               Navigator.pop(context);
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => HomePage(sharedpreff.read("driver_id"))),

               );
             }

            });

          }
        //});
      });

   // });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: width,
        height: height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width/2.5,
                height: height/4,

                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                    image:  DecorationImage(
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                      matchTextDirection: true,
                      repeat: ImageRepeat.noRepeat,
                      image:  AssetImage('assets/images/dolna_logo.jpg')
                    )
                ),

              ),
              LoadingAnimationWidget.threeArchedCircle(
      color: Theme.of(context).hintColor, size: 50
   )
            ],
          ),
        ),
      ),
    );
  }


}