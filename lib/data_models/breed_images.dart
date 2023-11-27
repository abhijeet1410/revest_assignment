import 'dart:convert';

BreedImagesResponse breedImagesResponseFromJson(String str) => BreedImagesResponse.fromJson(json.decode(str));

String breedImagesResponseToJson(BreedImagesResponse data) => json.encode(data.toJson());

class BreedImagesResponse {
  List<String> message;
  String status;

  BreedImagesResponse({
    required this.message,
    required this.status,
  });

  factory BreedImagesResponse.fromJson(Map<String, dynamic> json) => BreedImagesResponse(
    message: List<String>.from(json["message"].map((x) => x)),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": List<dynamic>.from(message.map((x) => x)),
    "status": status,
  };
}
