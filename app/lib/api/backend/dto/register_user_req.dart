import 'package:app/api/backend/enum/disease.dart';
import 'package:app/api/backend/enum/gender.dart';
import 'package:app/api/backend/enum/skin_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_user_req.g.dart';

@JsonSerializable()
class RegisterUserReq {
  final int years;
  final Gender gender;
  final SkinType skinType;
  final List<Disease> diseases;

  RegisterUserReq(
    this.years,
    this.gender,
    this.skinType,
    this.diseases,
  );

  factory RegisterUserReq.fromJson(Map<String, dynamic> json) => _$RegisterUserReqFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserReqToJson(this);
}
