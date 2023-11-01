
import 'package:dolna_re_driver/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
class BidResMap extends StatefulWidget{
  DriverBidRes bidRes;


  BidResMap(this.bidRes);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BidResMapState();
  }

}

class BidResMapState extends State<BidResMap>{
  final mapsWidgetController = GlobalKey<GoogleMapsWidgetState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.bidRes.fromLng);
    print(widget.bidRes.fromLat);
    print(widget.bidRes.toLng);
    print(widget.bidRes.toLat);
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
            Expanded(
              child:
              GoogleMapsWidget(
                apiKey: "AIzaSyBWe-lmrAYShG_e50U9_W1xHd2msA01DFU",
                key: mapsWidgetController,
                sourceLatLng: LatLng(
                  double.parse(widget.bidRes.fromLat),
                  double.parse(widget.bidRes.fromLng),
                ),
                destinationLatLng: LatLng(
                  double.parse(widget.bidRes.toLat),
                  double.parse(widget.bidRes.toLng),
                ),

                destinationMarkerIconInfo: MarkerIconInfo(
                  icon: Icon(Icons.location_on,color: Theme.of(context).primaryColor,)
                ),
                sourceMarkerIconInfo: MarkerIconInfo(
                    icon: Icon(Icons.location_on,color: Colors.red,)
                ),
              ),
            ),

          ],
        )
    );
  }


}