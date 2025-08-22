import 'package:car_wash_app/utils/app_assets.dart';
import 'package:flutter/material.dart';
import '../../views/searched_items/widgets/filter_bottom_sheet.dart';
import '../../utils/app_colors.dart';
import '../../models/car_model.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_text.dart';
import 'widgets/car_cards_widget.dart';

class SearchedItemsScreen extends StatefulWidget {
  const SearchedItemsScreen({super.key});

  @override
  State<SearchedItemsScreen> createState() => _SearchedItemsScreenState();
}

class _SearchedItemsScreenState extends State<SearchedItemsScreen> {
  List<CarsModel> premiumCars = [
    CarsModel(
      id: '1',
      title: '2023 Porsche 911 Turbo S',
      image:
          'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-S-Main-Hero-Desktop-LHD.jpg',
      price: 207000,
      brand: 'Porsche',
      category: 'Sports Car',
      description:
          'The pinnacle of Porsche performance with 640hp twin-turbo flat-6 engine, 0-60mph in 2.6 seconds',
      averageRating: 4.9,
      reviewCount: 342,
      availableColors: ['GT Silver Metallic', 'Carmine Red', 'Jet Black'],
      discount: 5,
      isFeatured: true,
    ),
    CarsModel(
      id: '2',
      title: '2023 Mercedes-Benz S-Class S 580',
      image:
          'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-S-Main-Hero-Desktop-LHD.jpg',
      price: 118000,
      brand: 'Mercedes-Benz',
      category: 'Luxury Sedan',
      description:
          'The benchmark for luxury sedans with 496hp V8, rear-axle steering, and MBUX hyperscreen',
      averageRating: 4.8,
      reviewCount: 287,
      availableColors: ['Obsidian Black', 'Selenite Grey', 'Rubellite Red'],
    ),
    CarsModel(
      id: '3',
      title: '2023 Land Rover Range Rover SV',
      image:
          'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-S-Main-Hero-Desktop-LHD.jpg',
      price: 180000,
      brand: 'Land Rover',
      category: 'Luxury SUV',
      description:
          'Ultimate refinement with 523hp V8, executive rear seats, and premium leather interiors',
      averageRating: 4.7,
      reviewCount: 198,
      discount: 8,
      availableColors: ['Santorini Black', 'Lantau Bronze', 'Arctic White'],
    ),
    CarsModel(
      id: '4',
      title: '2023 Audi RS e-tron GT',
      image:
          'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-S-Main-Hero-Desktop-LHD.jpg',
      price: 142000,
      brand: 'Audi',
      category: 'Electric Performance',
      description:
          '637hp all-electric grand tourer with 238mi range and 0-60mph in 3.1 seconds',
      averageRating: 4.8,
      reviewCount: 231,
      availableColors: ['Tactical Green', 'Daytona Gray', 'Ultra Blue'],
      isFeatured: true,
    ),
    CarsModel(
      id: '5',
      title: '2023 BMW M5 Competition',
      image:
          'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-S-Main-Hero-Desktop-LHD.jpg',
      price: 112000,
      brand: 'BMW',
      category: 'Performance Sedan',
      description:
          '617hp twin-turbo V8 with M xDrive all-wheel drive and carbon ceramic brakes',
      averageRating: 4.7,
      reviewCount: 312,
      discount: 3,
      availableColors: [
        'Frozen Marina Bay Blue',
        'Black Sapphire',
        'Imola Red',
      ],
    ),
    CarsModel(
      id: '6',
      title: '2023 Tesla Model S Plaid',
      image:
          'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-S-Main-Hero-Desktop-LHD.jpg',
      price: 108000,
      brand: 'Tesla',
      category: 'Electric Sedan',
      description:
          '1020hp tri-motor AWD, 0-60mph in 1.99s, 396mi range, and yoke steering',
      averageRating: 4.6,
      reviewCount: 842,
      availableColors: ['Pearl White', 'Solid Black', 'Ultra Red'],
    ),
    CarsModel(
      id: '7',
      title: '2023 Lexus LC 500 Convertible',
      image:
          'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-S-Main-Hero-Desktop-LHD.jpg',
      price: 102000,
      brand: 'Lexus',
      category: 'Luxury Coupe',
      description:
          '471hp V8 with retractable hardtop and Mark Levinson premium audio',
      averageRating: 4.5,
      reviewCount: 176,
      discount: 6,
      availableColors: ['Nori Green', 'Infrared', 'Cadmium Orange'],
    ),
    CarsModel(
      id: '8',
      title: '2023 Aston Martin DBX',
      image:
          'https://digitalassets.tesla.com/tesla-contents/image/upload/f_auto,q_auto/Model-S-Main-Hero-Desktop-LHD.jpg',
      price: 195000,
      brand: 'Aston Martin',
      category: 'Luxury SUV',
      description:
          'Handcrafted British luxury with 697hp twin-turbo V8 and signature grille',
      averageRating: 4.7,
      reviewCount: 143,
      availableColors: [
        'Satin Titanium Silver',
        'Ultramarine Black',
        'Lime Essence',
      ],
    ),
  ];

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      builder: (context) {
        return FilterBottomSheetContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: AppColors.primaryColor,
      //   title: const Text('Search Cars'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.filter_alt),
      //       onPressed: _showFilterBottomSheet,
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SafeArea(
              top: true,
              bottom: false,
              child: Row(
                children: [
                  CustomImageButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: 'Searched Cars',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  CustomImageButton(
                    asset: AppAssets.filter,
                    onTap: () => _showFilterBottomSheet(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Results Count
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Default text color
                ),
                children: [
                  const TextSpan(
                    text: 'We found ',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: '4733',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: ' Cars available for you',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Car List
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                ),
                itemCount: premiumCars.length,
                itemBuilder: (context, index) {
                  return CarCard(obj: premiumCars[index]);
                },
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
