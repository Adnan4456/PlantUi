import 'dart:math';

class Plants {
  List<Plant> data;
  int to;
  int perPage;
  int currentPage;
  int from;
  int lastPage;
  int total;


  Plants({
    required this.data,
    required this.to,
    required this.perPage,
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.total,
  });

  factory Plants.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonData = json['data'];
    // print("json data length in fromJson function = ${jsonData.length}");
    List<Plant> plants = jsonData.map((plant) => Plant.fromJson(plant)).toList();

    return Plants(
      data: plants,
      to: json['to'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      total: json['total'],
    );
  }
}

class Plant {
  int id;
  String price;
  String commonName;
  List<String> scientificName;
  List<String>? otherName;
  String cycle;
  String watering;
  List<String> sunlight;
  DefaultImage defaultImage;

  Plant({
    required this.id,
    required this.price,
    required this.commonName,
    required this.scientificName,
    this.otherName,
    required this.cycle,
    required this.watering,
    required this.sunlight,
    required this.defaultImage,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    List<String> otherNameList = json['other_name'] != null
        ? List<String>.from(json['other_name'])
        : <String>[];

    return Plant(
      price: "2",
        id: json['id'],
        commonName: json['common_name'],
        scientificName: List<String>.from(json['scientific_name']),
        otherName: otherNameList,
        cycle: json['cycle'],
        watering: json['watering'],
        sunlight: List<String>.from(json['sunlight']),
        // defaultImage: DefaultImage.fromJson(json['default_image']),
        defaultImage: json['default_image'] != null ? DefaultImage.fromJson(json['default_image'])
            : DefaultImage(originalUrl: "assets/images/plant-one.png",regularUrl: "assets/images/plant-one.png")
    );
  }
}


class DefaultImage {

  // int imageId;
  // int license;
  // String licenseName;
  // String licenseUrl;
  String originalUrl;
  String regularUrl;
  // String mediumUrl;
  // String smallUrl;
  // String thumbnail;

  DefaultImage({
    // required this.imageId,
    // required this.license,
    // required this.licenseName,
    // required this.licenseUrl,
    required this.originalUrl,
    required this.regularUrl,
    // required this.mediumUrl,
    // required this.smallUrl,
    // required this.thumbnail,
  });


  factory DefaultImage.fromJson(Map<String, dynamic> json) {

    return DefaultImage(
      // imageId: json['image_id'] ?? counter,
      // licenseName: json['license_name'] ?? '',
      // licenseUrl: json['license_url'] ?? '',
      originalUrl: json['original_url'] ?? '',
      regularUrl: json['regular_url'] ?? '',
      // mediumUrl: json['medium_url'] ?? '',
      // smallUrl: json['small_url'] ?? '',
      // thumbnail: json['thumbnail'] ?? '';

    );
    }
  static int randomNumber(){
     Random random = Random();
    return  10 + random.nextInt(50 -  10 + 1);

  }
}
