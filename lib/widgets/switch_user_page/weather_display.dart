import 'package:ems_app/blocs/weather/weather_bloc.dart';
import 'package:ems_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDisplay extends StatefulWidget {
  const WeatherDisplay({Key? key}) : super(key: key);

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  @override
  void initState() {
    _getWeather();
    super.initState();
  }

  void _getWeather() {
    context.read<WeatherBloc>().add(GetWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state.weatherStatus == WeatherStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Current Temp',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: darkBlueText,
                      ),
                    ),
                    Text(
                      state.weather.temp.toString() + ' °C',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: darkBlueText,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.network(
                      state.weather.icon,
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      state.weather.description,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: darkBlueText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'Max. Temp. : ' + state.weather.tempMax.toString() + ' °C',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkBlueText,
              ),
            ),
            Text(
              'Min. Temp. : ' + state.weather.tempMin.toString() + ' °C',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkBlueText,
              ),
            ),
            Text(
              state.weather.name + ', ' + state.weather.country,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkBlueText,
              ),
            ),
          ],
        );
      },
    );
  }
}
