part of 'models.dart';





class ImageData{
  final String prefix;
  final String numbers;
  final XFile images;

  ImageData({
    required this.prefix,
    required this.numbers,
    required this.images
  });

  Map<dynamic, dynamic> toMap() {
    return {
      'prefix': prefix,
      'numbers': numbers,
      'images': images,
    };
  }

  factory ImageData.fromMap(Map<dynamic, dynamic> map) {
    return ImageData(
      prefix: map['prefix'],
      numbers: map['numbers'],
      images: (map['images']),
    );
  }
}