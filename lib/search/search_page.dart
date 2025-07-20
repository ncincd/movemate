import 'package:flutter/material.dart';
import 'package:movemate/constants/app_colors.dart';
import 'package:movemate/constants/app_text_styles.dart';
import 'package:movemate/animation_logic/slide_animation.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  List<Map<String, String>> _allSearchResults = [
    {
      'title': 'Summer linen jacket',
      'trackingNumber': '#NEJ20089934122231',
      'route': 'Barcelona → Paris',
    },
    {
      'title': 'Tapered-fit jeans AW',
      'trackingNumber': '#NEJ35870264978659',
      'route': 'Colombia → Paris',
    },
    {
      'title': 'Macbook pro M2',
      'trackingNumber': '#NE43857340857904',
      'route': 'Paris → Morocco',
    },
    {
      'title': 'Office setup desk',
      'trackingNumber': '#NEJ23481570754963',
      'route': 'France → German',
    },
  ];
  List<Map<String, String>> _filteredSearchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredSearchResults = _allSearchResults; // Initialize with all results
    _searchController.addListener(_filterSearchResults);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterSearchResults);
    _searchController.dispose();
    super.dispose();
  }

  void _filterSearchResults() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSearchResults = _allSearchResults.where((item) {
        return item['title']!.toLowerCase().contains(query) ||
            item['trackingNumber']!.toLowerCase().contains(query) ||
            item['route']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBackground, // Set background color for the entire page
      appBar: AppBar(
        backgroundColor: AppColors.appBarPurple,
        titleSpacing: 0, // Remove space between leading and title
        leading: IconButton(
          icon: Image.asset('assets/icons/left-arrow.png', color: Colors.white, height: 24, width: 24,), // Changed to custom back arrow icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 15.0), // Add padding to the right
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: '#NEJ200899',
                hintStyle: AppTextStyles.bodySecondary.copyWith(color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.search, color: AppColors.primary, size: 18),
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
      ),
      body: SlideFadeAnimation(
        offset: 100.0, // Large offset for full card animation
        delay: const Duration(milliseconds: 0), // Start immediately
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
            child: ListView.separated(
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                return SlideFadeAnimation(
                  offset: 50.0,
                  delay: Duration(milliseconds: index * 100), // Staggered delay
                  child: SearchCard(
                    title: _filteredSearchResults[index]['title']!,
                    trackingNumber: _filteredSearchResults[index]['trackingNumber']!,
                    route: _filteredSearchResults[index]['route']!,
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(height: 20, color: Colors.grey.withOpacity(0.1)), // Changed divider color
              itemCount: _filteredSearchResults.length, // Use filtered list length
              shrinkWrap: true, // Make ListView take only necessary height
            ),
          ),
        ),
      ),
    );
  }
}

class SearchCard extends StatelessWidget {
  final String title;
  final String trackingNumber;
  final String route;

  const SearchCard({
    Key? key,
    required this.title,
    required this.trackingNumber,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0), // Removed vertical padding
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.appBarPurple,
            child: Image.asset('assets/icons/box.png', height: 24, width: 24, color: Colors.white,),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  '$trackingNumber • $route',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 