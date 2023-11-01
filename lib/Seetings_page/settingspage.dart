
import 'dart:io';



import 'package:dolna_re_driver/login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';
class SettingsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingsPageState();
  }
}
class SettingsPageState extends State<SettingsPage>{
  var  commentsRef;
  var status;
  final sharedpreff = GetStorage();
  int balance=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    commentsRef = FirebaseDatabase.instance.ref("DriverBalance/"+sharedpreff.read('driver_id'));
     try{

       commentsRef.onValue.listen((DatabaseEvent event) {
         status = event.snapshot.value;
         //print(status["balance"]);

         //NotificationService().showNotification(title: "Dolna",body: "sdsd");

         try{
           setState(() {
             if(status==null){

             }
             else{
               balance=status["balance"];
             }
           });
         }
         catch(er){
           balance=0;
         }

       });
     }
     catch(error){

     }
    try{
      commentsRef.onChildChanged.listen((event) {
        // A comment has changed; use the key to determine if we are displaying this
        // comment and if so displayed the changed comment.
        print("sddddddddddddddddddddddddd");
        print(event.toString());


        status=event.snapshot.value;

        setState(() {
          balance=status["balance"];
        });




      });
    }
    catch(er){

    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentsRef=null;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60,),
              // Container(
              //   margin: EdgeInsets.only(left: 10,right: 10),
              //   width: width,
              //   padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
              //   child:
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("Background notification",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
              //       LiteRollingSwitch(
              //         value: sharedpreff.read("bg_noti")!=null?sharedpreff.read("bg_noti"):false,
              //         width: width/5,
              //         textOn: 'Yes',
              //         textOff: 'No',
              //         colorOn: Theme.of(context).hintColor,
              //         colorOff: Colors.red,
              //         iconOn: Icons.lightbulb_outline,
              //         iconOff: Icons.lightbulb_outline,
              //         animationDuration: const Duration(milliseconds: 100),
              //         onChanged: (bool state) {
              //           // print('turned ${(state) ? 'BN' : 'ENG'}');
              //             if(state==true){
              //               setState(() {
              //                 sharedpreff.write("bg_noti", true);
              //
              //               });
              //
              //             }
              //             else{
              //               setState(() {
              //                 sharedpreff.write("bg_noti", false);
              //               });
              //
              //             }
              //         },
              //         onDoubleTap: () {},
              //         onSwipe: () {},
              //         onTap: () {},
              //       ),
              //     ],
              //   ),
              //   decoration:  BoxDecoration(
              //
              //       color:Theme.of(context).primaryColor,
              //
              //       borderRadius: BorderRadius.all(Radius.circular(15))
              //   ),
              // ),
              //const SizedBox(height: 60,),
              // Container(
              //   margin: EdgeInsets.only(left: 10,right: 10),
              //   width: width,
              //   padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
              //   child:
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text("GPS",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
              //       LiteRollingSwitch(
              //         value: false,
              //         width: width/5,
              //         textOn: 'Yes',
              //         textOff: 'No',
              //         colorOn: Theme.of(context).hintColor,
              //         colorOff: Colors.red,
              //         iconOn: Icons.lightbulb_outline,
              //         iconOff: Icons.lightbulb_outline,
              //         animationDuration: const Duration(milliseconds: 100),
              //         onChanged: (bool state) {
              //           // print('turned ${(state) ? 'BN' : 'ENG'}');
              //
              //         },
              //         onDoubleTap: () {},
              //         onSwipe: () {},
              //         onTap: () {},
              //       ),
              //     ],
              //   ),
              //   decoration:  BoxDecoration(
              //
              //       color:Theme.of(context).primaryColor,
              //
              //       borderRadius: BorderRadius.all(Radius.circular(15))
              //   ),
              // ),
              const SizedBox(height: 60,),
              Text("Your Balance :"+balance.toString() ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:balance>=0 ? Colors.green : Colors.red,),),
              GestureDetector(
                onTap: (){
                  sharedpreff.write('driver_id',null);
                  sharedpreff.write('driver_phn', null);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.logout,color: Theme.of(context).primaryColor,
                      size: width/5,
                    ),
                    Text("Logout",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }


}