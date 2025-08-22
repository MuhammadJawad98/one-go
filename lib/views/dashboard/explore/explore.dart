import 'package:car_wash_app/views/dashboard/home/widgets/popular_service_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../models/car_model.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text_field.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  GoogleMapController? _mapController;
  Location location = Location();
  LatLng _currentLocation = const LatLng(37.7749, -122.4194); // Default
  String? _mapStyle;
  BitmapDescriptor? _customCurrentLocIcon;
  BitmapDescriptor? _customLocIcon;
  Set<Marker> _allMarkers = {};

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _loadCustomIcon();
    _getCurrentLocation();
  }

  Future<void> _loadCustomIcon() async {
    _customCurrentLocIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      AppAssets.currentLocation,
    );
    _customLocIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(25, 25)),
      AppAssets.point,
    );
  }

  void _loadMapStyle() async {
    _mapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString(AppAssets.mapStyle);
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        debugPrint("GPS service not enabled.");
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted &&
          permissionGranted != PermissionStatus.grantedLimited) {
        debugPrint("Location permission denied.");
        return;
      }
    } else if (permissionGranted == PermissionStatus.deniedForever) {
      debugPrint("Location permission permanently denied.");
      return;
    }

    try {
      if (!mounted) return;

      final locData = kDebugMode
          ? LocationData.fromMap({"latitude": 37.7749, "longitude": -122.4194})
          : await location.getLocation();

      final LatLng newLocation = LatLng(locData.latitude!, locData.longitude!);

      setState(() {
        _currentLocation = newLocation;
        _allMarkers.clear();

        // Add current location marker
        _allMarkers.add(
          Marker(
            markerId: const MarkerId("current_location"),
            position: _currentLocation,
            icon: _customCurrentLocIcon ?? BitmapDescriptor.defaultMarker,
          ),
        );

        // Add nearby default markers
        final nearbyOffsets = [
          const Offset(0.001, 0.001),
          const Offset(-0.0015, 0.0005),
          const Offset(0.0012, -0.0012),
          const Offset(-0.001, -0.001),
          const Offset(0.0007, 0.0013),
        ];

        for (int i = 0; i < nearbyOffsets.length; i++) {
          final offset = nearbyOffsets[i];
          _allMarkers.add(
            Marker(
              markerId: MarkerId("nearby_marker_$i"),
              position: LatLng(
                _currentLocation.latitude + offset.dy,
                _currentLocation.longitude + offset.dx,
              ),
              icon:
                  _customLocIcon ??
                  BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen,
                  ),
            ),
          );
        }
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentLocation, 15),
      );
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentLocation,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: _allMarkers,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            style: _mapStyle,
          ),

          /// Search Bar
          Positioned(
            top: 0,
            left: 24,
            right: 24,
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: RoundedTextField(
                        bgColor: AppColors.whiteColor,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.asset(AppAssets.search, width: 24),
                        ),
                        hintText: 'Search',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 55,
                    height: 55,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.whiteColor,
                    ),
                    child: Image.asset(AppAssets.filter),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 15,
            left: 24,
            right: 0,
            child: SafeArea(
              child: SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 237,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.greyColor,width: 0.5),
                        color: AppColors.whiteColor,
                      ),
                      child: PopularServiceWidget(obj: CarsModel(id: 'id', title: 'title', image: 'image', price: 0))
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 12);
                  },
                  itemCount: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
