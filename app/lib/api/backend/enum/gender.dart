import 'package:app/static/app_strings.dart';

enum Gender {
  male(AppStrings.male),
  female(AppStrings.female);

  final String name;
  
  const Gender(this.name);
}
