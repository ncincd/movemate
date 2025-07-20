import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movemate/constants/app_colors.dart';
import 'package:movemate/constants/app_text_styles.dart';
import 'package:movemate/calculate/estimated_amount_page.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({super.key, this.onBack});
  final VoidCallback? onBack;

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  String _selectedPackaging = 'Box';
  Set<String> _selectedCategories = {}; // State variable for selected categories

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.appBarPurple,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarPurple,
        leading: IconButton(
          icon: Image.asset('assets/icons/left-arrow.png', color: Colors.white, height: 24, width: 24,), // Changed to custom back arrow icon
          onPressed: () {
            widget.onBack?.call(); // Call the provided callback
          },
        ),
        title: Text(
          'Calculate',
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Wrap the entire body content with SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Destination',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.titleText, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      _buildTextField(
                        hintText: 'Sender location',
                        prefixIcon: Icons.unarchive_outlined,
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        hintText: 'Receiver location',
                        prefixIcon: Icons.archive_outlined,
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        hintText: 'Approx weight',
                        prefixIcon: Icons.scale_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Packaging',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.titleText, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'What are you sending?',
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: () {
                  _showPackagingDropdown(context);
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/icons/move_box.jpeg', height: 24, width: 24,), // Use Image.asset
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 20,
                              child: VerticalDivider(color: Colors.grey.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _selectedPackaging,
                        style: AppTextStyles.bodySecondary.copyWith(color: AppColors.textPrimary),
                      ),
                      const Spacer(),
                      const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Categories',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.titleText, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'What are you sending?',
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  _buildCategoryChip('Documents', _selectedCategories.contains('Documents')),
                  _buildCategoryChip('Glass', _selectedCategories.contains('Glass')),
                  _buildCategoryChip('Liquid', _selectedCategories.contains('Liquid')),
                  _buildCategoryChip('Food', _selectedCategories.contains('Food')),
                  _buildCategoryChip('Electronic', _selectedCategories.contains('Electronic')),
                  _buildCategoryChip('Product', _selectedCategories.contains('Product')),
                  _buildCategoryChip('Others', _selectedCategories.contains('Others')),
                ],
              ),
            ),
            // Removed Spacer as SingleChildScrollView handles full content scrolling
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EstimatedAmountPage(
                        onBackToHome: widget.onBack, // Corrected parameter name
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8100),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Calculate',
                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String hintText, required IconData prefixIcon}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.bodySecondary.copyWith(color: AppColors.textSecondary),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(prefixIcon, color: AppColors.textSecondary, size: 20),
              const SizedBox(width: 10),
              SizedBox(
                height: 20,
                child: VerticalDivider(color: Colors.grey.withOpacity(0.5)),
              ),
            ],
          ),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _showPackagingDropdown(BuildContext context) {
    final List<String> options = ['Box', 'Documents', 'Other'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedPackaging = option;
                  });
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        option,
                        style: AppTextStyles.bodySecondary.copyWith(color: AppColors.textPrimary),
                      ),
                      const Spacer(),
                      if (_selectedPackaging == option)
                        const Icon(Icons.check, color: AppColors.primary, size: 20),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return RawChip(
      label: Text(label, style: isSelected ? AppTextStyles.caption.copyWith(color: Colors.white) : AppTextStyles.caption.copyWith(color: AppColors.textPrimary)),
      backgroundColor: isSelected ? AppColors.titleText : Colors.white,
      avatar: isSelected ? const Icon(Icons.check, color: Colors.white, size: 16) : null, // Tick icon when selected
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), // Changed to 6
        side: isSelected ? BorderSide.none : const BorderSide(color: Colors.grey, width: 0.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      onPressed: () {
        setState(() {
          if (_selectedCategories.contains(label)) {
            _selectedCategories.remove(label);
          } else {
            _selectedCategories.add(label);
          }
        });
      },
    );
  }
} 