import 'dart:math';

import 'package:ryd4ride/constants/libraries/app_libraries.dart';

class FavouriteEventsController extends GetxController {
  bool isLoading = true;

  var locations = [
    {
      "title": "9023 Whilshire",
      "subtitle": "Beverly Hills, 90211",
      "distance": "2.3km",
      "time": "10:30AM - 12:30PM",
      "crowd": "1000+ "
    },
    {
      "title": "9023 Whilshire",
      "subtitle": "Beverly Hills, 90211",
      "distance": "2.3km",
      "time": "10:30 AM - 12:30 PM",
      "crowd": "1000+ "
    },
    {
      "title": "9023 Whilshire",
      "subtitle": "Beverly Hills, 90211",
      "distance": "2.3km",
      "time": "10:30 AM - 12:30 PM",
      "crowd": "1000+ "
    },

  ].obs;
  var newlocation=[
    {
      "name": "Washington Wizards vs. Los Angeles Lakers",
      "date": "2025-01-30",
      "time": "07:00 PM",
      "distance": "2.3km",
      "location": "Capital One Arena, Washington, DC",
      "lat": 38.8981,
      "lng": -77.0209,
      "crowd": Random().nextInt(1300 - 100 + 1) + 100, // Random crowd size
    },
    {
      "name": "Washington Nationals vs. Los Angeles Dodgers",
      "date": "2025-04-07",
      "time": "06:45 PM",
      "location": "Nationals Park, Washington, DC",
      "lat": 38.873,
      "lng": -77.0075,
      "distance": "2.3km",
      "crowd": Random().nextInt(1300 - 100 + 1) + 100, // Random crowd size
    },
    {
      "name": "Washington Wizards vs. San Antonio Spurs",
      "date": "2025-02-10",
      "time": "07:00 PM",
      "distance": "2.3km",
      "location": "Capital One Arena, Washington, DC",
      "lat": 38.8981,
      "lng": -77.0209,
      "crowd":Random().nextInt(1300 - 100 + 1) + 100, // Random crowd size
    },
  ];
  @override
  void onReady() {
    isLoading = false;
    update();
    super.onReady();
  }
}
