// To parse this JSON data, do
//
//     final getBgImageResponse = getBgImageResponseFromJson(jsonString);

import 'dart:convert';

GetBgImageResponse getBgImageResponseFromJson(String str) => GetBgImageResponse.fromJson(json.decode(str));

String getBgImageResponseToJson(GetBgImageResponse data) => json.encode(data.toJson());

class GetBgImageResponse {
  GetBgImageResponse({
    this.status,
    this.data,
    this.oth,
  });

  bool status;
  Data data;
  String oth;

  factory GetBgImageResponse.fromJson(Map<String, dynamic> json) => GetBgImageResponse(
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
  Size size;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    path: json["path"] == null ? null : json["path"],
    size: json["size"] == null ? null : Size.fromJson(json["size"]),
  );

  Map<String, dynamic> toJson() => {
    "path": path == null ? null : path,
    "size": size == null ? null : size.toJson(),
  };
}

class Size {
  Size({
    this.ratio32,
    this.ratio34,
    this.ratio43,
    this.ratio44,
    this.ratio916,
  });

  Ratio ratio32;
  Ratio ratio34;
  Ratio ratio43;
  Ratio ratio44;
  Ratio ratio916;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    ratio32: json["ratio3_2"] == null ? null : Ratio.fromJson(json["ratio3_2"]),
    ratio34: json["ratio3_4"] == null ? null : Ratio.fromJson(json["ratio3_4"]),
    ratio43: json["ratio4_3"] == null ? null : Ratio.fromJson(json["ratio4_3"]),
    ratio44: json["ratio4_4"] == null ? null : Ratio.fromJson(json["ratio4_4"]),
    ratio916: json["ratio9_16"] == null ? null : Ratio.fromJson(json["ratio9_16"]),
  );

  Map<String, dynamic> toJson() => {
    "ratio3_2": ratio32 == null ? null : ratio32.toJson(),
    "ratio3_4": ratio34 == null ? null : ratio34.toJson(),
    "ratio4_3": ratio43 == null ? null : ratio43.toJson(),
    "ratio4_4": ratio44 == null ? null : ratio44.toJson(),
    "ratio9_16": ratio916 == null ? null : ratio916.toJson(),
  };
}

class Ratio {
  Ratio({
    this.img,
    this.thumb,
  });

  List<Img> img;
  List<Img> thumb;

  factory Ratio.fromJson(Map<String, dynamic> json) => Ratio(
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
