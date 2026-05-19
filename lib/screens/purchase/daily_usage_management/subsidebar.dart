import 'package:flutter/material.dart';
import 'daily_usage_request.dart';

class DailyUsageSubSidebar extends StatelessWidget {
  final String activePage;

  const DailyUsageSubSidebar({super.key, required this.activePage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "DAILY USAGE MENU",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey,
                letterSpacing: 1.1,
              ),
            ),
          ),
          // CORRECTED: changed Fact_check_outlined to fact_check_outlined
          _buildMenuItem(context, "Daily Usage Request", Icons.fact_check_outlined),
          _buildMenuItem(context, "Daily Usage PO", Icons.shopping_bag_outlined),
          _buildMenuItem(context, "Daily Usage Purchase", Icons.shopping_cart_outlined),
          _buildMenuItem(context, "Daily Usage Transfer", Icons.swap_horiz_outlined),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon) {
    bool isActive = activePage == title;

    return InkWell(
      onTap: () {
        if (!isActive && title == "Daily Usage Request") {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, a1, a2) => const DailyUsageRequestPage(),
              transitionDuration: Duration.zero,
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0D6EFD) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? Colors.white : Colors.grey.shade600,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}