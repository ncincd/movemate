import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movemate/constants/app_colors.dart';
import 'package:movemate/constants/app_text_styles.dart';
import 'package:movemate/animation_logic/slide_animation.dart';
import 'package:movemate/animation_logic/right_slide_in_animation.dart'; // Import the new animation
import 'package:movemate/search/search_page.dart'; // Added import for SearchPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.appBarPurple, // Use AppColors.appBarPurple
        statusBarIconBrightness: Brightness.light, // Light icons for dark background
        statusBarBrightness: Brightness.light, // For iOS
      ),
      child: Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: AppColors.appBarPurple,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/profile_image.png'), // Replace with actual asset
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Transform.rotate(
                                angle: -1.3, // Adjusted for more slant towards the top-right
                                child: const Icon(Icons.send, color: Colors.white70, size: 12),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Your location',
                                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Wertheimer, Illinois',
                                style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                              ),
                              const Icon(Icons.arrow_drop_down, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
                          onPressed: () {
                            // Handle notification tap
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
                      },
                      child: AbsorbPointer( // Prevents the TextField from being interactive directly
                        child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter the receipt number ...',
                      hintStyle: AppTextStyles.bodySecondary.copyWith(color: AppColors.textSecondary),
                      prefixIcon: const Icon(Icons.search, color: AppColors.primary, size: 18),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF8100),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
                            ),
                          ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tracking',
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.titleText, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shipment Number',
                                style: AppTextStyles.bodySecondary,
                              ),
                              Image.asset(
                                'assets/icons/delivery-truck.png', // Replace with actual asset
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            'NEJ20089934122231',
                            style: AppTextStyles.caption.copyWith(color: AppColors.titleText,fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.lightPink,
                                child: Image.asset('assets/icons/send.png', height: 15, width: 15,)
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sender',
                                    style: AppTextStyles.caption,
                                  ),
                                  Text(
                                    'Atlanta, 5243',
                                    style: AppTextStyles.caption.copyWith(color: AppColors.titleText,fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Time',
                                    style: AppTextStyles.caption,
                                  ),
                                  Text(
                                    '• 2 day -3 days',
                                    style: AppTextStyles.caption.copyWith(color: Colors.green, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 20, color: Colors.grey.withOpacity(0.1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.lightGreen,
                                child: Image.asset('assets/icons/receive.png', height: 15, width: 15,)
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Receiver',
                                    style: AppTextStyles.caption,
                                  ),
                                  Text(
                                    'Chicago, 6342',
                                    style: AppTextStyles.caption.copyWith(color: AppColors.titleText,fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Status',
                                    style: AppTextStyles.caption,
                                  ),
                                  Text(
                                    'Waiting to collect',
                                    style: AppTextStyles.caption.copyWith(color: AppColors.titleText,fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Divider(height: 20, color: Colors.grey.withOpacity(0.1)),
                        Center(
                          child: TextButton.icon(
                            onPressed: () {
                              // Handle Add Stop
                            },
                            icon: const Icon(Icons.add, color: const Color(0xFFFF8100), size: 18),
                            label: Text(
                              'Add Stop',
                              style: AppTextStyles.caption.copyWith(color: const Color(0xFFFF8100), fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Available Vehicles',
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.titleText, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 150, // Adjust height as needed
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildVehicleCard(
                          'Ocean freight',
                          'International',
                            'assets/icons/ocean.png',
                        ),
                        _buildVehicleCard(
                          'Cargo freight',
                          'Reliable',
                            'assets/icons/cargo.png',
                        ),
                        _buildVehicleCard(
                          'Air freight',
                          'International',
                            'assets/icons/airplane.png',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(String title, String subtitle, String imagePath) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: AppTextStyles.caption,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: RightSlideInAnimation( // Changed to RightSlideInAnimation
              offset: 50.0,
              delay: Duration.zero,
              child: SizedBox(
                width: 80, // Adjust this width for the desired cutoff
                height: 80, // Same as image height
                child: ClipRect(
            child: Image.asset(
              imagePath,
              height: 80,
              width: 80,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 