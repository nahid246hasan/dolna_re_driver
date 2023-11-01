

import 'dart:convert';

import 'package:dolna_re_driver/function.dart';

import 'package:dolna_re_driver/main_page/auctionpage.dart';
import 'package:dolna_re_driver/main_page/bidpage.dart';
import 'package:dolna_re_driver/main_page/bidresmap.dart';
import 'package:dolna_re_driver/models.dart';
import 'package:dolna_re_driver/notification/noti.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity/connectivity.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainPageState();
  }
}
class MainPageState extends State<MainPage>{


  var status;
  bool ongoing=false;
  String ongoingRiderPhn="";
  String ongoingStatus="";
  String ongoingDest="";
  String bidres_id="";
  var  commentsRef;
  String id="12345";
  final sharedpreff = GetStorage();
  List driverBidresItem=[];
  bool carDonePress=false;

  late final NotificationService notificationService;


  @override
  void initState() {
   // notificationService = NotificationService();

   // notificationService.initializePlatformNotifications();


    id=sharedpreff.read('driver_id');
    try{
      commentsRef = FirebaseDatabase.instance.ref("DriverInWork/$id");
      // commentsRef.onValue.listen((DatabaseEvent event) {
      //   status = event.snapshot.value;
      //   print(status);
      //   if(status["running"]=="yes"){
      //     setState(() {
      //       ongoing=true;
      //       ongoingRiderPhn=status["user_phn"].toString();
      //       ongoingStatus="You are in Trip";
      //       ongoingDest=status["to"].toString();
      //       bidres_id=status["bidres_id"].toString();
      //     });
      //
      //   }
      //   else{
      //     setState(() {
      //       ongoing=false;
      //     });
      //   }
      // });
      //
      // commentsRef = FirebaseDatabase.instance.ref("DriverInWork/$id");
      //
      //  commentsRef.onChildChanged.listen((event) {
      //   // A comment has changed; use the key to determine if we are displaying this
      //   // comment and if so displayed the changed comment.
      //   print("sddddddddddddddddddddddddd");
      //   print(event.toString());
      //
      //
      //     status=event.snapshot.value;
      //     if(status["running"]=="yes"){
      //       setState(() {
      //         ongoing=true;
      //         ongoingRiderPhn=status["user_phn"].toString();
      //         ongoingStatus="You are in Trip";
      //         ongoingDest=status["to"].toString();
      //         bidres_id=status["bidres_id"].toString();
      //       });
      //
      //     }
      //     else{
      //       setState(() {
      //         ongoing=false;
      //       });
      //     }
      //
      //
      //
      //
      // });

      commentsRef.onChildAdded.listen((event) {
        status=event.snapshot.value;



        DriverBidRes bidRes=DriverBidRes.fromJson(status as Map) ;
        setState(() {
          driverBidresItem.add(bidRes);
        });
      });

      commentsRef.onChildRemoved.listen((event) {
        status=event.snapshot.value;
        for(int i=0;i<driverBidresItem.length;i++){
          String a=status["bidres_id"].toString();
          String b=driverBidresItem[i].bidres_id.toString();
          if(a==b){
            setState(() {
              driverBidresItem.removeAt(i);
            });
          }
          else{

          }

        }

      });

    }catch(er){

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
      body: Container(
        width: width,
        height: height,
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  print("ddf");
                },
                child:  Container(
                  width: width/6,
                  height: height/15,

                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                    image:  DecorationImage(
                      alignment: Alignment.center,
                      matchTextDirection: true,
                      repeat: ImageRepeat.noRepeat,
                      image: AssetImage('assets/images/dolna_logo.jpg'),
                    )
                  ),

                ),
              ),
              const SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child:
                Text("Hello ",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Theme.of(context).primaryColor),),),
              const SizedBox(height: 10,),
              // Text("",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).hintColor),),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async{
                            // await notificationService.showLocalNotification(
                            // id: 0,
                            // title: "Drink Water",
                            // body: "Time to drink some water!",
                            // payload: "You just took water! Huurray!");
                     print("hurrrr");
                     print(sharedpreff.read('exist'));

                      if(sharedpreff.read('exist')=="yes"){

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AuctionPage()),

                        );
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            duration: const Duration(seconds: 4),

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
                                  Text("You are not activated. Please complete your profile",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                                  const SizedBox(height: 10,),

                                ],
                              ),
                            )
                        ));
                      }

                      //Navigator.pop(context);

                    },
                    child:   Container(

                      width: width/3.5,
                      height: height/8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image: AssetImage('assets/images/automobile.png')
                          ),
                          Text("Cars",style: TextStyle(fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),)
                        ],
                      ),
                      decoration:  BoxDecoration(

                          color:Theme.of(context).primaryColor,

                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BidPage()),

                      );

                    },
                    child:   Container(

                      width: width/3.5,
                      height: height/8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image: AssetImage('assets/images/bid.png')
                          ),
                          Text("Bids",style: TextStyle(fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),)
                        ],
                      ),
                      decoration:  BoxDecoration(

                          color:Theme.of(context).primaryColor,

                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
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
                                Text("No available offer at the moment",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                                const SizedBox(height: 10,),

                              ],
                            ),
                          )
                      ));
                    },
                    child:   Container(

                      width: width/3.5,
                      height: height/8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image: AssetImage('assets/images/offer.png')
                          ),
                          Text("Offer",style: TextStyle(fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),)
                        ],
                      ),
                      decoration:  BoxDecoration(

                          color:Theme.of(context).primaryColor,

                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),

              // Visibility(
              //   visible: ongoing,
              //     child: Container(
              //       width: width,
              //       padding: EdgeInsets.all(10),
              //       margin: EdgeInsets.all(10),
              //       child: Column(
              //         children: [
              //           LoadingAnimationWidget.threeArchedCircle(
              //               color: Theme.of(context).hintColor, size: 50
              //           ),
              //           Text("$ongoingStatus",
              //             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).hintColor),),
              //           Text("Call $ongoingRiderPhn to connect Rider",
              //             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).hintColor),),
              //           Text("(click on complete icon to complete)",
              //             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Theme.of(context).hintColor),),
              //           Text("Destination "+ongoingDest,
              //             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Theme.of(context).hintColor),),
              //           GestureDetector(
              //
              //             onTap: (){
              //               commentsRef = FirebaseDatabase.instance.ref("BIDRES/"+bidres_id);
              //               commentsRef.remove().then((val){
              //                 // setState(() {
              //                 //   cancelClicked=false;
              //                 // });
              //
              //               });
              //                 setState(() {
              //
              //                   ongoing=false;
              //                 });
              //             },
              //             child: Column(
              //               children: [
              //                 Icon(Icons.done,size: width/10,color: Colors.green,),
              //                 Text("complete",
              //                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.green),),
              //               ],
              //             ),
              //           )
              //
              //         ],
              //       ),
              //       decoration:  BoxDecoration(
              //
              //           color:Theme.of(context).primaryColor,
              //
              //           borderRadius: BorderRadius.all(Radius.circular(15))
              //       ),
              //     ),
              // ),
              const SizedBox(height: 30,),
              Column(
                children: List.generate(driverBidresItem.length, (index) {
                  return Container(
                    width: width,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        LoadingAnimationWidget.threeArchedCircle(
                            color: Theme.of(context).hintColor, size: 50
                        ),
                        Text("Fare "+driverBidresItem[index].fare+" Tk",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).hintColor),),
                        Text("Call "+driverBidresItem[index].user_phn+" to connect with the customer",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).hintColor),),
                        Text("Pick Up "+driverBidresItem[index].from,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Theme.of(context).hintColor),),
                        Text("Destination "+driverBidresItem[index].to,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Theme.of(context).hintColor),),

                        !carDonePress?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(

                              onTap: ()async{
                                    var connectivityResult = await (Connectivity().checkConnectivity());
                                    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                      setState(() {
                                        carDonePress = true;
                                      });
                                     try{
                                       var  commentsRef = FirebaseDatabase.instance.ref("BIDRES/"+driverBidresItem[index].bidres_id);
                                       commentsRef.update({
                                         "done": "by driver",


                                       });
                                     }catch(er){

                                     }
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                          duration: const Duration(seconds: 2),

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
                                                Text("No Network",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                                                const SizedBox(height: 10,),

                                              ],
                                            ),
                                          )
                                      ));
                                    }


                              },
                              child: Column(
                                children: [
                                  Icon(Icons.done_all,size: width/10,color: Colors.green,),
                                  Text("Done",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.green),),
                                ],
                              ),
                            ),
                            GestureDetector(

                              onTap: (){


                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => BidResMap(driverBidresItem[index])),
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.location_on_outlined,size: width/10,color: Colors.green,),
                                  Text("Map",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.green),),
                                ],
                              ),
                            )
                          ],
                        ):Center(
                          child: LoadingAnimationWidget.threeArchedCircle(
                              color: Theme.of(context).hintColor, size: 50
                          ),
                        )


                      ],
                    ),
                    decoration:  BoxDecoration(

                        color:Theme.of(context).primaryColor,

                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child:
                Text("Lets Explore",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).primaryColor),),),
              const SizedBox(height: 10,),
              CarouselSlider(
                items: [
                  Container(

                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                          matchTextDirection: true,
                          repeat: ImageRepeat.noRepeat,
                          image:  AssetImage('assets/images/1.jpg')
                          // NetworkImage(
                          //     "https://cdn-icons-png.flaticon.com/512/2389/2389215.png"
                          // ),
                        )
                    ),

                  ),
                  Container(

                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                          matchTextDirection: true,
                          repeat: ImageRepeat.noRepeat,
                          image: AssetImage('assets/images/2.jpg')
                          // NetworkImage(
                          //     "https://png.pngtree.com/png-vector/20200618/ourmid/pngtree-buying-sale-rent-cars-flat-illustration-png-image_2257829.jpg"
                          // ),
                        )
                    ),

                  ),

                ],


                options: CarouselOptions(
                  height: height/3,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),

              const SizedBox(height: 50,),

            ],
          ),
        ),
      ),
    );
  }


}