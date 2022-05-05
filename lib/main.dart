import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_bfaf_submission/common/navigation.dart';
import 'package:dicoding_bfaf_submission/common/styles.dart';
import 'package:dicoding_bfaf_submission/data/model/restaurant.dart';
import 'package:dicoding_bfaf_submission/data/preference/preference_helper.dart';
import 'package:dicoding_bfaf_submission/provider/scheduling_provider.dart';
import 'package:dicoding_bfaf_submission/ui/detail_restaurant_page.dart';
import 'package:dicoding_bfaf_submission/ui/favorite_restaurant_page.dart';
import 'package:dicoding_bfaf_submission/ui/list_restaurant_page.dart';
import 'package:dicoding_bfaf_submission/ui/search_restaurant_page.dart';
import 'package:dicoding_bfaf_submission/ui/settings_page.dart';
import 'package:dicoding_bfaf_submission/utils/background_service.dart';
import 'package:dicoding_bfaf_submission/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  tz.initializeTimeZones();
  var timezoneLocation = tz.getLocation('Asia/Jakarta');
  tz.setLocalLocation(timezoneLocation);

  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SchedulingProvider(
        preferenceHelper: PreferenceHelper(
          sharedPreferences: SharedPreferences.getInstance(),
        ),
      ),
      child: MaterialApp(
        title: 'Restaurant',
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
        navigatorKey: navigatorKey,
        initialRoute: ListRestaurantPage.routeName,
        routes: {
          ListRestaurantPage.routeName: (context) => const ListRestaurantPage(),
          DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant),
          SearchRestaurant.routeName: (context) => const SearchRestaurant(),
          SettingsPage.routeName: (context) => const SettingsPage(),
          FavoriteRestaurantPage.routeName: (context) =>
              const FavoriteRestaurantPage(),
        },
      ),
    );
  }
}
