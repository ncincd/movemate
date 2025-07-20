import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movemate/animation_logic/slide_animation.dart'; // Import the animation
import 'package:movemate/constants/app_colors.dart';
import 'package:movemate/constants/app_text_styles.dart';

enum ShipmentStatus {
  inProgress,
  pending,
  loading,
  completed,
  cancelled,
}

class Shipment {
  final ShipmentStatus status;
  final String title;
  final String trackingNumber;
  final String fromLocation;
  final double price;
  final String date;

  Shipment({
    required this.status,
    required this.title,
    required this.trackingNumber,
    required this.fromLocation,
    required this.price,
    required this.date,
  });
}

class ShipmentPage extends StatefulWidget {
  const ShipmentPage({super.key, this.onBack});
  final VoidCallback? onBack;

  @override
  State<ShipmentPage> createState() => _ShipmentPageState();
}

class _ShipmentPageState extends State<ShipmentPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Completed', 'In progress', 'Pending Order', 'Cancelled']; // Changed Pending and added Cancelled
  final Map<String, int> _tabCounts = {
    'All': 12,
    'Completed': 5,
    'In progress': 3,
    'Pending Order': 4, // Updated count for Pending Order
    'Cancelled': 2, // Example count for Cancelled
  };
  int _currentIndex = 0; // New state variable for current tab index

  final List<Shipment> _shipments = [
    Shipment(
      status: ShipmentStatus.inProgress,
      title: 'Arriving today!',
      trackingNumber: '#NEJ20089934122231',
      fromLocation: 'Atlanta',
      price: 1400,
      date: 'Sep 20,2023',
    ),
    Shipment(
      status: ShipmentStatus.inProgress,
      title: 'In transit',
      trackingNumber: '#TRN9876543210987',
      fromLocation: 'Dallas',
      price: 800,
      date: 'Sep 28,2023',
    ),
    Shipment(
      status: ShipmentStatus.inProgress,
      title: 'Out for delivery',
      trackingNumber: '#DEL1234567890123',
      fromLocation: 'Seattle',
      price: 600,
      date: 'Sep 29,2023',
    ),
    Shipment(
      status: ShipmentStatus.pending,
      title: 'Pending shipment',
      trackingNumber: '#ABC1234567890123',
      fromLocation: 'New York',
      price: 500,
      date: 'Oct 1,2023',
    ),
    Shipment(
      status: ShipmentStatus.loading,
      title: 'Loading shipment',
      trackingNumber: '#XYZ9876543210987',
      fromLocation: 'Los Angeles',
      price: 750,
      date: 'Sep 25,2023',
    ),
    Shipment(
      status: ShipmentStatus.completed,
      title: 'Delivered successfully!',
      trackingNumber: '#DEF4567890123456',
      fromLocation: 'Chicago',
      price: 1200,
      date: 'Sep 15,2023',
    ),
    Shipment(
      status: ShipmentStatus.completed,
      title: 'Delivered last week',
      trackingNumber: '#CMPLTD7890123456',
      fromLocation: 'Miami',
      price: 900,
      date: 'Sep 12,2023',
    ),
    Shipment(
      status: ShipmentStatus.completed,
      title: 'Delivered yesterday',
      trackingNumber: '#DONE1234567890123',
      fromLocation: 'Denver',
      price: 450,
      date: 'Sep 27,2023',
    ),
    Shipment(
      status: ShipmentStatus.cancelled,
      title: 'Shipment cancelled',
      trackingNumber: '#GHI7890123456789',
      fromLocation: 'Houston',
      price: 300,
      date: 'Sep 10,2023',
    ),
  ];

  List<Shipment> _getFilteredShipments() {
    if (_currentIndex == 0) {
      return _shipments;
    } else {
      final selectedTab = _tabs[_currentIndex];
      return _shipments.where((shipment) {
        switch (selectedTab) {
          case 'Completed':
            return shipment.status == ShipmentStatus.completed;
          case 'In progress':
            return shipment.status == ShipmentStatus.inProgress;
          case 'Pending Order':
            return shipment.status == ShipmentStatus.pending;
          case 'Cancelled':
            return shipment.status == ShipmentStatus.cancelled;
          default:
            return false;
        }
      }).toList();
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.appBarPurple,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarPurple,
        leading: IconButton(
          icon: Image.asset('assets/icons/left-arrow.png', color: Colors.white, height: 24, width: 24),
          onPressed: () {
            widget.onBack?.call();
          },
        ),
        title: Text(
          'Shipment history',
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        titleSpacing: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 10),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _tabs.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String tabName = entry.value;
                    bool isSelected = _currentIndex == idx;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = idx;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(tabName, style: AppTextStyles.bodyMedium.copyWith(color: isSelected ? Colors.white : Colors.white70)),
                                const SizedBox(width: 3),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFFFF8100) : Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    _tabCounts[tabName].toString(),
                                    style: AppTextStyles.caption.copyWith(color: isSelected ? Colors.white : Colors.white70, fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 2,
                              width: isSelected ? 30 : 0,
                              color: const Color(0xFFFF8100),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column( // Main column for the body content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Shipments',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.titleText, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _tabs.map((tabName) {
                final filteredShipments = _getFilteredShipments();
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  itemCount: filteredShipments.length,
                  itemBuilder: (context, index) {
                    return SlideFadeAnimation(
                      key: ValueKey('${_currentIndex}_${filteredShipments[index].trackingNumber}'), // Unique key for re-triggering animation
                      delay: Duration(milliseconds: 100 * index), // Staggered delay
                      child: ShipmentCard(shipment: filteredShipments[index]),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ShipmentCard extends StatelessWidget {
  const ShipmentCard({super.key, required this.shipment});
  final Shipment shipment;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    switch (shipment.status) {
      case ShipmentStatus.inProgress:
        statusColor = Colors.green;
        statusIcon = Icons.refresh;
        break;
      case ShipmentStatus.pending:
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        break;
      case ShipmentStatus.loading:
        statusColor = Colors.blue;
        statusIcon = Icons.hourglass_empty;
        break;
      case ShipmentStatus.completed:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case ShipmentStatus.cancelled:
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded( // Wrap the Column with Expanded
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Chip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Added to contain width
                    children: [
                      Icon(statusIcon, color: statusColor, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        shipment.status.toString().split('.').last.replaceAll('_', '-'),
                        style: AppTextStyles.caption.copyWith(color: statusColor, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  shipment.title,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.titleText, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                  'Your delivery, ${shipment.trackingNumber}',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
                Text(
                  'from ${shipment.fromLocation}, is arriving ${shipment.title.toLowerCase().contains('arriving') ? 'today!' : '!'}',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: '\$${shipment.price.toStringAsFixed(0)} ',
                    style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'USD',
                        style: AppTextStyles.caption.copyWith(color: AppColors.primary),
                      ),
                      TextSpan(
                        text: ' • ${shipment.date}',
                        style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/icons/move_box.jpeg', // Box icon
            height: 60,
            width: 60,
          ),
        ],
      ),
    );
  }
} 