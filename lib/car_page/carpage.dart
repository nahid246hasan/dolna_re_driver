

import 'dart:convert';

import 'package:dolna_re_driver/car_page/carpageaddupdate.dart';
import 'package:dolna_re_driver/function.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get_storage/get_storage.dart';
class CarPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CarPageState();
  }
}
class CarPageState extends State<CarPage>{

  String Image="https://e7.pngegg.com/pngimages/248/193/png-clipart-sports-car-racing-sports-car-cartoon-elements-cartoon-character-compact-car.png";
  String model="Toyota";
  String color="maknahid@24g.com";
  String type="01534561700";
  String reg="AB_555";
  String ac="Male";
  String condition="2021-04-01";
  final sharedpreff = GetStorage();
  var c;
 var images;
  void myState(){
    initState();
  }


  @override
  void initState() {
    getCarDetails(sharedpreff.read('driver_id')).then((value) {
      c=jsonDecode(value);
      print(c.toString().length);

      if(c.toString().length==2){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CarPageAddUpdate("add",myState)),
        );
      }
      else{
        setState(() {
          images=c["Pictures"].split(',');
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
      }




    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    if(c==null){
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
        body: SingleChildScrollView(
          child:Column(

            children: [
              const SizedBox(height: 30,),
              Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Flexible(
                    flex:1,
                    child:  Container(
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
                                images[0]
                            ),
                          )
                      ),

                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    color: Theme.of(context).primaryColor,
                    width:2,
                    height: height/1.5,
                  ),
                  Flexible(
                      flex:3,
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          Text(c["Model"],style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),

                          const SizedBox(height: 20,),
                          Text(c["Color"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),

                          const SizedBox(height: 20,),
                          Text(c["Type"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),

                          const SizedBox(height: 20,),
                          Text(c["RegistrationNumber"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),

                          const SizedBox(height: 20,),
                          Text(c["isAC"]==true? "AC":"Non AC",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                          const SizedBox(height: 20,),
                          Text(c["Condition"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                          const SizedBox(height: 20,),




                        ],
                      )
                  )
                ],
              ),
              SizedBox(
                  width: double.infinity,
                  child:  ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor:Theme.of(context).primaryColor,
                      shape: StadiumBorder(),
                      shadowColor: Colors.black,


                    ),
                    onPressed: (){


                      // Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CarPageAddUpdate("update",myState)),
                      );
                    },
                    child:Text("Update",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                  )
              ),
              const SizedBox(height: 60,),
            ],
          ),
        ),

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