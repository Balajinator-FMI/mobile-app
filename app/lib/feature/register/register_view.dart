import 'package:app/api/backend/enum/disease.dart';
import 'package:app/api/backend/enum/gender.dart';
import 'package:app/api/backend/enum/skin_type.dart';
import 'package:app/feature/register/register_view_model.dart';
import 'package:app/feature/register/views/primary_button_view.dart';
import 'package:app/static/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  final _viewModel = RegisterViewModel();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Consumer<RegisterViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  children: [
                    Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gender Selection
                          Text("Gender", style: TextStyle(fontSize: 16)),
                          Row(
                            children: [
                              Radio<Gender>(
                                value: Gender.male,
                                groupValue: viewModel.gender,
                                onChanged: viewModel.setGender,
                              ),
                              Text("Male"),
                              SizedBox(width: 20),
                              Radio<Gender>(
                                value: Gender.female,
                                groupValue: viewModel.gender,
                                onChanged: viewModel.setGender,
                              ),
                              Text("Female"),
                            ],
                          ),
                          SizedBox(height: 10),
                    
                          // Age Input
                          Text("Age", style: TextStyle(fontSize: 16)),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter your age",
                            ),
                            onChanged: viewModel.setYears,
                            validator: (_) => viewModel.ageErrorMessage,
                          ),
                          SizedBox(height: 10),
                    
                          // Skin Type Selection
                          Text("Skin Type", style: TextStyle(fontSize: 16)),
                          DropdownButtonFormField<SkinType>(
                            value: viewModel.skinType,
                            onChanged: viewModel.setSkinType,
                            items: SkinType.values.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type.toString().split('.').last),
                              );
                            }).toList(),
                            decoration: InputDecoration(border: OutlineInputBorder()),
                          ),
                          SizedBox(height: 10),
                    
                          // Diseases Selection
                          Text("Diseases", style: TextStyle(fontSize: 16)),
                          Column(
                            children: Disease.values.map((disease) {
                              return CheckboxListTile(
                                title: Text(disease.toString().split('.').last),
                                value: viewModel.diseases.contains(disease),
                                onChanged: (checked) => viewModel.toggleDisease(disease, checked),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    PrimaryButton(
                      isDisabled: !viewModel.isButtonEnabled,
                      text: AppStrings.register,
                      onPressed: () async => await _viewModel.register(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
