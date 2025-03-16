// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnose_user_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiagnoseUserRes _$DiagnoseUserResFromJson(Map<String, dynamic> json) =>
    DiagnoseUserRes(
      actinicKeratosis: json['Actinic Keratosis'] as String,
      basalCellCarcinoma: json['Basal Cell Carcinoma'] as String,
      dermatofibroma: json['Dermatofibroma'] as String,
      melanoma: json['Melanoma'] as String,
      nevus: json['Nevus'] as String,
      pigmentedBenignKeratosis: json['Pigmented Benign Keratosis'] as String,
      seborrheicKeratosis: json['Seborrheic Keratosis'] as String,
      squamousCellCarcinoma: json['Squamous Cell Carcinoma'] as String,
      vascularLesion: json['Vascular Lesion'] as String,
      predictedClass: json['predicted_class'] as String,
    );

Map<String, dynamic> _$DiagnoseUserResToJson(DiagnoseUserRes instance) =>
    <String, dynamic>{
      'Actinic Keratosis': instance.actinicKeratosis,
      'Basal Cell Carcinoma': instance.basalCellCarcinoma,
      'Dermatofibroma': instance.dermatofibroma,
      'Melanoma': instance.melanoma,
      'Nevus': instance.nevus,
      'Pigmented Benign Keratosis': instance.pigmentedBenignKeratosis,
      'Seborrheic Keratosis': instance.seborrheicKeratosis,
      'Squamous Cell Carcinoma': instance.squamousCellCarcinoma,
      'Vascular Lesion': instance.vascularLesion,
      'predicted_class': instance.predictedClass,
    };
