// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:ryd4ride/constants/libraries/app_libraries.dart';
import 'package:ryd4ride/controller/setting/favourite_events_controller.dart';

import '../../controller/menu/maps_controller.dart';
import '../../routing/app_routes.dart';

class FavouriteEventsScreen extends StatelessWidget {
  const FavouriteEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 60, bottom: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () => Get.back(),
                    iconSize: 24,
                    splashRadius: 24,
                  ),
                  const Text(
                    "Favorite Events",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40), // Spacer for symmetry
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: GetBuilder<FavouriteEventsController>(
                  init: FavouriteEventsController(),
                  builder: (_) {
                    return AnimationLimiter(
                      child: ListView.separated(
                        itemCount: _.locations.length,
                        separatorBuilder: (context, index) => const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        itemBuilder: (context, index) {
                          var location = _.newlocation[index];
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 2000),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: BookmarkableCard(
                                  location: location,
                                  color:
                                      int.parse(location["crowd"].toString()) >
                                              1000
                                          ? Colors.green.shade200
                                          : int.parse(location["crowd"]
                                                      .toString()) >
                                                  500
                                              ? Colors.yellow.shade200
                                              : Colors.red.shade100,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookmarkableCard extends StatefulWidget {
  final Map<String, dynamic> location;
  final Color color;

  const BookmarkableCard({
    Key? key,
    required this.location,
    required this.color,
  }) : super(key: key);

  @override
  _BookmarkableCardState createState() => _BookmarkableCardState();
}

class _BookmarkableCardState extends State<BookmarkableCard> {
  bool isBookmarked = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: widget.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.location["name"]!.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked ? AppColors.primaryColor : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isBookmarked = !isBookmarked;
                    });
                  },
                ),
              ],
            ),
            Text(widget.location["location"]!),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoWidget(
                  icon: Icons.people,
                  text: widget.location["crowd"]!.toString(),
                ),
                InfoWidget(
                  icon: Icons.navigation,
                  text: widget.location["distance"]!,
                ),
                InfoWidget(
                  icon: Icons.access_time,
                  text: widget.location["time"]!,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: CommonButton(
                text: "venue end point",
                onPressed: () {
                  final mapcontroller = Get.find<MapsController>();
                  // mapcontroller.markers.clear();
                  // mapcontroller.markers.add(
                  //     Marker(
                  //       width: 80.0,
                  //       height: 80.0,
                  //       point: mapcontroller.currentPosition.value,
                  //       builder: (ctx) => GestureDetector(
                  //         onTap: () {
                  //           mapcontroller.selectedMarkerInfo.value = 'You are here!';
                  //         },
                  //         child: Image.asset("assets/images/car2.png",width: 40,height: 40,),
                  //       ),
                  //     )
                  // );
                  // mapcontroller.markers.add(
                  //     Marker(
                  //       width: 80.0,
                  //       height: 80.0,
                  //       point: LatLng(double.parse(widget.location["lat"].toString()), double.parse(widget.location["lng"].toString())),
                  //       builder: (ctx) => GestureDetector(
                  //         onTap: () {
                  //           mapcontroller.selectedMarkerInfo.value = 'You are here!';
                  //         },
                  //         child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
                  //       ),
                  //     )
                  // );
                  // mapcontroller.markerevents();
                  // mapcontroller.polylinePoints.clear();
                  // mapcontroller.polylinePoints.add(mapcontroller.currentPosition.value);
                  // mapcontroller.polylinePoints.add(LatLng(double.parse(widget.location["lat"].toString()), double.parse(widget.location["lng"].toString())));
                  Get.back();
                  Get.back();
                  if (AppRoutes.current == AppRoutes.events) {
                    Get.back();
                  }
                },
              ).marginOnly(top: 15),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoWidget({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primaryColor),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
              color: AppColors.blackButtoncolor, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
