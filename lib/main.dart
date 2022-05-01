import 'package:dicoding_bfaf_submission/detail_restaurant.dart';
import 'package:dicoding_bfaf_submission/list_restaurant.dart';
import 'package:dicoding_bfaf_submission/restaurant.dart';
import 'package:dicoding_bfaf_submission/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: myTextTheme,
        appBarTheme: const AppBarTheme(elevation: 0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: secondaryColor,
            onPrimary: Colors.white,
            textStyle: const TextStyle(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
      ),
      initialRoute: ListRestaurantPage.routeName,
      routes: {
        ListRestaurantPage.routeName: (context) => const ListRestaurantPage(),
        DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant),
      },
      // home: const MyHomePage(
      //   title: 'Test Page',
      // ),
    );
  }
}
