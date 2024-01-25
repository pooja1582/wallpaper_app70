import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapp/bloc/wallpaper_bloc.dart';
import 'package:wallpaperapp/data/remote/api_helper.dart';
import 'package:wallpaperapp/screens/home_screen.dart';
import 'package:wallpaperapp/searched_bloc/wallpaper_searched_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => WallpaperBloc(apiHelper: ApiHelper()),
      ),
      BlocProvider(
        create: (context) => WallpaperSearchedBloc(apiHelper: ApiHelper()),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
