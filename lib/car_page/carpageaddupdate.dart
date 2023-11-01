
import 'dart:convert';
import 'dart:io';

import 'package:dolna_re_driver/function.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class CarPageAddUpdate extends StatefulWidget{

  String type;

  Function f;

  CarPageAddUpdate(this.type,this.f);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CarPageAddUpdateState();
  }

}
class CarPageAddUpdateState extends State<CarPageAddUpdate>{
  String Image="https://e7.pngegg.com/pngimages/248/193/png-clipart-sports-car-racing-sports-car-cartoon-elements-cartoon-character-compact-car.png";

  String type="sedan";
  List<String> typeList=["sedan","mini","micro"];
  String DOB="2020-12-12";
  ImagePicker picker = ImagePicker();
  String ac="Non AC";

  TextEditingController model = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController car_no = TextEditingController();
  TextEditingController condition = TextEditingController();

  bool onCarPress=false;
// Pick an image.
  var image;
  var regImage;
  var taxImage;
  var fitnessImage;
  List<File> _images=[];
  String imagesLink="";
  var c;
  final sharedpreff = GetStorage();
  List<String> _imagesname=['carpic','reg','tax','fitness'];
  @override
  void initState() {
    getCarDetails(sharedpreff.read('driver_id')).then((value) {
      c=jsonDecode(value);
      print(c.toString().length);

      if(c.toString().length==2){


      }
      else{
        setState(() {

        });
      }




    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Column(
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
            ),
          ),
          Container(
            color: Colors.white,
            width: width,
            height: height-height/10,
            padding: EdgeInsets.only(left: 10,right: 10),
            child: SingleChildScrollView(
              child:
              Column(

                children: [
                  const SizedBox(height: 30,),
                  Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Flexible(
                          flex:1,
                          child:
                          Column(
                            children: [
                              GestureDetector(
                                onTap: ()  async {

                                  await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then((value) {
                                    setState(() {
                                      image=value;
                                      _images.add(File(image.path));
                                      print(image);
                                    });

                                    // print(image!.path);
                                  });
                                },
                                child:  Container(
                                  width: width/3,
                                  height: height/6,
                                  child: Center(
                                    child: Icon(Icons.upload,color: Theme.of(context).hintColor,size: width/7,),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle,
                                      image:  DecorationImage(
                                          fit: BoxFit.fill,
                                          alignment: Alignment.center,
                                          matchTextDirection: true,
                                          repeat: ImageRepeat.noRepeat,
                                          image:image!=null? new FileImage(File( image.path)): new AssetImage(
                                              "assets/images/upload_icon.png"
                                          ) as ImageProvider
                                      )
                                  ),

                                ),

                              ),
                              Text("Profile Image",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                            ],
                          )
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
                              // Text("$name",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                              TextFormField(
                                 controller: model,
                                decoration:  InputDecoration(

                                  // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                                  // labelText: "Institute",
                                    hintText: "Model",
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
                              //Text("$mail ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                              TextFormField(
                                 controller: color,
                                decoration:  InputDecoration(

                                  // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                                  // labelText: "Institute",
                                    hintText: "color",
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

                              TextFormField(
                                 controller:car_no,
                                decoration:  InputDecoration(

                                  // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                                  // labelText: "Institute",
                                    hintText: "Car No",
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
                              // Text("address $address ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                              DropdownButton(

                                  isExpanded: true,
                                  value: type,
                                  items: typeList!
                                      .map<DropdownMenuItem<String>>(
                                          (String value) => DropdownMenuItem<String>(
                                        value: value,
                                        child:  Text(value,style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w900,



                                        ),),
                                      ))
                                      .toList()

                                  ,
                                  onChanged: (val){
                                    setState(() {
                                      type=val!;

                                    });
                                  }
                              ),
                              const SizedBox(height: 20,),
                              // Text("$gender",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 // Text("Select DOB:",style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 16),),
                                  Text(ac,style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 18),),
                                  LiteRollingSwitch(
                                    value: false,
                                    width: width/3.5,
                                    textOn: 'AC',
                                    textOff: 'Non AC',
                                    colorOn: Theme.of(context).hintColor,
                                    colorOff: Colors.red,
                                    iconOn: Icons.lightbulb_outline,
                                    iconOff: Icons.lightbulb_outline,
                                    animationDuration: const Duration(milliseconds: 100),
                                    onChanged: (bool state) {
                                      // print('turned ${(state) ? 'BN' : 'ENG'}');
                                      if(state==true){
                                        setState(() {
                                          ac="AC";
                                        });

                                      }
                                      else{
                                        setState(() {

                                          ac="Non AC";
                                        });

                                      }
                                    },
                                    onDoubleTap: () {},
                                    onSwipe: () {},
                                    onTap: () {},
                                  ),
                                ],

                              ),
                              const SizedBox(height: 20,),
                              TextFormField(
                                 controller:condition,
                                decoration:  InputDecoration(

                                  // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                                  // labelText: "Institute",
                                    hintText: "Car Condition",
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
                              // Text("$DOB",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                              const SizedBox(height: 20,),
                              Row(
                                children: [
                                  Flexible(
                                    flex:2,
                                    child: Text("Pick Car Registration Image",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                                  ),
                                  Flexible(
                                      flex:1,
                                      child:
                                      GestureDetector(
                                        onTap: ()  async {

                                          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then((value) {
                                            setState(() {
                                              regImage=value;
                                              _images.add(File(regImage.path));
                                            });

                                            // print(image!.path);
                                          });
                                        },
                                        child:  Container(
                                          width: width/5,
                                          height: height/8,
                                          child: Center(
                                            child: Icon(Icons.upload,color: Theme.of(context).hintColor,size: width/7,),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              shape: BoxShape.circle,
                                              image:  DecorationImage(
                                                  fit: BoxFit.fill,
                                                  alignment: Alignment.center,
                                                  matchTextDirection: true,
                                                  repeat: ImageRepeat.noRepeat,
                                                  image:regImage!=null? new FileImage(File( regImage.path)):new AssetImage(
                                                      "assets/images/upload_icon.png"
                                                  ) as ImageProvider
                                              )
                                          ),

                                        ),

                                      )
                                  ),
                                ],

                              ),
                              const SizedBox(height: 20,),
                              Row(
                                children: [
                                  Flexible(
                                    flex:2,
                                    child: Text("Pick tax Image (front Side)",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                                  ),
                                  Flexible(
                                      flex:1,
                                      child:
                                      GestureDetector(
                                        onTap: ()  async {

                                          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then((value) {
                                            setState(() {
                                              taxImage=value;

                                              _images.add(File(taxImage.path));
                                            });

                                            // print(image!.path);
                                          });
                                        },
                                        child:  Container(
                                          width: width/5,
                                          height: height/8,
                                          child: Center(
                                            child: Icon(Icons.upload,color: Theme.of(context).hintColor,size: width/7,),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              shape: BoxShape.circle,
                                              image:  DecorationImage(
                                                  fit: BoxFit.fill,
                                                  alignment: Alignment.center,
                                                  matchTextDirection: true,
                                                  repeat: ImageRepeat.noRepeat,
                                                  image:taxImage!=null? new FileImage(File( taxImage.path)): new AssetImage(
                                                      "assets/images/upload_icon.png"
                                                  ) as ImageProvider
                                              )
                                          ),

                                        ),

                                      )
                                  ),
                                ],

                              ),
                              const SizedBox(height: 20,),
                              Row(
                                children: [
                                  Flexible(
                                    flex:2,
                                    child: Text("Pick car fitness Image (front Side)",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                                  ),
                                  Flexible(
                                      flex:1,
                                      child:
                                      GestureDetector(
                                        onTap: ()  async {

                                          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then((value) {
                                            setState(() {
                                              fitnessImage=value;
                                              _images.add(File(fitnessImage.path));
                                            });

                                            // print(image!.path);
                                          });
                                        },
                                        child:  Container(
                                          width: width/5,
                                          height: height/8,
                                          child: Center(
                                            child: Icon(Icons.upload,color: Theme.of(context).hintColor,size: width/7,),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              shape: BoxShape.circle,
                                              image:  DecorationImage(
                                                  fit: BoxFit.fill,
                                                  alignment: Alignment.center,
                                                  matchTextDirection: true,
                                                  repeat: ImageRepeat.noRepeat,
                                                  image:fitnessImage!=null? new FileImage(File( fitnessImage.path)):new AssetImage(
                                                      "assets/images/upload_icon.png"
                                                  ) as ImageProvider
                                              )
                                          ),

                                        ),

                                      )
                                  ),
                                ],

                              ),




                            ],
                          )
                      )
                    ],
                  ),
                  !onCarPress?SizedBox(
                      width: double.infinity,
                      child:  ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor:Theme.of(context).primaryColor,
                          shape: StadiumBorder(),
                          shadowColor: Colors.black,


                        ),
                        onPressed: (){

                          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                              duration: const Duration(seconds: 30),

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
                                    Text("Do you want To Confirm?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(

                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:Theme.of(context).hintColor,
                                              shape: StadiumBorder(),
                                              shadowColor: Colors.black,


                                            ),
                                            onPressed: () async{

                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            var connectivityResult = await (Connectivity().checkConnectivity());
                            if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                              if(model.text.length<1 || color.text.length<1 || car_no.text.length<1 || condition.text.length<1 || _images.length<4){
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
                                          Text("Please fill up all the fields",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                                          const SizedBox(height: 10,),

                                        ],
                                      ),
                                    )
                                ));
                              }
                              else{
                                setState(() {
                                  onCarPress=true;
                                });
                                uploadFiles( _images,sharedpreff.read('driver_id'),_imagesname).then((value) {

                                  imagesLink+=value[0]+",";
                                  imagesLink+=value[1]+",";
                                  imagesLink+=value[2]+",";
                                  imagesLink+=value[3];

                                  print(imagesLink);
                                  bool tmp;
                                  if(ac=="AC"){
                                    tmp=true;
                                  }
                                  else{
                                    tmp=false;
                                  }
                                  if(widget.type=="add"){
                                    saveCarDetails(sharedpreff.read('driver_id'),model.text,color.text ,car_no.text,type,tmp,condition.text,imagesLink).then((value) {
                                      print(value);
                                      widget.f();
                                      Navigator.of(context).pop();

                                    });
                                  }
                                  else{
                                    updateCarDetails(sharedpreff.read('driver_id'),model.text,color.text ,car_no.text,type,tmp,condition.text,imagesLink).then((value) {
                                      print(value);
                                      widget.f();
                                      Navigator.of(context).pop();

                                    });
                                  }


                                });
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


                                              // Navigator.pop(context);
                                              //
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(builder: (context) => CarRequestSend()),
                                              // );
                                              //ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            },
                                            child: Text("Yes",style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 20),)
                                        ),
                                        ElevatedButton(

                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context).hintColor,
                                              shape: StadiumBorder(),
                                              shadowColor: Colors.black,


                                            ),
                                            onPressed: (){


                                              // Navigator.pop(context);
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(builder: (context) => OtpPage(phoneNumber.text)),
                                              // );
                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            },
                                            child: Text("No",style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 20),)
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              )
                          ));
                          // Navigator.pop(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => OtpPage(phoneNumber.text)),
                          // );
                        },
                        child:Text("Update",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                      )
                  ):LoadingAnimationWidget.threeArchedCircle(
                      color: Theme.of(context).hintColor, size: 50
                  ),

                  const SizedBox(height: 60,),
                const SizedBox(height: 300),

                ],
              ),
            ),
          )
        ],
      ) ,
    );
  }

}