import 'dart:async';
import 'dart:convert';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dolna_re_driver/Seetings_page/settingspage.dart';
import 'package:dolna_re_driver/car_page/carpage.dart';
import 'package:dolna_re_driver/function.dart';
import 'package:dolna_re_driver/main_page/mainpage.dart';
import 'package:dolna_re_driver/profile_page/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:geolocator/geolocator.dart';
class HomePage extends StatefulWidget{

  String driver_id;


  HomePage(this.driver_id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }

}

class _HomePageState extends State<HomePage>{
  int index=0;
  final sharedpreff = GetStorage();
  var status ;
  var commentsRef;
  var d;
  var c;
  var e;



  @override
  initState()  {



    getDriverDetails(widget.driver_id).then((value) {
      d=jsonDecode(value);
      print(d.toString().length);

      setState(() {
        if(d.toString().length<=2){
          sharedpreff.write('exist', 'no');
        }
        else{
          //sharedpreff.write('exist', 'yes');
          sharedpreff.write('driver_name', d["Name"]);

          sharedpreff.write('driver_photo', d["Photo"].split(',')[0]);

        }
      });



    });
    getCarDetails(widget.driver_id).then((value) {
      c=jsonDecode(value);
      print(c.toString().length);
      setState(() {
        if(c.toString().length<=2){
          sharedpreff.write('exist_car', 'no');
        }
        else{
         // sharedpreff.write('exist_car', 'yes');
          sharedpreff.write('car_pic', c["Pictures"].split(',')[0]);
          sharedpreff.write('car_type', c["Type"]);
          sharedpreff.write('car_model', c["Model"]);
          sharedpreff.write('car_color', c["Color"]);
          sharedpreff.write('car_reg', c["RegistrationNumber"]);
          sharedpreff.write('car_condition', c["Condition"]);
          sharedpreff.write('car_ac', c["isAC"].toString());

          if(c["Type"]=="sedan"){
            sharedpreff.write('car_cap', 4.toString());
          }
          else if(c["Type"]=="mini"){
            sharedpreff.write('car_cap', 8.toString());
          }
          else if(c["Type"]=="micro"){
            sharedpreff.write('car_cap', 12.toString());
          }


        }
      });
    });
    commentsRef = FirebaseDatabase.instance.ref("DriverBalance/"+sharedpreff.read('driver_id'));
    try{

      commentsRef.onValue.listen((DatabaseEvent event) {
        status = event.snapshot.value;
        //print(status["balance"]);

        //NotificationService().showNotification(title: "Dolna",body: "sdsd");
           print(status.toString());
           print("hurrrrrrrrrrrrrrr");
          setState(() {
            e=10;
            if(status==null){
              sharedpreff.write('exist', 'no');
              print("I");
            }
            else{
              sharedpreff.write('exist', 'yes');
              print("J");
            }
          });


          // if(status==null){
          //   sharedpreff.write('exist', 'no');
          // }
          // else{
          //   sharedpreff.write('exist', 'yes');
          // }



      });
    }
    catch(error){

    }
    // try{
    //   commentsRef.onChildChanged.listen((event) {
    //     // A comment has changed; use the key to determine if we are displaying this
    //     // comment and if so displayed the changed comment.
    //     print("sddddddddddddddddddddddddd");
    //     print(event.toString());
    //
    //
    //     status=event.snapshot.value;
    //
    //     if(mounted){
    //       setState(() {
    //         e=10;
    //
    //           sharedpreff.write('exist', 'yes');
    //
    //       });
    //     }
    //     else{
    //
    //         sharedpreff.write('exist', 'yes');
    //
    //     }
    //
    //
    //
    //
    //   });
    // }
    // catch(er){
    //
    // }
    print(sharedpreff.read("exist"));
   gpsCheck();
  }

  List<Widget> listItems = [
    MainPage(),

    SettingsPage(),
    ProfilePage(),
   // CarPage(),

  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    if(d==null || c==null || e==null){
      return Scaffold(
        body:DoubleBackToCloseApp(
          snackBar: SnackBar(
              duration: const Duration(seconds: 3),

              backgroundColor: Theme.of(context).primaryColor,
              content: Container(
                //height: height/3,
                //margin: EdgeInsets.only(left: 10,right: 10),
                width: width,
                padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                decoration:  BoxDecoration(

                    color:Theme.of(context).primaryColor,

                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Column(
                  children: [
                    Text("Tap back again to leave",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                    const SizedBox(height: 10,),

                  ],
                ),
              )
          ),
          child: Container(
            width: width,
            height: height,
            child: Center(
              child:  LoadingAnimationWidget.threeArchedCircle(
                  color: Theme.of(context).hintColor, size: 50
              ),
            ),
          ),
        ) ,
      );
    }

    else{

      return Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
              duration: const Duration(seconds: 3),

              backgroundColor: Theme.of(context).primaryColor,
              content: Container(
                //height: height/3,
                //margin: EdgeInsets.only(left: 10,right: 10),
                width: width,
                padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                decoration:  BoxDecoration(

                    color:Theme.of(context).primaryColor,

                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Column(
                  children: [
                    Text("Tap back again to leave",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                    const SizedBox(height: 10,),

                  ],
                ),
              )
          ),
          child: listItems.elementAt(index),
        ),
        bottomNavigationBar: Container(
          height: 30,
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("  Home",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).hintColor)),
              Text("      Settings  ",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).hintColor),),

              //Text("Doctor",style: TextStyle(color: Color.fromRGBO(255, 214, 133,1)),),

              //Text("Message",style: TextStyle(color: Color.fromRGBO(255, 214, 133,1)),),
              Text("  Profile   ",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).hintColor),),
            //  Text("Car  ",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).hintColor),),
            ],
          ),
        ),
        bottomSheet:
        //Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        CurvedNavigationBar(

          onTap: (index1) {
            setState(() {
              index = index1;
              print(index);
            });
          },

          index: index,
          height: height/16,
          backgroundColor: Colors.transparent,
          color: Theme.of(context).primaryColor,
          items: [

            Image.asset(

              "assets/images/home.png",
              width: 40,
              height: 40,
            ),


            Image.asset(
              "assets/images/settings.png",
              width: 40,
              height: 40,
            ),


            Image.asset(
              "assets/images/user.png",
              width: 40,
              height: 40,
            ),
            // Image.asset(
            //   "assets/images/car.png",
            //   width: 40,
            //   height: 40,
            // ),






          ],

        ),

      );
    }



  }
}