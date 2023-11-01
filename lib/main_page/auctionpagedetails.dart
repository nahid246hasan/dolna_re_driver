
import 'dart:async';
import 'dart:convert';

import 'package:dolna_re_driver/models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:connectivity/connectivity.dart';

class AuctionPageDetails extends StatefulWidget{

  Auction auction;


  AuctionPageDetails(this.auction);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AuctionPageDetailsState();
  }

}
class AuctionPageDetailsState extends State<AuctionPageDetails>{

  final mapsWidgetController = GlobalKey<GoogleMapsWidgetState>();


  var status;

  var  commentsRef;
  final sharedpreff = GetStorage();
  String driverId="";
  String bidID="";
  String bidamount="";
  TextEditingController offer = TextEditingController();
  bool offerButtonPress=false;
  bool alreadyBid=false;
  String alreadyBidString="";
  var bids;
  @override
  void initState() {

    driverId=sharedpreff.read('driver_id');
    print(driverId);
   try{
     commentsRef = FirebaseDatabase.instance.ref("BIDS/$driverId");
     commentsRef.onValue.listen((DatabaseEvent event) {
       for (var child  in event.snapshot.children ) {
         print("dddddddddddddddddddddddddddddddddddddddddddddddddddddd");
         setState(() {
           bids=Bids.fromJson(child.value as Map);
         });

         if(bids.auction_id==widget.auction.auction_id){

           setState(() {
             alreadyBid=true;
             alreadyBidString="Bided  "+bids.bid_amount+" Tk";
             bidamount=bids.bid_amount;
             bidID=bids.bid_id;
           });

           //break;
         }

       }
     });


     commentsRef = FirebaseDatabase.instance.ref("AUCTION2");
     commentsRef.onChildRemoved.listen((event) {
       status=event.snapshot.value;

       String a=status["auction_id"].toString();

       if(a==widget.auction.auction_id){

         Navigator.pop(context);
         setState(() {

         });
       }
       // print(auctionPageItem[i].id.toString());
       // print("object");
       // print(status["id"].toString());



     });
   }catch(er){

   }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;


      return Scaffold(

        body: Column(

          children: [
            Container(
                width: width,
                height: height/10,
                color: Theme.of(context).primaryColor,
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,color: Theme.of(context).hintColor,),
                )
            ),
            MediaQuery.of(context).viewInsets.bottom==0?Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              width: width,
              padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
              child: Column(
                children: [
                  Row(
                    children: [

                      Text("Fare Minimum "+widget.auction.minimum,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,color: Theme.of(context).hintColor,),
                      Flexible(child: Text("Pick Up ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.green,),),)
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                        child: Text(widget.auction.from,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                        decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Theme.of(context).primaryColor,width: 2)

                  ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,color: Theme.of(context).hintColor,),
                      Flexible(child: Text("Destination ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.red),),)
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                    child: Text(widget.auction.to,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Theme.of(context).primaryColor,width: 2)

                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_month,color: Theme.of(context).hintColor,),
                      Flexible(child: Text("Date "+widget.auction.date,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time,color: Theme.of(context).hintColor,),
                      Flexible(child: Text("time "+widget.auction.time,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.recycling,color: Theme.of(context).hintColor,),
                      Flexible(child: Text("Round Trip "+widget.auction.round_trip,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
                    ],
                  ),
                  Visibility(
                      visible: alreadyBid,
                      child: Text("$alreadyBidString",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color:Colors.green,),)
                  )

                ],
              ),

              decoration:  BoxDecoration(

                  color:Theme.of(context).primaryColor,

                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
            ):Container(),
            Expanded(
              child:
              GoogleMapsWidget(
                apiKey: "AIzaSyBWe-lmrAYShG_e50U9_W1xHd2msA01DFU",
                key: mapsWidgetController,
                sourceLatLng: LatLng(
                  double.parse(widget.auction.from_lat),
                  double.parse(widget.auction.from_lng),
                ),
                destinationLatLng: LatLng(
                  double.parse(widget.auction.to_lat),
                  double.parse(widget.auction.to_lng),
                ),
                destinationMarkerIconInfo: MarkerIconInfo(
                  assetPath: "assets/images/car.png",
                ),
              ),
            ),
            // Visibility(
            //   visible: alreadyBid,
            //     child: Container(
            //       margin: EdgeInsets.only(left: 10,right: 10),
            //       width: width,
            //       padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
            //       child:GestureDetector(
            //         onTap: (){
            //           setState(() {
            //             alreadyBid=false;
            //           });
            //
            //           print("object");
            //           commentsRef = FirebaseDatabase.instance.ref("BIDS/$driverId/$bidID");
            //           commentsRef.remove().then((val){
            //             setState(() {
            //               offerButtonPress=false;
            //             });
            //
            //           });
            //
            //         },
            //         child:  Column(
            //           children: [
            //             Icon(Icons.cancel_outlined,color: Theme.of(context).hintColor,size: width/10,),
            //             Text("Cancel",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
            //           ],
            //         ),
            //       ),
            //       decoration: BoxDecoration(
            //
            //           color:Theme.of(context).primaryColor,
            //
            //           borderRadius: BorderRadius.all(Radius.circular(15))
            //       ),
            //     )
            // ),
            Visibility(
              visible: !alreadyBid,
              child:  Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                width: width,
                padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller:offer,
                      decoration:  InputDecoration(

                        // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                        // labelText: "Institute",
                          hintText: "offer",
                          hintStyle: TextStyle( color: Theme.of(context).primaryColor),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(74, 74, 179,1), width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(20)),

                          ),
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Visibility(
                      visible: !offerButtonPress ,
                      child: SizedBox(

                          width: double.infinity,
                          child:  ElevatedButton(

                            style: ElevatedButton.styleFrom(
                              backgroundColor:Theme.of(context).primaryColor,
                              shape: StadiumBorder(),
                              shadowColor: Colors.black,


                            ),
                            onPressed: () async {
                              var connectivityResult = await (Connectivity().checkConnectivity());
                              if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                setState(() {
                                  offerButtonPress=true;
                                });
                               try{
                                 commentsRef =FirebaseDatabase.instance.ref("BIDS/$driverId");
                                 bidID=commentsRef.push().key;
                                 commentsRef =FirebaseDatabase.instance.ref("BIDS/$driverId/$bidID");

                                 await commentsRef.set({

                                   "auction_id":widget.auction.auction_id,
                                   "bid_amount":offer.text,
                                   "bid_id":bidID,
                                   "driver_id":driverId,
                                   "rating":"4",
                                   "from":widget.auction.from,
                                   "to": widget.auction.to,
                                   "date":widget.auction.date,
                                   "time":widget.auction.time,
                                   "round_trip":widget.auction.round_trip,
                                   "fromLat":widget.auction.from_lat,
                                   "fromLng":widget.auction.from_lng,
                                   "toLat":widget.auction.to_lat,
                                   "toLng":widget.auction.to_lng,

                                   "car_pic":sharedpreff.read('car_pic'),
                                   "car_type":sharedpreff.read('car_type'),
                                   "model":sharedpreff.read('car_model'),
                                   "color":sharedpreff.read('car_color'),
                                   "reg_no":sharedpreff.read('car_reg'),
                                   "condition":sharedpreff.read('car_condition'),
                                   "ac":sharedpreff.read('car_ac'),
                                   "seat_cap":sharedpreff.read('car_cap'),
                                   "driver_pic":sharedpreff.read('driver_photo'),
                                   "driver_name":sharedpreff.read('driver_name'),
                                   "driver_phn":sharedpreff.read('driver_phn')








                                 }).then((val){
                                   Navigator.pop(context);
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
                                          Text("No Net",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                                          const SizedBox(height: 10,),

                                        ],
                                      ),
                                    )
                                ));
                              }


                              // Navigator.pop(context);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => ProfilePageAddUpdate()),
                              // );
                            },
                            child:Text("Offer",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                          )
                      ),
                    ),
                    Visibility(
                        visible: offerButtonPress,
                        child: LoadingAnimationWidget.threeArchedCircle(
                            color: Theme.of(context).hintColor, size: 20
                        )
                    ),
                    // const SizedBox(height: 20,)
                  ],
                ),

                decoration:  BoxDecoration(

                    color:Theme.of(context).primaryColor,

                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
              ),
            )
          ],
        ),
      );
    }

  }


