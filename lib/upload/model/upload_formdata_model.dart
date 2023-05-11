import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_formdata_model.g.dart';

@JsonSerializable()
class UploadModel {
  // Content
  String? content;
  // Style
  @JsonKey(name: 'hashtagDTO.amekaji')
  bool? hashtagAmekaji;
  @JsonKey(name: 'hashtagDTO.casual')
  bool? hashtagCasual;
  @JsonKey(name: 'hashtagDTO.guitar')
  bool? hashtagGuitar;
  @JsonKey(name: 'hashtagDTO.minimal')
  bool? hashtagMinimal;
  @JsonKey(name: 'hashtagDTO.sporty')
  bool? hashtagSporty;
  @JsonKey(name: 'hashtagDTO.street')
  bool? hashtagStreet;
  // Gps
  double? latitude;
  double? longitude;
  // Image File
  // List<MultipartFile>? files;

  UploadModel({
    this.content,
    this.hashtagAmekaji,
    this.hashtagCasual,
    this.hashtagGuitar,
    this.hashtagMinimal,
    this.hashtagSporty,
    this.hashtagStreet,
    this.latitude,
    this.longitude,
    // this.files
  });

  factory UploadModel.fromJson(Map<String, dynamic> json) =>
      _$UploadModelFromJson(json);

  Map<String, dynamic> toJson() => _$UploadModelToJson(this);
}
