import 'package:json_annotation/json_annotation.dart';

part 'register_user_res.g.dart';

@JsonSerializable()
class RegisterUserRes {
  final String userId;

  RegisterUserRes(this.userId);

  factory RegisterUserRes.fromJson(Map<String, dynamic> json) => _$RegisterUserResFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserResToJson(this);
}