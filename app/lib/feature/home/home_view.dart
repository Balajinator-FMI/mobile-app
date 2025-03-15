import 'package:app/feature/home/home_view_model.dart';
import 'package:app/feature/home/views/advice_view.dart';
import 'package:app/feature/home/views/forecast_view.dart';
import 'package:app/feature/home/views/uv_card_view.dart';
import 'package:app/feature/home/views/uv_time_bar_chart_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final _viewModel = HomeViewModel();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Consumer<HomeViewModel>(
              builder: (context, viewModel, child) {
                return viewModel.isLoading ? Center(child: CircularProgressIndicator()) : _buildBody(viewModel);
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildBody(HomeViewModel viewModel) {
  return SingleChildScrollView(
    child: Column(
      children: [
        UvCardView(
          uvData: viewModel.locationData.current,
          reccOutdoorTime: viewModel.locationData.reccOutdoorTime,
          factor: viewModel.locationData.factor,
        ),
        const SizedBox(height: 16),
        AdviceView(advice: viewModel.locationData.advice),
        const SizedBox(height: 16),
        ForecastView(forecast: viewModel.locationData.forecast),
        const SizedBox(height: 16),
        UVTimeBarChartView(outdoorTimes: viewModel.getOutdoorTimes()),
      ],
    ),
  );
}
