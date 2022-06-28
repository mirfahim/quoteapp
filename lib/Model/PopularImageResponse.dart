// To parse this JSON data, do
//
//     final popularImageResponse = popularImageResponseFromJson(jsonString);

import 'dart:convert';

PopularImageResponse popularImageResponseFromJson(String str) => PopularImageResponse.fromJson(json.decode(str));

String popularImageResponseToJson(PopularImageResponse data) => json.encode(data.toJson());

class PopularImageResponse {
  PopularImageResponse({
    this.status,
    this.data,
    this.oth,
  });

  bool status;
  Data data;
  String oth;

  factory PopularImageResponse.fromJson(Map<String, dynamic> json) => PopularImageResponse(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    oth: json["oth"] == null ? null : json["oth"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
    "oth": oth == null ? null : oth,
  };
}

class Data {
  Data({
    this.path,
    this.src,
  });

  String path;
  List<Src> src;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    path: json["path"] == null ? null : json["path"],
    src: json["src"] == null ? null : List<Src>.from(json["src"].map((x) => Src.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "path": path == null ? null : path,
    "src": src == null ? null : List<dynamic>.from(src.map((x) => x.toJson())),
  };
}

class Src {
  Src({
    this.img,
  });

  String img;

  factory Src.fromJson(Map<String, dynamic> json) => Src(
    img: json["img"] == null ? null : json["img"],
  );

  Map<String, dynamic> toJson() => {
    "img": img == null ? null : img,
  };
}
