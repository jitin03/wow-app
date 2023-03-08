// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BookingStatus bookingStatusFromJson(String str) => BookingStatus.fromJson(json.decode(str));

String bookingStatusToJson(BookingStatus data) => json.encode(data.toJson());

class BookingStatus {
  BookingStatus({
     this.status,
  });

  String? status;

  factory BookingStatus.fromJson(Map<String, dynamic> json) => BookingStatus(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}
