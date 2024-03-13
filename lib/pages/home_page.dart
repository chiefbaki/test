import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'package:test_flutter/bloc/weather_bloc.dart';
import 'package:test_flutter/bloc/weather_event.dart';
import 'package:test_flutter/bloc/weather_state.dart';
import 'package:test_flutter/data/weather_dto.dart';

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

  final int _max = 10;
  final int _min = 0;
  double? weather;
  String? city;
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ThemeChange>(context);

    BlocProvider.of<WeatherBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: BlocListener<WeatherBloc, WeatherState>(
            listener: (context, state) {
              if (state is WeatherLoading) {
                print("LOADING");
              } else if (state is WeatherSuccess) {
                print("SUCCESS");
                _counter = state.counter ?? 0;
                setState(() {});
                weather = state.model?.main?.temp ?? 0;
                city = state.model?.name ?? "";
              } else if (state is WeatherError) {
                print(state.error);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    city != null
                        ? Text(
                            "Weather for $city",
                            style: const TextStyle(fontSize: 20),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 20,
                    ),
                    city != null
                        ? Text(
                            "Min temp $weather",
                            style: const TextStyle(fontSize: 20),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  _counter.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                )
              ],
            ),
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
                _counter < _max
                    ? FloatingActionButton(
                        onPressed: () {
                          BlocProvider.of<WeatherBloc>(context)
                              .add(Increment(_counter, vm.isDark));
                        },
                        child: const Icon(Icons.add),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                _counter > _min
                    ? FloatingActionButton(
                        onPressed: () {
                          BlocProvider.of<WeatherBloc>(context)
                              .add(Decrement(_counter, vm.isDark));
                        },
                        child: const Icon(Icons.remove),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        )

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
