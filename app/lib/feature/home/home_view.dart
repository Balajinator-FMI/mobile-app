import 'package:app/feature/home/home_view_model.dart';
import 'package:app/feature/home/views/advice_view.dart';
import 'package:app/feature/home/views/forecast_view.dart';
import 'package:app/feature/home/views/uv_card_view.dart';
import 'package:app/feature/home/views/uv_time_bar_chart_view.dart';
import 'package:app/static/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
        floatingActionButton: buildSpeedDial(),
      ),
    );
  }

  Widget _buildBody(HomeViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UvCardView(
            uvData: viewModel.locationData.currentUvData,
            reccOutdoorTime: viewModel.locationData.recOutdoor,
            factor: viewModel.locationData.factor,
          ),
          const SizedBox(height: 16),
          AdviceView(advice: viewModel.locationData.advice),
          const SizedBox(height: 16),
          Text(
            'Forecast',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ForecastView(forecast: viewModel.locationData.forecast),
          const SizedBox(height: 16),
          Text(
            'Outdoor Time',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          UVTimeBarChartView(outdoorTimes: viewModel.getOutdoorTimes()),
        ],
      ),
    );
  }

  Widget buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 28.0),
      backgroundColor: AppStyle.contrastColor1,
      foregroundColor: Colors.white,
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child: Icon(Icons.search, color: Colors.white),
          backgroundColor: AppStyle.contrastColor1,
          onTap: () => _viewModel.navigateToSearch(),
          label: 'Search',
          labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
        SpeedDialChild(
          child: Icon(Icons.chat, color: Colors.white),
          backgroundColor: AppStyle.contrastColor1,
          onTap: () => _viewModel.navigateToChat(),
          label: 'Diagnostic',
          labelStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.black,
        ),
      ],
    );
  }
}
