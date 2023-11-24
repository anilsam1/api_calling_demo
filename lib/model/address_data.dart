

import 'dart:convert';

List<AddressData> addressDataFromJson(data) => List<AddressData>.from(data.map((x) => AddressData.fromJson(x)));

String addressDataToJson(List<AddressData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressData {
  int id;
  String uid;
  String city;
  String streetName;
  String streetAddress;
  String secondaryAddress;
  String buildingNumber;
  String mailBox;
  String community;
  String zipCode;
  String zip;
  String postcode;
  String timeZone;
  String streetSuffix;
  String citySuffix;
  String cityPrefix;
  String state;
  String stateAbbr;
  String country;
  String countryCode;
  double latitude;
  double longitude;
  String fullAddress;

  AddressData({
    required this.id,
    required this.uid,
    required this.city,
    required this.streetName,
    required this.streetAddress,
    required this.secondaryAddress,
    required this.buildingNumber,
    required this.mailBox,
    required this.community,
    required this.zipCode,
    required this.zip,
    required this.postcode,
    required this.timeZone,
    required this.streetSuffix,
    required this.citySuffix,
    required this.cityPrefix,
    required this.state,
    required this.stateAbbr,
    required this.country,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) => AddressData(
    id: json["id"],
    uid: json["uid"],
    city: json["city"],
    streetName: json["street_name"],
    streetAddress: json["street_address"],
    secondaryAddress: json["secondary_address"],
    buildingNumber: json["building_number"],
    mailBox: json["mail_box"],
    community: json["community"],
    zipCode: json["zip_code"],
    zip: json["zip"],
    postcode: json["postcode"],
    timeZone: json["time_zone"],
    streetSuffix: json["street_suffix"],
    citySuffix: json["city_suffix"],
    cityPrefix: json["city_prefix"],
    state: json["state"],
    stateAbbr: json["state_abbr"],
    country: json["country"],
    countryCode: json["country_code"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    fullAddress: json["full_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "city": city,
    "street_name": streetName,
    "street_address": streetAddress,
    "secondary_address": secondaryAddress,
    "building_number": buildingNumber,
    "mail_box": mailBox,
    "community": community,
    "zip_code": zipCode,
    "zip": zip,
    "postcode": postcode,
    "time_zone": timeZone,
    "street_suffix": streetSuffix,
    "city_suffix": citySuffix,
    "city_prefix": cityPrefix,
    "state": state,
    "state_abbr": stateAbbr,
    "country": country,
    "country_code": countryCode,
    "latitude": latitude,
    "longitude": longitude,
    "full_address": fullAddress,
  };
}
