import 'package:app/static/app_strings.dart';

enum Disease {
  atopicDermatitis(AppStrings.atopicDermatitis),
  psoriasis(AppStrings.psoriasis),
  acne(AppStrings.acne),
  vitiligo(AppStrings.vitiligo),
  rosacea(AppStrings.rosacea),
  eczema(AppStrings.eczema),
  lupus(AppStrings.lupus),
  melasma(AppStrings.melasma);

  final String name;

  const Disease(this.name);
}

// TODO: refactor diseases!!!