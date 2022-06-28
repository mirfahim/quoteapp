import 'dart:convert';

GetUserDataResponse getUserDataResponseFromJson(String str) => GetUserDataResponse.fromJson(json.decode(str));

String getUserDataResponseToJson(GetUserDataResponse data) => json.encode(data.toJson());

class GetUserDataResponse {
  GetUserDataResponse({
    this.status,
    this.data,
    this.oth,
  });

  bool status;
  List<Datum> data;
  String oth;

  factory GetUserDataResponse.fromJson(Map<String, dynamic> json) => GetUserDataResponse(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    oth: json["oth"] == null ? null : json["oth"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "oth": oth == null ? null : oth,
  };
}

class Datum {
  Datum({
    this.name,
    this.status,
  });

  String name;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["Name"] == null ? null : json["Name"],
    status: json["Status"] == null ? null : json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name == null ? null : name,
    "Status": status == null ? null : status,
  };
}
