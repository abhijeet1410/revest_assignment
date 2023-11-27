import 'dart:convert';

DogListingResponse dogListingResponseFromJson(String str) =>
    DogListingResponse.fromJson(json.decode(str));

String dogListingResponseToJson(DogListingResponse data) =>
    json.encode(data.toJson());

class DogListingResponse {
  Map<String, List<String>> message;
  String status;

  DogListingResponse({
    required this.message,
    required this.status,
  });

  factory DogListingResponse.fromJson(Map<String, dynamic> json) =>
      DogListingResponse(
        message: Map.from(json["message"]).map((k, v) =>
            MapEntry<String, List<String>>(
                k, List<String>.from(v.map((x) => x)))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": Map.from(message).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "status": status,
      };
}
