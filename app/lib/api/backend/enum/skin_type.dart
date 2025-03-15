import 'package:app/static/app_strings.dart';

enum SkinType {
  type1(AppStrings.skinType1, AppStrings.skinType1Description),
  type2(AppStrings.skinType2, AppStrings.skinType2Description),
  type3(AppStrings.skinType3, AppStrings.skinType3Description),
  type4(AppStrings.skinType4, AppStrings.skinType4Description),
  type5(AppStrings.skinType5, AppStrings.skinType5Description),
  type6(AppStrings.skinType6, AppStrings.skinType6Description);

  final String name;
  final String description;

  const SkinType(this.name, this.description);
}
