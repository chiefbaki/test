import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/bloc/weather_bloc.dart';
import 'package:test_flutter/bloc/weather_event.dart';
import 'package:test_flutter/bloc/weather_state.dart';
import 'package:test_flutter/provider/theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    if (_counter == 9) {
      isVisible = !isVisible;
      isVisible1 = !isVisible1;
    }
    setState(() {
      _counter++;
    });
  }

  void decrementCounter() {
    if (_counter == 10) {
      isVisible = !isVisible;
    } else if (_counter == 1) {
      isVisible1 = !isVisible1;
    }

    if (minusTwo == true) {
      setState(() {
        _counter -= 2;
      });
    } else {
      setState(() {
          _counter--;
        });
    }
  }

  late bool minusTwo;

  bool isVisible = true;
  bool isVisible1 = false;

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ThemeChange>(context);

    minusTwo = vm.isDark;

    Future<Position> getPosition() async {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error("Location service is disabled");
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error("Location permissions are denied");
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error("Location permission are permanently denied");
      }
      return Geolocator.getCurrentPosition();
    }

    Future<void> _openMap(String lat, String long) async {
      String googleUrl =
          "https://www.google.com/maps/search/?api=1&query=$lat,$long";
      await canLaunchUrlString(googleUrl)
          ? await launchUrlString(googleUrl)
          : throw "Coulnt find $googleUrl";
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WeatherSuccess) {
                    return Column(
                      children: [
                        Text(
                          "Weather for ${state.model.name}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Min temp ${state.model.main?.tempMin.toString()}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      vm.changeTheme();
                      print(vm.isDark);
                    },
                    child: const Icon(Icons.web_asset),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      // _openMap("42.8746", "74.5698");
                      BlocProvider.of<WeatherBloc>(context).add(GetWeather());
                    },
                    child: const Icon(Icons.access_alarm),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: isVisible,
                  child: FloatingActionButton(
                    onPressed: _incrementCounter,
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: isVisible1,
                  child: FloatingActionButton(
                    onPressed: decrementCounter,
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                  ),
                ),
              ],
            ),
          ],
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
