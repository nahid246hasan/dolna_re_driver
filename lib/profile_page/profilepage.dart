
import 'dart:convert';

import 'package:dolna_re_driver/function.dart';
import 'package:dolna_re_driver/profile_page/profilepageaddedit.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get_storage/get_storage.dart';
class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfilePageState();
  }
}
class ProfilePageState extends State<ProfilePage>{

  String Image="https://e7.pngegg.com/pngimages/248/193/png-clipart-sports-car-racing-sports-car-cartoon-elements-cartoon-character-compact-car.png";
  String name="Nahid";
  String mail="maknahid@24g.com";
  String phn="01534561700";
  String address="AB_555";
  // String gender="Male";
  String NID="2021-04-01";
  final sharedpreff = GetStorage();
  var d;
  var c;
  var imagesdriver;
  var imagescar;
  void myState(){
    initState();

  }

  @override
  void initState() {
    try{
      getDriverDetails(sharedpreff.read('driver_id')).then((value) {
        d=jsonDecode(value);
        print(d.toString().length);

        if(d.toString().length==2){

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePageAddUpdate("add",myState)),
          );
        }
        else{
          getCarDetails(sharedpreff.read('driver_id')).then((value) {
            c=jsonDecode(value);
            print(c.toString().length);



            try{
              setState(() {
                imagescar=c["Pictures"].split(',');
                sharedpreff.write('exist_car', 'yes');
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

              });
            }catch(er){

            }





          });
          try{
            setState(() {
              //text.split(',');
              imagesdriver=d["Photo"].split(',');
              //sharedpreff.write('exist', 'yes');
              // sharedpreff.write('driver_name', d["Name"]);

              // sharedpreff.write('driver_photo', d["Photo"].split(',')[0]);

            });
          }catch(er){
            print(er);
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

    if(d==null || c==null){
      return Scaffold(
        body: Container(
          width: width,
          height: height,
          child: Center(
            child: LoadingAnimationWidget.threeArchedCircle(
                color: Theme.of(context).hintColor, size: 50
            ),
          ),
        ),
      );
    }
    else{
      return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child:Column(

              children: [
                const SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Container(
                      width: width/3,
                      height: height/6,

                      decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                          image:  DecorationImage(
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                            matchTextDirection: true,
                            repeat: ImageRepeat.noRepeat,
                            image:  NetworkImage(
                                imagesdriver[0]
                            ),
                          )
                      ),

                    ),
                    const SizedBox(height: 20,),
                    Text(d["Name"],style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),

                    const SizedBox(height: 20,),
                    Text("Mail: "+d["Email"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),

                    const SizedBox(height: 20,),
                    Text("Address: "+d["Address"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),

                    //   const SizedBox(height: 20,),
                    // Text("$gender",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                    const SizedBox(height: 20,),
                    // Text("$NID",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                    const SizedBox(height: 20,),
                    Container(
                      width: width/3,
                      height: height/6,

                      decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.rectangle,
                          image:  DecorationImage(
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                            matchTextDirection: true,
                            repeat: ImageRepeat.noRepeat,
                            image:  NetworkImage(
                                imagescar[0]
                            ),
                          )
                      ),

                    ),
                    const SizedBox(height: 20,),
                    Text("Model: "+c["Model"],style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),

                    const SizedBox(height: 20,),
                    Text("color: "+c["Color"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),

                    const SizedBox(height: 20,),
                    Text("Type: "+c["Type"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),

                    const SizedBox(height: 20,),
                    Text("Car No: "+c["RegistrationNumber"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),

                    const SizedBox(height: 20,),
                    Text(c["isAC"]==true? "AC":"Non AC",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                    const SizedBox(height: 20,),
                    Text("Condition: "+c["Condition"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                    const SizedBox(height: 20,),




                  ],
                ),

                const SizedBox(height: 60,),
              ],
            ),
          ),
        )

      );
    }

  }


}
// Center(
//   child:LoadingAnimationWidget.threeArchedCircle(
//       color: Theme.of(context).primaryColor, size: 50
//   )
//   ,
// )



//
// import 'dart:convert';
//
// import 'package:dolna_re_driver/function.dart';
// import 'package:dolna_re_driver/profile_page/profilepageaddedit.dart';
// import 'package:flutter/material.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:get_storage/get_storage.dart';
// class ProfilePage extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return ProfilePageState();
//   }
// }
// class ProfilePageState extends State<ProfilePage>{
//
//   String Image="https://e7.pngegg.com/pngimages/248/193/png-clipart-sports-car-racing-sports-car-cartoon-elements-cartoon-character-compact-car.png";
//   String name="Nahid";
//   String mail="maknahid@24g.com";
//   String phn="01534561700";
//   String address="AB_555";
//  // String gender="Male";
//   String NID="2021-04-01";
//   final sharedpreff = GetStorage();
//   var d;
//   var c;
//   var imagesdriver;
//   var imagescar;
//   void myState(){
//     initState();
//
//   }
//
//   @override
//   void initState() {
//     getDriverDetails(sharedpreff.read('driver_id')).then((value) {
//       d=jsonDecode(value);
//       print(d.toString().length);
//
//      if(d.toString().length==2){
//
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => ProfilePageAddUpdate("add",myState)),
//        );
//      }
//      else{
//        getCarDetails(sharedpreff.read('driver_id')).then((value) {
//          c=jsonDecode(value);
//          print(c.toString().length);
//
//
//
//          try{
//            setState(() {
//              imagescar=c["Pictures"].split(',');
//              sharedpreff.write('exist_car', 'yes');
//              sharedpreff.write('car_pic', c["Pictures"].split(',')[0]);
//              sharedpreff.write('car_type', c["Type"]);
//              sharedpreff.write('car_model', c["Model"]);
//              sharedpreff.write('car_color', c["Color"]);
//              sharedpreff.write('car_reg', c["RegistrationNumber"]);
//              sharedpreff.write('car_condition', c["Condition"]);
//              sharedpreff.write('car_ac', c["isAC"].toString());
//
//              if(c["Type"]=="sedan"){
//                sharedpreff.write('car_cap', 4.toString());
//              }
//              else if(c["Type"]=="mini"){
//                sharedpreff.write('car_cap', 8.toString());
//              }
//              else if(c["Type"]=="micro"){
//                sharedpreff.write('car_cap', 12.toString());
//              }
//
//            });
//          }catch(er){
//
//          }
//
//
//
//
//
//        });
//        try{
//          setState(() {
//            //text.split(',');
//            imagesdriver=d["Photo"].split(',');
//            //sharedpreff.write('exist', 'yes');
//            // sharedpreff.write('driver_name', d["Name"]);
//
//            // sharedpreff.write('driver_photo', d["Photo"].split(',')[0]);
//
//          });
//        }catch(er){
//          print(er);
//        }
//      }
//
//
//
//
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     double width=MediaQuery.of(context).size.width;
//     double height=MediaQuery.of(context).size.height;
//
//     if(d==null){
//       return Scaffold(
//         body: Container(
//           width: width,
//           height: height,
//           child: Center(
//             child: LoadingAnimationWidget.threeArchedCircle(
//                 color: Theme.of(context).hintColor, size: 50
//             ),
//           ),
//         ),
//       );
//     }
//     else{
//       return Scaffold(
//         body: SingleChildScrollView(
//           child:Column(
//
//             children: [
//               const SizedBox(height: 30,),
//               Row(
//                 //  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   Flexible(
//                     flex:1,
//                     child:  Container(
//                       width: width/3,
//                       height: height/6,
//
//                       decoration: BoxDecoration(
//                           color: Colors.orange,
//                           shape: BoxShape.circle,
//                           image:  DecorationImage(
//                             fit: BoxFit.fill,
//                             alignment: Alignment.center,
//                             matchTextDirection: true,
//                             repeat: ImageRepeat.noRepeat,
//                             image:  NetworkImage(
//                                 imagesdriver[0]
//                             ),
//                           )
//                       ),
//
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 10,right: 10),
//                     color: Theme.of(context).primaryColor,
//                     width:2,
//                     height: height/1.5,
//                   ),
//                   Flexible(
//                       flex:3,
//                       child:  Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 20,),
//                           Text(d["Name"],style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//
//                           const SizedBox(height: 20,),
//                           Text(d["Email"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//
//                           const SizedBox(height: 20,),
//                           Text(d["Address"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//
//                           //   const SizedBox(height: 20,),
//                           // Text("$gender",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//                           const SizedBox(height: 20,),
//                          // Text("$NID",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//                           const SizedBox(height: 20,),
//
//
//
//
//                         ],
//                       )
//                   )
//                 ],
//               ),
//               // SizedBox(
//               //     width: double.infinity,
//               //     child:  ElevatedButton(
//               //
//               //       style: ElevatedButton.styleFrom(
//               //         backgroundColor:Theme.of(context).primaryColor,
//               //         shape: StadiumBorder(),
//               //         shadowColor: Colors.black,
//               //
//               //
//               //       ),
//               //       onPressed: (){
//               //
//               //
//               //         // Navigator.pop(context);
//               //         Navigator.push(
//               //           context,
//               //           MaterialPageRoute(builder: (context) => ProfilePageAddUpdate("update",myState)),
//               //         );
//               //       },
//               //       child:Text("Update",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
//               //     )
//               // ),
//               const SizedBox(height: 60,),
//             ],
//           ),
//         ),
//
//       );
//     }
//
//   }
//
//
// }
// // Center(
// //   child:LoadingAnimationWidget.threeArchedCircle(
// //       color: Theme.of(context).primaryColor, size: 50
// //   )
// //   ,
// // )