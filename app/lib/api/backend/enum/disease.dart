import 'package:app/static/app_strings.dart';

enum Disease {
  atopicDermatitis(AppStrings.atopicDermatitis),
  psoriasis(AppStrings.psoriasis),
  acne(AppStrings.acne),
  vitiligo(AppStrings.vitiligo);

  final String name;

  const Disease(this.name);
}

// TODO: refactor diseases!!!