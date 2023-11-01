
import 'dart:convert';

import 'package:dolna_re_driver/Auth/authentication_repository.dart';
import 'package:dolna_re_driver/function.dart';
import 'package:dolna_re_driver/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get_storage/get_storage.dart';
class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage>{
  TextEditingController phoneNumber = TextEditingController();

  final controller=Get.put(AuthenticationRepository());
  bool onNumberEnterButtonPress=false;
  final sharedpreff = GetStorage();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height:height,
            color: Color.fromRGBO(255,255,255, 1),
            padding:  EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children:  [
                Container(
                  width: width/2,
                  height: height/3,
                  //child: Icon(CustomIcons.option, size: 20,),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(255, 214, 133,1),
                      image:  DecorationImage(
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        matchTextDirection: true,
                        repeat: ImageRepeat.noRepeat,
                        image: AssetImage('assets/images/dolna_logo.jpg'),
                      )
                  ),


                ),
                Form(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical:  10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: phoneNumber,
                          keyboardType: TextInputType.phone,
                          decoration:  InputDecoration(

                              prefixIcon: Icon(Icons.phone,color: Theme.of(context).primaryColor,),


                              labelText: "Phone No ex 01534561707",
                              hintText: "Phone No ex 01534561707",
                              labelStyle: TextStyle(color: Theme.of(context).primaryColor),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(20)),

                              ),
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white
                          ),
                        ),
                        const SizedBox(height:  20),

                        const SizedBox(height:  20),

                        Visibility(
                          visible: !onNumberEnterButtonPress,
                          child: SizedBox(
                              width: double.infinity,
                              child:  ElevatedButton(

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    shape: StadiumBorder(),
                                    shadowColor: Colors.black,


                                  ),
                                  onPressed: () async{
                                    print(phoneNumber.text);
                                    if(phoneNumber.text.length==11){

                                      setState(() {
                                        onNumberEnterButtonPress=true;
                                      });

                                      String phn=phoneNumber.text;
                                      var connectivityResult = await (Connectivity().checkConnectivity());
                                      if (connectivityResult == ConnectivityResult.mobile) {
                                        // I am connected to a mobile network.
                                        // AuthenticationRepository.instance.phoneauth(phn).then((value) {
                                        //   Navigator.pop(context);
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(builder: (context) => OtpPage(phn)),
                                        //   );
                                        // });

                                        try{
                                          verifyPhnToken(sharedpreff.read("serial"),sharedpreff.read("device"),sharedpreff.read("name")).then((value) {
                                            var d=jsonDecode(value);
                                            print(d.toString());
                                            if(d["token"]!=null){

                                              sendPhnToken(phn, sharedpreff.read("serial"), d["token"]).then((value1){
                                                var c=jsonDecode(value1);
                                                print(c.toString());
                                                if(c["msg"]!=null){
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => OtpPage(phn)),
                                                  );
                                                }
                                                else{
                                                  setState(() {
                                                    onNumberEnterButtonPress=false;
                                                  });
                                                }
                                              });
                                            }
                                            else{
                                              setState(() {
                                                onNumberEnterButtonPress=false;
                                              });
                                              Fluttertoast.showToast(
                                                  msg: "Retry",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );
                                            }
                                          });
                                        }catch(er){

                                        }

                                      } else if (connectivityResult == ConnectivityResult.wifi) {
                                        // I am connected to a wifi network.
                                        // AuthenticationRepository.instance.phoneauth(phn).then((value) {
                                        //   Navigator.pop(context);
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(builder: (context) => OtpPage(phn)),
                                        //   );
                                        // });
                                        try{
                                          verifyPhnToken(sharedpreff.read("serial"),sharedpreff.read("device"),sharedpreff.read("name")).then((value) {
                                            var d=jsonDecode(value);
                                            if(d["token"]!=null){
                                              sendPhnToken(phn, sharedpreff.read("serial"), d["token"]).then((value1){
                                                var c=jsonDecode(value1);
                                                if(c["msg"]!=null){
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => OtpPage(phn)),
                                                  );
                                                }
                                                else{
                                                  setState(() {
                                                    onNumberEnterButtonPress=false;
                                                  });
                                                }
                                              });
                                            }
                                            else{
                                              setState(() {
                                                onNumberEnterButtonPress=false;
                                              });
                                              Fluttertoast.showToast(
                                                  msg: "Retry",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0
                                              );
                                            }
                                          });
                                        }catch(er){

                                        }
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
                                                  Text("Something went wrong",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                                                  const SizedBox(height: 10,),

                                                ],
                                              ),
                                            )
                                        ));
                                        setState(() {
                                          onNumberEnterButtonPress=false;
                                        });
                                      }
                                      //try{

                                    }
                                    // // catch(er){
                                    //    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                    //        duration: const Duration(seconds: 4),
                                    //
                                    //        backgroundColor: Theme.of(context).primaryColor,
                                    //        content: Container(
                                    //          //height: height/3,
                                    //          //margin: EdgeInsets.only(left: 10,right: 10),
                                    //          width: width,
                                    //          padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                                    //          decoration:  BoxDecoration(
                                    //
                                    //              color:Theme.of(context).primaryColor,
                                    //
                                    //              borderRadius: BorderRadius.all(Radius.circular(15))
                                    //          ),
                                    //          child: Column(
                                    //            children: [
                                    //              Text("Something went wrong",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                                    //              const SizedBox(height: 10,),
                                    //
                                    //            ],
                                    //          ),
                                    //        )
                                    //    ));
                                    //  }



                                    // }
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
                                                Text("Phone number format is not Ok",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Theme.of(context).hintColor,),),
                                                const SizedBox(height: 10,),

                                              ],
                                            ),
                                          )
                                      ));
                                    }
                                  },
                                  child: Text("ok",style: TextStyle(color:Theme.of(context).hintColor, fontSize: 20),)
                              )
                          ),
                        ),
                        Visibility(
                            visible: onNumberEnterButtonPress,
                            child:  Center(
                              child: LoadingAnimationWidget.threeArchedCircle(
                                  color: Theme.of(context).hintColor, size: 50
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}