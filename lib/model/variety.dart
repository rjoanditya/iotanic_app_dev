import 'dart:convert';

Variety varietyFromJson(String str) => Variety.fromJson(json.decode(str));

String varietyToJson(Variety data) => json.encode(data.toJson());

class Variety {
  String id;
  String name;

  Variety({
    required this.id,
    required this.name,
  });

  factory Variety.fromJson(Map<String, dynamic> json) => Variety(
        id: json["id"].toString(),
        name: json["name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  // @override
  // String toString() {
  //   return '{id: $id, name: $name}';
  // }
}
