import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Películas',
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => const HomeScreen(),
          'details': (BuildContext context) => const DetailsScreen(),
        },
        theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            color: Colors.pink,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            toolbarTextStyle: const TextTheme(
              headline6: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ).bodyText2,
            titleTextStyle: const TextTheme(
              headline6: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ).headline6,
          ),
        ));
  }
}
