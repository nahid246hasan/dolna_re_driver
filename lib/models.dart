
class Bids {
 String auction_id ;
 String bid_amount;
 String bid_id;
 String driver_id;
 String rating;
 String from;
 String to;
 String date;
 String time;
 String round_trip;
 String car_pic;
 String car_type;
 String model;
 String color;
 String reg_no;
 String condition;
 String ac;
 String seat_cap;
 String driver_pic;
 String driver_name;
 String driver_phn;

 Bids(
      this.auction_id,
      this.bid_amount,
      this.bid_id,
      this.driver_id,
      this.rating,
      this.from,
      this.to,
      this.date,
      this.time,
      this.round_trip,
      this.car_pic,
      this.car_type,
      this.model,
      this.color,
      this.reg_no,
      this.condition,
      this.ac,
      this.seat_cap,
      this.driver_pic,
      this.driver_name,
      this.driver_phn

     );

  Bids.fromJson(Map json)
      :auction_id = json['auction_id'],
        bid_amount = json['bid_amount'],
        bid_id = json['bid_id'],
        driver_id = json['driver_id'],
        rating = json['rating'],
        from = json['from'],
        to = json['to'],
        date = json['date'],
        time = json['time'],
         round_trip = json['round_trip'],
         car_pic=json['car_pic'],
        car_type = json['car_type'],
        model = json['model'],
        color = json['color'],
        reg_no = json['reg_no'],
        condition = json['condition'],
        ac = json['ac'],
        seat_cap= json['seat_cap'],
        driver_pic= json['driver_pic'],
        driver_name= json['driver_name'],
        driver_phn= json['driver_phn']
 ;


}

class Auction {
  String auction_id;
  String car_type;
  String user_id;
  String from;
  String to;
  String from_lat;
  String from_lng;
  String to_lat;
  String to_lng;
  String round_trip;
  String date;
  String time;
  String minimum;
  String type;


  Auction(this.auction_id,this.car_type, this.user_id, this.from, this.to, this.from_lat,
      this.from_lng, this.to_lat, this.to_lng, this.round_trip, this.date,
      this.time, this.minimum, this.type);

  Auction.fromJson(Map json)
      :
        auction_id = json['auction_id'],
        car_type=json['car_type'],
        user_id = json['user_id'],
        from= json['from'],
        to = json['to'],
        from_lat = json['from_lat'],
        from_lng = json['from_lng'],
        to_lat = json['to_lat'],
        to_lng = json['to_lng'],
        round_trip = json['round_trip'],
        date = json['date'],
        time = json['time'],
        minimum = json['minimum'],
        type= json['type'] ;


}

class DriverBidRes{
String bidres_id;
String from;
String to;
String user_phn;
String fromLat;
String fromLng;
String toLat;
String toLng;
String fare;


DriverBidRes(this.bidres_id, this.from, this.to, this.user_phn, this.fromLat,
    this.fromLng, this.toLat, this.toLng,this.fare);

DriverBidRes.fromJson(Map json)
    :
      bidres_id = json['bidres_id'],
      from= json['from'],
      to = json['to'],
      user_phn = json['user_phn'],
      fromLat=json["fromLat"],
      fromLng=json["fromLng"],
      toLat=json["toLat"],
      toLng=json["toLng"],
      fare=json["fare"]

;


}