import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movemate/constants/app_colors.dart';
import 'package:movemate/constants/app_text_styles.dart';

class EstimatedAmountPage extends StatefulWidget {
  const EstimatedAmountPage({super.key, this.onBackToHome});
  final VoidCallback? onBackToHome;

  @override
  State<EstimatedAmountPage> createState() => _EstimatedAmountPageState();
}

class _EstimatedAmountPageState extends State<EstimatedAmountPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _amountAnimation;

  final double _finalAmount = 1460.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.dashboardBackground,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Animation duration
    );

    _amountAnimation = Tween<double>(begin: 0.0, end: _finalAmount).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.dashboardBackground,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // MoveMate Logo (Assuming it's an asset or text)
              Image.asset(
                'assets/icons/move-logo.jpeg', // Placeholder for MoveMate logo - replace with actual if available
                height: 70,
              ), // Placeholder, replace with actual logo asset if available
              const SizedBox(height: 50),
              // Box Icon
              Image.asset(
                'assets/icons/move_box.jpeg', // Use the box icon from assets
                height: 150,
              ),
              const SizedBox(height: 50),
              Text(
                'Total Estimated Amount',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.titleText, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              AnimatedBuilder(
                animation: _amountAnimation,
                builder: (context, child) {
                  return RichText(
                    text: TextSpan(
                      text: ' \$${_amountAnimation.value.toInt()}', // Animate the amount
                      style: AppTextStyles.title.copyWith(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 28, height: 1.2),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' USD',
                          style: AppTextStyles.bodyMedium.copyWith(color: Colors.green),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  'This amount is estimated this will vary if you change your location or weight',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Pop EstimatedAmountPage
                    widget.onBackToHome?.call(); // Then call the callback to go back to home
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8100),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Back to home',
                    style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 