import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_peliculas/providers/movies_provider.dart';
import 'package:proyecto_peliculas/screens/screens.dart';

void main() => runApp(const Appstate());

class Appstate extends StatelessWidget {
  const Appstate({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_)=>MoviesProvider(),
        lazy: false,
        
        )
      ],
      child: MyApp(),
      
      );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "peliculas",
      initialRoute: "home",
      routes: {"home": (_) => HomeScreen(), "details": (_) => DetailsScreen()},
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white),
          color: Colors.indigo,
          elevation: 0
        )
      ),
    );
  }
}
