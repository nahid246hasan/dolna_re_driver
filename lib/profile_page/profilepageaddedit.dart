
import 'dart:io';

import 'package:dolna_re_driver/function.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get_storage/get_storage.dart';
class ProfilePageAddUpdate extends StatefulWidget{
  String type;

  Function f;


  ProfilePageAddUpdate(this.type,this.f);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfilePageAddUpdateState();
  }

}
class ProfilePageAddUpdateState extends State<ProfilePageAddUpdate>{
  String Image="https://e7.pngegg.com/pngimages/248/193/png-clipart-sports-car-racing-sports-car-cartoon-elements-cartoon-character-compact-car.png";

  String gender="Male";
  List<String> genderList=["Male","Female"];
  String DOB="2020-12-12";
  ImagePicker picker = ImagePicker();

  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController address = TextEditingController();

// Pick an image.
  var imagedriver;
  var nidImage;
  var licenceImage;
  List<File> _imagesdriver=[];
  final sharedpreff = GetStorage();
  List<String> _imagesnamedriver=['profile','nid','license'];
  String imagesLinkdriver="";

  String type="sedan";
  List<String> typeList=["sedan","mini","micro"];
 // String DOB="2020-12-12";
 // ImagePicker picker = ImagePicker();
  String ac="Non AC";

  TextEditingController model = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController car_no = TextEditingController();
  TextEditingController condition = TextEditingController();

  bool onCarPress=false;
// Pick an image.
  var imagecar;
  var regImage;
  var taxImage;
  var fitnessImage;
  List<File> _imagescar=[];
  String imagesLinkcar="";
  var c;
  //final sharedpreff = GetStorage();
  List<String> _imagesnamecar=['carpic','reg','tax','fitness'];


  bool onProfilePress=false;

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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: ()  async {

                            await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then((value) {

                             try{
                               setState(() {
                                 imagedriver=value;
                                 _imagesdriver.add(File(imagedriver.path));
                                 //print(image);
                               });
                             }catch(er){

                             }

                              // print(image!.path);
                            });
                          },
                          child:  Container(
                            width: width/3,
                            height: height/6,
                            child: Center(
                              child: Icon(Icons.upload,color: Theme.of(context).hintColor,size: width/5,),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                                image:  DecorationImage(
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                    matchTextDirection: true,
                                    repeat: ImageRepeat.noRepeat,
                                    image:imagedriver!=null? new FileImage(File( imagedriver.path)):new AssetImage(
                                        "assets/images/upload_icon.png"
                                    ) as ImageProvider
                                )
                            ),

                          ),

                        ),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: Text("Profile Image",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                      ),
                      const SizedBox(height: 20,),
                      // Text("$name",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                      TextFormField(
                        controller: name,
                        decoration:  InputDecoration(

                          // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                          // labelText: "Institute",
                            hintText: "Name",
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
                        controller: mail,
                        decoration:  InputDecoration(

                          // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                          // labelText: "Institute",
                            hintText: "Mail",
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
                        controller:address,
                        decoration:  InputDecoration(

                          // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                          // labelText: "Institute",
                            hintText: "Address",
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
                      // DropdownButton(
                      //
                      //     isExpanded: true,
                      //     value: gender,
                      //     items: genderList!
                      //         .map<DropdownMenuItem<String>>(
                      //             (String value) => DropdownMenuItem<String>(
                      //           value: value,
                      //           child:  Text(value,style: TextStyle(
                      //             fontSize: 18,
                      //             color: Theme.of(context).primaryColor,
                      //             fontWeight: FontWeight.w900,
                      //
                      //
                      //
                      //           ),),
                      //         ))
                      //         .toList()
                      //
                      //     ,
                      //     onChanged: (val){
                      //       setState(() {
                      //         gender=val!;
                      //
                      //       });
                      //     }
                      // ),
                      // const SizedBox(height: 20,),
                      // // Text("$gender",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                      // Row(
                      //   children: [
                      //     Text("Select DOB:",style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 16),),
                      //     Text(DOB,style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 16),),
                      //     GestureDetector(
                      //         onTap: () async {
                      //           await showDatePicker(
                      //
                      //             context: context,
                      //             initialDate:DateTime(2023),
                      //             firstDate: DateTime(1980),
                      //             lastDate:DateTime.now(),
                      //             builder: (context, child) {
                      //               return Theme(
                      //                 data: Theme.of(context).copyWith(
                      //                   colorScheme: ColorScheme.light(
                      //                     primary: Color.fromRGBO(74, 74, 179,1), // <-- SEE HERE
                      //                     onPrimary: Color.fromRGBO(100, 97, 255, 1), // <-- SEE HERE
                      //                     onSurface:Color.fromRGBO(74, 74, 179,1), // <-- SEE HERE
                      //                   ),
                      //                   textButtonTheme: TextButtonThemeData(
                      //                     style: TextButton.styleFrom(
                      //                       primary: Colors.red, // button text color
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 child: child!,
                      //               );
                      //             },
                      //           ).then((value) {
                      //             print(value.toString());
                      //             setState(() {
                      //               DOB=value!.year.toString()+"-"+value.month.toString()+"-"+value.day.toString();
                      //             });
                      //           });
                      //         },
                      //         child: Icon(Icons.calendar_month,
                      //           size: 40,
                      //           color: Theme.of(context).primaryColor,
                      //         )
                      //
                      //     ),
                      //   ],
                      //
                      // ),
                      const SizedBox(height: 20,),
                      // Text("$DOB",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),

                      Row(
                        children: [
                          Flexible(
                            flex:2,
                            child: Text("Pick Nid Image (front Side)",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                          ),
                          Flexible(
                              flex:1,
                              child:
                              GestureDetector(
                                onTap: ()  async {

                                  await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then((value) {
                                   try{
                                     setState(() {
                                       nidImage=value;
                                       //print(image);
                                       _imagesdriver.add(File(nidImage.path));
                                     });
                                   }catch(er){

                                   }

                                    // print(image!.path);
                                  });
                                },
                                child:  Container(
                                  width: width/5,
                                  height: height/8,
                                  child: Center(
                                    child: Icon(Icons.upload,color: Theme.of(context).hintColor,size: width/5,),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle,
                                      image:  DecorationImage(
                                          fit: BoxFit.fill,
                                          alignment: Alignment.center,
                                          matchTextDirection: true,
                                          repeat: ImageRepeat.noRepeat,
                                          image:nidImage!=null? new FileImage(File( nidImage.path)): new AssetImage(
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
                            child: Text("Pick driving licence Image (front Side)",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                          ),
                          Flexible(
                              flex:1,
                              child:
                              GestureDetector(
                                onTap: ()  async {

                                  await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then((value) {
                                  try{
                                    setState(() {
                                      licenceImage=value;
                                      _imagesdriver.add(File(licenceImage.path));
                                    });
                                  }catch(er){

                                  }

                                    // print(image!.path);
                                  });
                                },
                                child:  Container(
                                  width: width/5,
                                  height: height/8,
                                  child: Center(
                                    child: Icon(Icons.upload,color: Theme.of(context).hintColor,size: width/5,),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      shape: BoxShape.circle,
                                      image:  DecorationImage(
                                          fit: BoxFit.fill,
                                          alignment: Alignment.center,
                                          matchTextDirection: true,
                                          repeat: ImageRepeat.noRepeat,
                                          image:licenceImage!=null? new FileImage(File( licenceImage.path)): new AssetImage(
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




                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex:2,
                            child: Text("Pick Car Front Image",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                          ),
                          Flexible(
                              flex:1,
                              child:
                              GestureDetector(
                                onTap: ()  async {

                                  await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then((value) {
                                   try{
                                     setState(() {
                                       imagecar=value;
                                       _imagescar.add(File(imagecar.path));
                                     });
                                   }catch(er){

                                   }

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
                                          image:imagecar!=null? new FileImage(File( imagecar.path)):new AssetImage(
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
                      // Text("$name",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
                      TextFormField(
                        controller: model,
                        decoration:  InputDecoration(

                          // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),


                          // labelText: "Institute",
                            hintText: "Car Model",
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
                                   try{
                                     setState(() {
                                       regImage=value;
                                       _imagescar.add(File(regImage.path));
                                     });
                                   }catch(er){

                                   }

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
                                  try{
                                    setState(() {
                                      taxImage=value;

                                      _imagescar.add(File(taxImage.path));
                                    });
                                  }catch(er){

                                  }

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
                                   try{
                                     setState(() {
                                       fitnessImage=value;
                                       _imagescar.add(File(fitnessImage.path));
                                     });
                                   }catch(er){

                                   }

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
                  ),
                  !onProfilePress?SizedBox(
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
                                                if(name.text.length<1 || mail.text.length<1 || address.text.length<1 ||
                                                    _imagesdriver.length<3    || model.text.length<1 || color.text.length<1 ||
                                                    car_no.text.length<1 || condition.text.length<1 || _imagescar.length<4){
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
                                                    onProfilePress = true;
                                                  });
                                                  uploadFiles( _imagesdriver,sharedpreff.read('driver_id'),_imagesnamedriver).then((value) {
                                                    imagesLinkdriver+=value[0]+",";
                                                    imagesLinkdriver+=value[1]+",";
                                                    imagesLinkdriver+=value[2];

                                                    print(imagesLinkdriver);
                                                    if(widget.type=="add"){
                                                      saveDriverDetails(sharedpreff.read('driver_id'),name.text,sharedpreff.read('driver_phn') ,mail.text,address.text,"String nid",imagesLinkdriver).then((value) {
                                                        print(value);
                                                        widget.f();
                                                        Navigator.of(context).pop();



                                                      });
                                                    }
                                                    else{
                                                      updateDriverDetails(sharedpreff.read('driver_id'),name.text,sharedpreff.read('driver_phn') ,mail.text,address.text,"String nid",imagesLinkdriver).then((value) {
                                                        print(value);
                                                        widget.f();
                                                        Navigator.of(context).pop();



                                                      });
                                                    }

                                                  });
                                                  uploadFiles( _imagescar,sharedpreff.read('driver_id'),_imagesnamecar).then((value) {

                                                    imagesLinkcar+=value[0]+",";
                                                    imagesLinkcar+=value[1]+",";
                                                    imagesLinkcar+=value[2]+",";
                                                    imagesLinkcar+=value[3];

                                                    print(imagesLinkcar);
                                                    bool tmp;
                                                    if(ac=="AC"){
                                                      tmp=true;
                                                    }
                                                    else{
                                                      tmp=false;
                                                    }
                                                    if(widget.type=="add"){
                                                      saveCarDetails(sharedpreff.read('driver_id'),model.text,color.text ,car_no.text,type,tmp,condition.text,imagesLinkcar).then((value) {
                                                        print(value);
                                                        widget.f();
                                                        Navigator.of(context).pop();

                                                      });
                                                    }
                                                    else{
                                                      updateCarDetails(sharedpreff.read('driver_id'),model.text,color.text ,car_no.text,type,tmp,condition.text,imagesLinkcar).then((value) {
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
                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                        child:Text(widget.type,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                      )
                  ):LoadingAnimationWidget.threeArchedCircle(
                      color: Theme.of(context).hintColor, size: 50
                  ),
                  const SizedBox(height: 60,),
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


//
// import 'dart:io';
//
// import 'package:dolna_re_driver/function.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// class ProfilePageAddUpdate extends StatefulWidget{
//   String type;
//
//   Function f;
//
//
//   ProfilePageAddUpdate(this.type,this.f);
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return ProfilePageAddUpdateState();
//   }
//
// }
// class ProfilePageAddUpdateState extends State<ProfilePageAddUpdate>{
//   String Image="https://e7.pngegg.com/pngimages/248/193/png-clipart-sports-car-racing-sports-car-cartoon-elements-cartoon-character-compact-car.png";
//
//   String gender="Male";
//   List<String> genderList=["Male","Female"];
//   String DOB="2020-12-12";
//   ImagePicker picker = ImagePicker();
//
//   TextEditingController name = TextEditingController();
//   TextEditingController mail = TextEditingController();
//   TextEditingController address = TextEditingController();
//
// // Pick an image.
//   var image;
//   var nidImage;
//   var licenceImage;
//   List<File> _images=[];
//   final sharedpreff = GetStorage();
//   List<String> _imagesname=['profile','nid','license'];
//   String imagesLink="";
//
//   bool onProfilePress=false;
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     double width=MediaQuery.of(context).size.width;
//     double height=MediaQuery.of(context).size.height;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body:Column(
//         children: [
//           Container(
//             width: width,
//             height: height/10,
//             color: Theme.of(context).primaryColor,
//             alignment: Alignment.centerLeft,
//             child: GestureDetector(
//               onTap: (){
//                 Navigator.pop(context);
//               },
//               child: Icon(Icons.arrow_back,color: Theme.of(context).hintColor,),
//             ),
//           ),
//           Container(
//             color: Colors.white,
//             width: width,
//             height: height-height/10,
//             padding: EdgeInsets.only(left: 10,right: 10),
//             child: SingleChildScrollView(
//               child:
//               Column(
//
//                 children: [
//                   const SizedBox(height: 30,),
//                   Row(
//                     //  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       Flexible(
//                           flex:1,
//                           child:
//                           Column(
//                             children: [
//                               GestureDetector(
//                                 onTap: ()  async {
//
//                                   await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then((value) {
//                                     setState(() {
//                                       image=value;
//                                       _images.add(File(image.path));
//                                       print(image);
//                                     });
//
//                                     // print(image!.path);
//                                   });
//                                 },
//                                 child:  Container(
//                                   width: width/3,
//                                   height: height/6,
//                                   child: Center(
//                                     child: Icon(Icons.upload,color: Theme.of(context).hintColor,size: width/5,),
//                                   ),
//                                   decoration: BoxDecoration(
//                                       color: Colors.orange,
//                                       shape: BoxShape.circle,
//                                       image:  DecorationImage(
//                                           fit: BoxFit.fill,
//                                           alignment: Alignment.center,
//                                           matchTextDirection: true,
//                                           repeat: ImageRepeat.noRepeat,
//                                           image:image!=null? new FileImage(File( image.path)):new AssetImage(
//                                               "assets/images/upload_icon.png"
//                                           ) as ImageProvider
//                                       )
//                                   ),
//
//                                 ),
//
//                               ),
//                               Text("Profile Image",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//                             ],
//                           )
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 10,right: 10),
//                         color: Theme.of(context).primaryColor,
//                         width:2,
//                         height: height/1.5,
//                       ),
//                       Flexible(
//                           flex:3,
//                           child:  Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 20,),
//                               // Text("$name",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//                               TextFormField(
//                                  controller: name,
//                                 decoration:  InputDecoration(
//
//                                   // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),
//
//
//                                   // labelText: "Institute",
//                                     hintText: "Name",
//                                     hintStyle: TextStyle( color: Theme.of(context).primaryColor),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Color.fromRGBO(74, 74, 179,1), width: 2.0),
//                                       borderRadius: BorderRadius.all(Radius.circular(20)),
//
//                                     ),
//                                     border: const OutlineInputBorder(),
//                                     filled: true,
//                                     fillColor: Colors.white
//                                 ),
//                               ),
//                               const SizedBox(height: 20,),
//                               //Text("$mail ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//                               TextFormField(
//                                  controller: mail,
//                                 decoration:  InputDecoration(
//
//                                   // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),
//
//
//                                   // labelText: "Institute",
//                                     hintText: "Mail",
//                                     hintStyle: TextStyle( color: Theme.of(context).primaryColor),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Color.fromRGBO(74, 74, 179,1), width: 2.0),
//                                       borderRadius: BorderRadius.all(Radius.circular(20)),
//
//                                     ),
//                                     border: const OutlineInputBorder(),
//                                     filled: true,
//                                     fillColor: Colors.white
//                                 ),
//                               ),
//                               const SizedBox(height: 20,),
//
//                               TextFormField(
//                                  controller:address,
//                                 decoration:  InputDecoration(
//
//                                   // prefixIcon: Icon(Icons.person_outline_outlined,color: Color.fromRGBO(74, 74, 179,1),),
//
//
//                                   // labelText: "Institute",
//                                     hintText: "Address",
//                                     hintStyle: TextStyle( color: Theme.of(context).primaryColor),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Color.fromRGBO(74, 74, 179,1), width: 2.0),
//                                       borderRadius: BorderRadius.all(Radius.circular(20)),
//
//                                     ),
//                                     border: const OutlineInputBorder(),
//                                     filled: true,
//                                     fillColor: Colors.white
//                                 ),
//                               ),
//                               const SizedBox(height: 20,),
//                               // Text("address $address ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//                               // DropdownButton(
//                               //
//                               //     isExpanded: true,
//                               //     value: gender,
//                               //     items: genderList!
//                               //         .map<DropdownMenuItem<String>>(
//                               //             (String value) => DropdownMenuItem<String>(
//                               //           value: value,
//                               //           child:  Text(value,style: TextStyle(
//                               //             fontSize: 18,
//                               //             color: Theme.of(context).primaryColor,
//                               //             fontWeight: FontWeight.w900,
//                               //
//                               //
//                               //
//                               //           ),),
//                               //         ))
//                               //         .toList()
//                               //
//                               //     ,
//                               //     onChanged: (val){
//                               //       setState(() {
//                               //         gender=val!;
//                               //
//                               //       });
//                               //     }
//                               // ),
//                               // const SizedBox(height: 20,),
//                               // // Text("$gender",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//                               // Row(
//                               //   children: [
//                               //     Text("Select DOB:",style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 16),),
//                               //     Text(DOB,style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 16),),
//                               //     GestureDetector(
//                               //         onTap: () async {
//                               //           await showDatePicker(
//                               //
//                               //             context: context,
//                               //             initialDate:DateTime(2023),
//                               //             firstDate: DateTime(1980),
//                               //             lastDate:DateTime.now(),
//                               //             builder: (context, child) {
//                               //               return Theme(
//                               //                 data: Theme.of(context).copyWith(
//                               //                   colorScheme: ColorScheme.light(
//                               //                     primary: Color.fromRGBO(74, 74, 179,1), // <-- SEE HERE
//                               //                     onPrimary: Color.fromRGBO(100, 97, 255, 1), // <-- SEE HERE
//                               //                     onSurface:Color.fromRGBO(74, 74, 179,1), // <-- SEE HERE
//                               //                   ),
//                               //                   textButtonTheme: TextButtonThemeData(
//                               //                     style: TextButton.styleFrom(
//                               //                       primary: Colors.red, // button text color
//                               //                     ),
//                               //                   ),
//                               //                 ),
//                               //                 child: child!,
//                               //               );
//                               //             },
//                               //           ).then((value) {
//                               //             print(value.toString());
//                               //             setState(() {
//                               //               DOB=value!.year.toString()+"-"+value.month.toString()+"-"+value.day.toString();
//                               //             });
//                               //           });
//                               //         },
//                               //         child: Icon(Icons.calendar_month,
//                               //           size: 40,
//                               //           color: Theme.of(context).primaryColor,
//                               //         )
//                               //
//                               //     ),
//                               //   ],
//                               //
//                               // ),
//                               const SizedBox(height: 20,),
//                               // Text("$DOB",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//
//                               Row(
//                                 children: [
//                                   Flexible(
//                                       flex:2,
//                                       child: Text("Pick Nid Image (front Side)",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//                                   ),
//                                   Flexible(
//                                       flex:1,
//                                       child:
//                                       GestureDetector(
//                                         onTap: ()  async {
//
//                                           await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then((value) {
//                                             setState(() {
//                                               nidImage=value;
//                                               print(image);
//                                               _images.add(File(nidImage.path));
//                                             });
//
//                                             // print(image!.path);
//                                           });
//                                         },
//                                         child:  Container(
//                                           width: width/5,
//                                           height: height/8,
//                                           child: Center(
//                                             child: Icon(Icons.upload,color: Theme.of(context).hintColor,size: width/5,),
//                                           ),
//                                           decoration: BoxDecoration(
//                                               color: Colors.orange,
//                                               shape: BoxShape.circle,
//                                               image:  DecorationImage(
//                                                   fit: BoxFit.fill,
//                                                   alignment: Alignment.center,
//                                                   matchTextDirection: true,
//                                                   repeat: ImageRepeat.noRepeat,
//                                                   image:nidImage!=null? new FileImage(File( nidImage.path)): new AssetImage(
//                                                       "assets/images/upload_icon.png"
//                                                   ) as ImageProvider
//                                               )
//                                           ),
//
//                                         ),
//
//                                       )
//                                   ),
//                                 ],
//
//                               ),
//
//                               const SizedBox(height: 20,),
//
//                               Row(
//                                 children: [
//                                   Flexible(
//                                     flex:2,
//                                     child: Text("Pick driving licence Image (front Side)",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Theme.of(context).primaryColor,),),
//                                   ),
//                                   Flexible(
//                                       flex:1,
//                                       child:
//                                       GestureDetector(
//                                         onTap: ()  async {
//
//                                           await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then((value) {
//                                             setState(() {
//                                               licenceImage=value;
//                                               _images.add(File(licenceImage.path));
//                                             });
//
//                                             // print(image!.path);
//                                           });
//                                         },
//                                         child:  Container(
//                                           width: width/5,
//                                           height: height/8,
//                                           child: Center(
//                                             child: Icon(Icons.upload,color: Theme.of(context).hintColor,size: width/5,),
//                                           ),
//                                           decoration: BoxDecoration(
//                                               color: Colors.orange,
//                                               shape: BoxShape.circle,
//                                               image:  DecorationImage(
//                                                   fit: BoxFit.fill,
//                                                   alignment: Alignment.center,
//                                                   matchTextDirection: true,
//                                                   repeat: ImageRepeat.noRepeat,
//                                                   image:licenceImage!=null? new FileImage(File( licenceImage.path)): new AssetImage(
//                                                       "assets/images/upload_icon.png"
//                                                   ) as ImageProvider
//                                               )
//                                           ),
//
//                                         ),
//
//                                       )
//                                   ),
//                                 ],
//
//                               ),
//
//                               const SizedBox(height: 20,),
//
//
//
//
//                             ],
//                           )
//                       )
//                     ],
//                   ),
//                   !onProfilePress?SizedBox(
//                       width: double.infinity,
//                       child:  ElevatedButton(
//
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:Theme.of(context).primaryColor,
//                           shape: StadiumBorder(),
//                           shadowColor: Colors.black,
//
//
//                         ),
//                         onPressed: (){
//
//                           ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
//                               duration: const Duration(seconds: 30),
//
//                               backgroundColor: Theme.of(context).primaryColor,
//                               content: Container(
//                                 //height: height/3,
//                                 //margin: EdgeInsets.only(left: 10,right: 10),
//                                 width: width,
//                                 padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
//                                 decoration:  BoxDecoration(
//
//                                     color:Theme.of(context).primaryColor,
//
//                                     borderRadius: BorderRadius.all(Radius.circular(15))
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Text("Do you want To Confirm?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
//                                     const SizedBox(height: 10,),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         ElevatedButton(
//
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor:Theme.of(context).hintColor,
//                                               shape: StadiumBorder(),
//                                               shadowColor: Colors.black,
//
//
//                                             ),
//                                             onPressed: () async{
//                                                 ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                                                 var connectivityResult = await (Connectivity().checkConnectivity());
//                                                 if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
//                                                   if(name.text.length<1 || mail.text.length<1 || address.text.length<1 || _images.length<3){
//                                                     ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
//                                                         duration: const Duration(seconds: 2),
//
//                                                         backgroundColor: Theme.of(context).primaryColor,
//                                                         content: Container(
//                                                           //height: height/3,
//                                                           //margin: EdgeInsets.only(left: 10,right: 10),
//                                                           width: width,
//                                                           padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
//                                                           decoration:  BoxDecoration(
//
//                                                               color:Theme.of(context).primaryColor,
//
//                                                               borderRadius: BorderRadius.all(Radius.circular(15))
//                                                           ),
//                                                           child: Column(
//                                                             children: [
//                                                               Text("Please fill up all the fields",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
//                                                               const SizedBox(height: 10,),
//
//                                                             ],
//                                                           ),
//                                                         )
//                                                     ));
//                                                   }
//                                                   else{
//                                                     setState(() {
//                                                       onProfilePress = true;
//                                                     });
//                                                     uploadFiles( _images,sharedpreff.read('driver_id'),_imagesname).then((value) {
//                                                       imagesLink+=value[0]+",";
//                                                       imagesLink+=value[1]+",";
//                                                       imagesLink+=value[2];
//
//                                                       print(imagesLink);
//                                                       if(widget.type=="add"){
//                                                         saveDriverDetails(sharedpreff.read('driver_id'),name.text,sharedpreff.read('driver_phn') ,mail.text,address.text,"String nid",imagesLink).then((value) {
//                                                           print(value);
//                                                           widget.f();
//                                                           Navigator.of(context).pop();
//
//
//
//                                                         });
//                                                       }
//                                                       else{
//                                                         updateDriverDetails(sharedpreff.read('driver_id'),name.text,sharedpreff.read('driver_phn') ,mail.text,address.text,"String nid",imagesLink).then((value) {
//                                                           print(value);
//                                                           widget.f();
//                                                           Navigator.of(context).pop();
//
//
//
//                                                         });
//                                                       }
//
//                                                     });
//                                                   }
//
//                                                 }
//                                                 else{
//                                                   ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
//                                                       duration: const Duration(seconds: 2),
//
//                                                       backgroundColor: Theme.of(context).primaryColor,
//                                                       content: Container(
//                                                         //height: height/3,
//                                                         //margin: EdgeInsets.only(left: 10,right: 10),
//                                                         width: width,
//                                                         padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
//                                                         decoration:  BoxDecoration(
//
//                                                             color:Theme.of(context).primaryColor,
//
//                                                             borderRadius: BorderRadius.all(Radius.circular(15))
//                                                         ),
//                                                         child: Column(
//                                                           children: [
//                                                             Text("No Network",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
//                                                             const SizedBox(height: 10,),
//
//                                                           ],
//                                                         ),
//                                                       )
//                                                   ));
//                                                 }
//
//                                               // Navigator.pop(context);
//                                               //
//                                               // Navigator.push(
//                                               //   context,
//                                               //   MaterialPageRoute(builder: (context) => CarRequestSend()),
//                                               // );
//                                               ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                                             },
//                                             child: Text("Yes",style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 20),)
//                                         ),
//                                         ElevatedButton(
//
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Theme.of(context).hintColor,
//                                               shape: StadiumBorder(),
//                                               shadowColor: Colors.black,
//
//
//                                             ),
//                                             onPressed: (){
//
//
//                                               // Navigator.pop(context);
//                                               // Navigator.push(
//                                               //   context,
//                                               //   MaterialPageRoute(builder: (context) => OtpPage(phoneNumber.text)),
//                                               // );
//                                               ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                                             },
//                                             child: Text("No",style: TextStyle(color:Theme.of(context).primaryColor, fontSize: 20),)
//                                         ),
//
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               )
//                           ));
//                           // Navigator.pop(context);
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(builder: (context) => OtpPage(phoneNumber.text)),
//                           // );
//                         },
//                         child:Text(widget.type,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
//                       )
//                   ):LoadingAnimationWidget.threeArchedCircle(
//                       color: Theme.of(context).hintColor, size: 50
//                   ),
//                   const SizedBox(height: 60,),
//                   const SizedBox(height: 60,),
//                   const SizedBox(height: 300),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ) ,
//     );
//   }
//
// }