import 'package:app/api/backend/dto/register_user_req.dart';
import 'package:app/api/backend/enum/disease.dart';
import 'package:app/api/backend/enum/gender.dart';
import 'package:app/api/backend/enum/skin_type.dart';
import 'package:app/api/backend/user_repository.dart';
import 'package:app/static/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends ChangeNotifier {
  bool _isButtonEnabled = false;
  int? _years;
  Gender? _gender;
  SkinType? _skinType;
  final List<Disease> _diseases = [];
  final formKey = GlobalKey<FormState>();
  final _userRepository = DependencyInjection.getIt<UserRepository>();
  final _navigationService = DependencyInjection.getIt<NavigationService>();

  Future<void> register() async {
    if (!_areAllFieldsValid()) return;

    final registerDto = RegisterUserReq(_years!, _gender!, _skinType!, diseases);
    try {
      toggleButton(false);
      await _userRepository.registerUser(registerDto);
      _navigationService.clearStackAndShow('home');
    } catch (e) {
      toggleButton(true);
      print(e);
      _navigationService.navigateTo('home'); // TODO: remove this line
    }
  }

  bool _areAllFieldsValid() {
    return _gender != null &&
        _years != null &&
        _validateYears(_years) == null &&
        _skinType != null &&
        _diseases.isNotEmpty;
  }

  void _validateForm() {
    _isButtonEnabled = _areAllFieldsValid();
    notifyListeners();
  }

  String? _validateYears(int? years) {
    if (years == null) return 'Age is required';
    if (years < 0) return 'Invalid age';
    return null;
  }

  void setGender(Gender? selectedGender) {
    _gender = selectedGender;
    _validateForm();
  }

  void setYears(String value) {
    _years = int.tryParse(value);
    _validateForm();
  }

  void setSkinType(SkinType? selectedType) {
    _skinType = selectedType;
    _validateForm();
  }

  void toggleDisease(Disease disease, bool? checked) {
    if (checked == true) {
      _diseases.add(disease);
    } else {
      _diseases.remove(disease);
    }
    _validateForm();
  }

  void toggleButton(bool isEnabled) {
    _isButtonEnabled = isEnabled;
    notifyListeners();
  }

  Gender? get gender => _gender;
  int? get years => _years;
  SkinType? get skinType => _skinType;
  List<Disease> get diseases => _diseases;
  String? get ageErrorMessage => _validateYears(_years);
  bool get isButtonEnabled => _isButtonEnabled;
}
