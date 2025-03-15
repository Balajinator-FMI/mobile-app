import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:location/location.dart';
import '../../api/google-maps/google_maps_api_service.dart';
import '../../api/google-maps/model/city_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final GoogleMapsApiService _googleMapsApiService = GoogleMapsApiService();
  final TextEditingController _controller = TextEditingController();
  final Location _location = Location();

  Future<List<CityModel>> _getCitySuggestions(String query) async {
    if (query.isEmpty) return [];

    try {
      LocationData currentLocation = await _location.getLocation();
      return await _googleMapsApiService.autocomplete(query, currentLocation);
    } catch (error) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('City Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TypeAheadField<CityModel>(
              builder: (context, controller, focusNode) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: 'Search for a city',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                  ),
                );
              },
              suggestionsCallback: _getCitySuggestions,
              itemBuilder: (context, CityModel city) {
                return ListTile(
                  title: Text(city.name),
                );
              },
              onSelected: (CityModel city) {
                _controller.text = city.name;
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('City Selected'),
                    content: Text('You selected: ${city.name}'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
