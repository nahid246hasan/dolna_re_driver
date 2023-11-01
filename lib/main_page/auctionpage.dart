
import 'package:dolna_re_driver/main_page/auctionpagedetails.dart';
import 'package:dolna_re_driver/models.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuctionPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AuctionPageState();
  }

}
class AuctionPageState extends State<AuctionPage>{


  var status;

  var  commentsRef;

  List auctionPageItem=[];

  final sharedpreff = GetStorage();
  @override
  void initState() {
    try{
      commentsRef = FirebaseDatabase.instance.ref("AUCTION2");

      auctionPageItem.clear();
      commentsRef.onChildAdded.listen((event) {
        status=event.snapshot.value;
        print("sd");
        print(status["id"]);
        Auction auction=Auction.fromJson(status as Map) ;
        if(auction.car_type==sharedpreff.read('car_type')){
          setState(() {
            auctionPageItem.add(auction);
          });
        }

      });

      commentsRef.onChildRemoved.listen((event) {
        status=event.snapshot.value;
        for(int i=0;i<auctionPageItem.length;i++){
          String a=status["auction_id"].toString();
          String b=auctionPageItem[i].auction_id.toString();

          // print(a.trim());
          // print("object");
          // print(b.trim());
          print("object");
          print(a.compareTo(b));
          if(a==b){


            setState(() {
              auctionPageItem.removeAt(i);
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
                 children: [
                   const SizedBox(height: 20,),
                   LoadingAnimationWidget.threeArchedCircle(
                       color: Theme.of(context).primaryColor, size: 50
                   ),

                   Text("Searching",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                   const SizedBox(height: 20,),
                   Column(
                     children: List.generate(auctionPageItem.length, (index) {
                       return Column(
                         children: [
                           const SizedBox(height: 20,),
                           AuctionPageItem(auctionPageItem[index].auction_id,auctionPageItem[index]),
                         ],
                       );
                     }),
                   ),

                   const SizedBox(height: 20,),

                 ],
               ),
             ),
           )
        ],
      ),
    );
  }

}
class AuctionPageItem extends StatelessWidget{

  String id;
  Auction auction;


  AuctionPageItem(this.id,this.auction);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        // Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuctionPageDetails(auction)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 10,right: 10),
        width: width,
        padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
        child: Column(
          children: [
            Row(
              children: [

                Text("Fare Minimum "+auction.minimum,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
              ],
            ),

            Row(
              children: [
                Icon(Icons.location_on_outlined,color: Theme.of(context).hintColor,),
                Flexible(child: Text("Pick Up "+auction.from,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined,color: Theme.of(context).hintColor,),
                Flexible(child: Text("Destination "+auction.to,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_month,color: Theme.of(context).hintColor,),
                Flexible(child: Text("Date "+auction.date,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time,color: Theme.of(context).hintColor,),
                Flexible(child: Text("time "+auction.time,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
              ],
            ),
            Row(
              children: [
                Icon(Icons.recycling,color: Theme.of(context).hintColor,),
                Flexible(child: Text("Round Trip "+auction.round_trip,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),)
              ],
            )

          ],
        ),

        decoration:  BoxDecoration(

            color:Theme.of(context).primaryColor,

            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
      ),
    );
  }

}