// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterUserReq _$RegisterUserReqFromJson(Map<String, dynamic> json) =>
    RegisterUserReq(
      (json['years'] as num).toInt(),
      $enumDecode(_$GenderEnumMap, json['gender']),
      $enumDecode(_$SkinTypeEnumMap, json['skinType']),
      (json['diseases'] as List<dynamic>)
          .map((e) => $enumDecode(_$DiseaseEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$RegisterUserReqToJson(RegisterUserReq instance) =>
    <String, dynamic>{
      'years': instance.years,
      'gender': _$GenderEnumMap[instance.gender]!,
      'skinType': _$SkinTypeEnumMap[instance.skinType]!,
      'diseases': instance.diseases.map((e) => _$DiseaseEnumMap[e]!).toList(),
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};

const _$SkinTypeEnumMap = {
  SkinType.type1: 'type1',
  SkinType.type2: 'type2',
  SkinType.type3: 'type3',
  SkinType.type4: 'type4',
  SkinType.type5: 'type5',
  SkinType.type6: 'type6',
};

const _$DiseaseEnumMap = {
  Disease.atopicDermatitis: 'atopicDermatitis',
  Disease.psoriasis: 'psoriasis',
  Disease.acne: 'acne',
  Disease.vitiligo: 'vitiligo',
  Disease.rosacea: 'rosacea',
  Disease.eczema: 'eczema',
  Disease.lupus: 'lupus',
  Disease.melasma: 'melasma',
};
