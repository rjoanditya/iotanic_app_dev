// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'dart:convert';

Province provinceFromJson(String str) => Province.fromJson(json.decode(str));

String provinceToJson(Province data) => json.encode(data.toJson());

class Province {
  String id;
  String name;

  Province({
    required this.id,
    required this.name,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
  @override
  String toString() => name;
}

class Regency {
  String id;
  String name;

  Regency({
    required this.id,
    required this.name,
  });

  factory Regency.fromJson(Map<String, dynamic> json) => Regency(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
  @override
  String toString() => name;
}

class District {
  String id;
  String name;

  District({
    required this.id,
    required this.name,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
  @override
  String toString() => name;
}

class Village {
  String id;
  String name;

  Village({
    required this.id,
    required this.name,
  });

  factory Village.fromJson(Map<String, dynamic> json) => Village(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
  @override
  String toString() => name;
}
