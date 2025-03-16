import 'package:app/feature/search/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../../api/google-maps/model/city_model.dart';
import '../../static/app_style.dart';
import '../home/views/advice_view.dart';
import '../home/views/forecast_view.dart';
import '../home/views/uv_card_view.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
      child: Consumer<SearchViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            // appBar: AppBar(title: const Text('City Search')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TypeAheadField<CityModel>(
                    builder: (context, controller, focusNode) {
                      model.controller = controller;
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Search for a city',
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          suffixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: AppStyle.secondaryColor1,
                        ),
                      );
                    },
                    suggestionsCallback: model.getCitySuggestions,
                    itemBuilder: (context, CityModel city) {
                      return ListTile(
                        title: Text(city.name),
                        textColor: Colors.white,
                        tileColor: AppStyle.secondaryColor2,
                      );
                    },
                    loadingBuilder: (context) {
                      return const ListTile(
                        title: Text('Searching...'),
                        textColor: Colors.white,
                        tileColor: AppStyle.secondaryColor2,
                      );
                    },
                    emptyBuilder: (context) {
                      return const ListTile(
                        title: Text('No results found'),
                        textColor: Colors.white,
                        tileColor: AppStyle.secondaryColor2,
                      );
                    },
                    onSelected: (CityModel city) {
                      model.selectCity(city);
                      model.controller.text = city.name;
                      FocusScope.of(context).unfocus();
                    },
                  ),

                  const SizedBox(height: 20),

                  if (model.selectedCity != null)
                    Expanded(child: _buildBody(model)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(SearchViewModel model) {
    return model.isLoading
      ? const Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
          child: Column(
            children: [
              UvCardView(
                uvData: model.locationData!.current,
                reccOutdoorTime: model.locationData!.reccOutdoorTime,
                factor: model.locationData!.factor,
              ),

              const SizedBox(height: 20),

              AdviceView(advice: model.locationData!.advice),

              const SizedBox(height: 20),

              ForecastView(forecast: model.locationData!.forecast),
            ]
          )
        );
  }
}
