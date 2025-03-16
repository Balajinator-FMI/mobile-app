import 'package:app/api/backend/enum/disease.dart';
import 'package:app/api/backend/enum/gender.dart';
import 'package:app/api/backend/enum/skin_type.dart';
import 'package:app/feature/register/register_view_model.dart';
import 'package:app/feature/register/views/primary_button_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../static/app_style.dart';

class RegisterView extends StatelessWidget {
  final RegisterViewModel _viewModel = RegisterViewModel();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        backgroundColor: AppStyle.bgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Consumer<RegisterViewModel>(
              builder: (context, viewModel, child) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          color: AppStyle.textColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildSectionTitle('Gender'),
                      Row(
                        children: [
                          _buildRadioOption(viewModel, Gender.male, "Male"),
                          const SizedBox(width: 20),
                          _buildRadioOption(viewModel, Gender.female, "Female"),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSectionTitle('Age'),
                      const SizedBox(height: 10),
                      _buildTextField(
                        controller: viewModel.ageController,
                        hintText: 'Enter your age',
                        inputType: TextInputType.number,
                        onChanged: viewModel.setYears,
                        validator: (_) => viewModel.ageErrorMessage,
                      ),
                      const SizedBox(height: 16),
                      _buildSectionTitle('Skin Type'),
                      const SizedBox(height: 10),
                      _buildCards(viewModel),
                      const SizedBox(height: 16),
                      _buildSectionTitle('Diseases'),
                      _buildDiseasesSelection(viewModel),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        isDisabled: !viewModel.isButtonEnabled,
                        text: 'Register',
                        bgColor: AppStyle.contrastColor1,
                        onPressed: () async => await viewModel.register(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppStyle.textColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildRadioOption(RegisterViewModel viewModel, Gender value, String label) {
    return Row(
      children: [
        Radio<Gender>(
          value: value,
          groupValue: viewModel.gender,
          onChanged: viewModel.setGender,
          activeColor: AppStyle.contrastColor1,
        ),
        Text(
          label,
          style: const TextStyle(color: AppStyle.textColor),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType inputType,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      style: const TextStyle(color: AppStyle.textColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppStyle.textColorWith05Opacity),
        filled: true,
        fillColor: AppStyle.secondaryColor2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildCards(RegisterViewModel viewModel) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: SkinType.values.length,
        itemBuilder: (context, index) {
          bool isSelected = (SkinType.values[index].name == viewModel.skinType?.name);
          return GestureDetector(
            onTap: () {
              viewModel.setSkinType(SkinType.values[index]);
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppStyle.contrastColor1 : AppStyle.secondaryColor1,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppStyle.skinColors[index],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    SkinType.values[index].name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : AppStyle.textColorWith07Opacity,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDiseasesSelection(RegisterViewModel viewModel) {
    return Column(
      children: Disease.values.map((disease) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: AppStyle.secondaryColor1,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CheckboxListTile(
            title: Text(
              disease.name,
              style: const TextStyle(color: AppStyle.textColor),
            ),
            value: viewModel.diseases.contains(disease),
            onChanged: (checked) => viewModel.toggleDisease(disease, checked),
            activeColor: AppStyle.contrastColor1,
            checkColor: Colors.white,
            tileColor: AppStyle.secondaryColor1,
          ),
        );
      }).toList(),
    );
  }
}
