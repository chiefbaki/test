import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/bloc/weather_bloc.dart';
import 'package:test_flutter/pages/home_page.dart';
import 'package:test_flutter/provider/theme.dart';
import 'package:test_flutter/rep/settings.dart';
import 'package:test_flutter/rep/weather_rep.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) =>
              WeatherRep(dio: RepositoryProvider.of<DioSettings>(context).dio),
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            WeatherBloc(repository: RepositoryProvider.of<WeatherRep>(context)),
        child: ChangeNotifierProvider(
          create: (context) => ThemeChange(),
          child: Builder(builder: (context) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: context.watch<ThemeChange>().getCurrentTheme,
              home: const HomePage(title: 'Flutter Demo Home Page'),
            );
          }),
        ),
      ),
    );
  }
}
