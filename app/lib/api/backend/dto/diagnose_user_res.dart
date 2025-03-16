import 'package:json_annotation/json_annotation.dart';

part 'diagnose_user_res.g.dart';

@JsonSerializable()
class DiagnoseUserRes {
  @JsonKey(name: 'Actinic Keratosis')
  final String actinicKeratosis;

  @JsonKey(name: 'Basal Cell Carcinoma')
  final String basalCellCarcinoma;

  @JsonKey(name: 'Dermatofibroma')
  final String dermatofibroma;

  @JsonKey(name: 'Melanoma')
  final String melanoma;

  @JsonKey(name: 'Nevus')
  final String nevus;

  @JsonKey(name: 'Pigmented Benign Keratosis')
  final String pigmentedBenignKeratosis;

  @JsonKey(name: 'Seborrheic Keratosis')
  final String seborrheicKeratosis;

  @JsonKey(name: 'Squamous Cell Carcinoma')
  final String squamousCellCarcinoma;

  @JsonKey(name: 'Vascular Lesion')
  final String vascularLesion;

  @JsonKey(name: 'predicted_class')
  final String predictedClass;

  DiagnoseUserRes({
    required this.actinicKeratosis,
    required this.basalCellCarcinoma,
    required this.dermatofibroma,
    required this.melanoma,
    required this.nevus,
    required this.pigmentedBenignKeratosis,
    required this.seborrheicKeratosis,
    required this.squamousCellCarcinoma,
    required this.vascularLesion,
    required this.predictedClass,
  });

  String getProbability(String disease) {
    switch (disease) {
      case 'Actinic Keratosis':
        return actinicKeratosis;
      case 'Basal Cell Carcinoma':
        return basalCellCarcinoma;
      case 'Dermatofibroma':
        return dermatofibroma;
      case 'Melanoma':
        return melanoma;
      case 'Nevus':
        return nevus;
      case 'Pigmented Benign Keratosis':
        return pigmentedBenignKeratosis;
      case 'Seborrheic Keratosis':
        return seborrheicKeratosis;
      case 'Squamous Cell Carcinoma':
        return squamousCellCarcinoma;
      case 'Vascular Lesion':
        return vascularLesion;
      default:
        return '0.0';
    }
  }

  static double parsePercentage(String? value) {
    if (value == null) return 0.0;
    return double.tryParse(value.replaceAll('%', '')) ?? 0.0;
  }

  factory DiagnoseUserRes.fromJson(Map<String, dynamic> json) => _$DiagnoseUserResFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnoseUserResToJson(this);
}
