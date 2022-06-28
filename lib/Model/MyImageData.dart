// To parse this JSON data, do
//
//     final myImageData = myImageDataFromJson(jsonString);

import 'dart:convert';

MyImageData myImageDataFromJson(String str) => MyImageData.fromJson(json.decode(str));

String myImageDataToJson(MyImageData data) => json.encode(data.toJson());

class MyImageData {
  MyImageData({
    this.status,
    this.data,
    this.oth,
  });

  bool status;
  Data data;
  String oth;

  factory MyImageData.fromJson(Map<String, dynamic> json) => MyImageData(
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
    this.size,
  });

  String path;
  Map<String, SizeData> size;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    path: json["path"] == null ? null : json["path"],
    size: json["size"] == null ? null : Map.from(json["size"]).map((k, v) => MapEntry<String, SizeData>(k, SizeData.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "path": path == null ? null : path,
    "size": size == null ? null : Map.from(size).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class SizeData {
  SizeData({
    this.img,
    this.thumb,
  });

  List<Img> img;
  List<Img> thumb;

  factory SizeData.fromJson(Map<String, dynamic> json) => SizeData(
    img: json["img"] == null ? null : List<Img>.from(json["img"].map((x) => Img.fromJson(x))),
    thumb: json["thumb"] == null ? null : List<Img>.from(json["thumb"].map((x) => Img.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "img": img == null ? null : List<dynamic>.from(img.map((x) => x.toJson())),
    "thumb": thumb == null ? null : List<dynamic>.from(thumb.map((x) => x.toJson())),
  };
}

class Img {
  Img({
    this.img,
  });

  String img;

  factory Img.fromJson(Map<String, dynamic> json) => Img(
    img: json["img"] == null ? null : json["img"],
  );

  Map<String, dynamic> toJson() => {
    "img": img == null ? null : img,
  };
}
