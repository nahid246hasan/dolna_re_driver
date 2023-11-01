
import 'package:dolna_re_driver/models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
class BidPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BidPageState();
  }

}
class BidPageState extends State<BidPage>{

  var status;

  var  commentsRef;
  final sharedpreff = GetStorage();
  String driverId="12345";
  List bidpageItem=[];
  @override
  void initState() {
    driverId=sharedpreff.read('driver_id');
    try{
      commentsRef = FirebaseDatabase.instance.ref("BIDS/$driverId");
      commentsRef.onChildAdded.listen((event) {
        status=event.snapshot.value;
        Bids bids=Bids.fromJson(status as Map);
        setState(() {
          bidpageItem.add(bids);
        });
      });
      commentsRef.onChildRemoved.listen((event) {
        status=event.snapshot.value;
        for(int i=0;i<bidpageItem.length;i++){
          String a=status["bid_id"].toString();
          String b=bidpageItem[i].bid_id;
          if(a==b){


            setState(() {
              bidpageItem.removeAt(i);
            });
          }
        }

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
          Container(
            width: width,
            height: height-height/10,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(bidpageItem.length, (index) {
                  return Column(
                    children: [
                      const SizedBox(height: 10,),
                      BpageItem(bidpageItem[index]),
                      const SizedBox(height: 10,),
                    ],
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

}
class BpageItem extends StatefulWidget{
  Bids bids;

  BpageItem(this.bids);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BidPageItem(bids);
  }

}
class BidPageItem extends State<BpageItem>{

  Bids bids;


  BidPageItem(this.bids);
  bool cancelClicked=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return  Container(
        margin: EdgeInsets.only(left: 10,right: 10),
        width: width,
        padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
        child: Column(
          children: [
            Row(
              children: [

                Text("Bided "+bids.bid_amount+" TK",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
              ],
            ),

            Row(
              children: [
                Icon(Icons.location_on_outlined,color: Theme.of(context).hintColor,),
                Flexible(child: Text("Pick Up "+bids.from,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined,color: Theme.of(context).hintColor,),
                Flexible(child: Text("Destination "+bids.to,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_month,color: Theme.of(context).hintColor,),
                Flexible(child: Text("Date "+bids.date,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time,color: Theme.of(context).hintColor,),
                Flexible(child: Text("time "+bids.time,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
              ],
            ),
            Row(
              children: [
                Icon(Icons.recycling,color: Theme.of(context).hintColor,),
                Flexible(child: Text("Round Trip "+bids.round_trip,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                    width: width,
                    height: 1,
                    color: Theme.of(context).hintColor,
                  ),
                  SizedBox(height: 10,),
                 // Visibility(
                 //   visible: !cancelClicked,
                 //     child:  GestureDetector(
                 //       onTap: (){
                 //         cancelClicked=true;
                 //         var  commentsRef = FirebaseDatabase.instance.ref("BIDS/"+bids.driver_id+"/"+bids.bid_id);
                 //         commentsRef.remove().then((val){
                 //           // setState(() {
                 //           //   cancelClicked=false;
                 //           // });
                 //
                 //         });
                 //
                 //       },
                 //       child: Column(
                 //         children: [
                 //           Icon(Icons.cancel_outlined,color: Colors.red,size: width/10,),
                 //           Text("Cancel",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.red,),),
                 //         ],
                 //       ),
                 //     )
                 // )
                ],
              ),
            )

          ],
        ),

        decoration:  BoxDecoration(

            color:Theme.of(context).primaryColor,

            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
      );

  }

}