import 'package:flutter/material.dart';

class SpecificationSection extends StatelessWidget {
  const SpecificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final specs = {
      'Model': 'Toyota Camry 2023',
      'Make': 'Toyota',
      'Body Type': 'Sedan',
      'Engine': '2.5L 4-cylinder Dynamic Force',
      'Horsepower': '203 HP @ 6600 rpm',
      'Torque': '184 lb-ft @ 5000 rpm',
      'Transmission': '8-speed automatic',
      'Drivetrain': 'Front-Wheel Drive (FWD)',
      'Fuel Economy': '28 city / 39 highway MPG',
      'Fuel Type': 'Regular Unleaded',
      'Seating Capacity': '5',
      'Cargo Volume': '15.1 cu ft',
      'Infotainment': '8" Touchscreen, Apple CarPlay, Android Auto',
      'Safety Features': 'Toyota Safety Sense 2.5+ (Pre-Collision, Lane Departure, etc.)',
      'Warranty': '3 years/36,000 miles basic, 5 years/60,000 miles powertrain',
      'Dimensions': '192.7" L x 72.4" W x 56.9" H',
      'Weight': '3,310 lbs',
      '0-60 mph': '7.9 seconds',
      'Top Speed': '135 mph (electronically limited)',
      'Colors Available': 'Midnight Black, Celestial Silver, Ruby Flare Pearl',
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: specs.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    '${entry.key}:',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    entry.value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}