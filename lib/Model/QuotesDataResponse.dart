// To parse this JSON data, do
//
//     final quotesDataResponse = quotesDataResponseFromJson(jsonString);

import 'dart:convert';

QuotesDataResponse quotesDataResponseFromJson(String str) => QuotesDataResponse.fromJson(json.decode(str));

String quotesDataResponseToJson(QuotesDataResponse data) => json.encode(data.toJson());

class QuotesDataResponse {
  QuotesDataResponse({
    this.data,
  });

  List<Datum> data;

  QuotesDataResponse copyWith({
    List<Datum> data,
  }) =>
      QuotesDataResponse(
        data: data ?? this.data,
      );

  factory QuotesDataResponse.fromJson(Map<String, dynamic> json) => QuotesDataResponse(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.name,
    this.item,
  });

  String name;
  List<dynamic> item;

  Datum copyWith({
    String name,
    List<dynamic> item,
  }) =>
      Datum(
        name: name ?? this.name,
        item: item ?? this.item,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"] == null ? null : json["name"],
    item: json["item"] == null ? null : List<dynamic>.from(json["item"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "item": item == null ? null : List<dynamic>.from(item.map((x) => x)),
  };
}
