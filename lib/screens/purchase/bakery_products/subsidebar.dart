import 'package:flutter/material.dart';

class SubSidebar extends StatelessWidget {
  final int activeTabIndex;
  final Function(int) onTabChanged;

  const SubSidebar({Key? key, required this.activeTabIndex, required this.onTabChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220, 
      margin: const EdgeInsets.only(top: 20, left: 20), 
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          const Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 10), child: Text('VENDOR PRODUCT MENU', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 11))), 
          _buildSecSidebarItem(Icons.grid_view, 'Available Stock', activeTabIndex == 0, () => onTabChanged(0)), 
          _buildSecSidebarItem(Icons.shopping_cart_checkout, 'Purchase Entry', activeTabIndex == 1, () => onTabChanged(1))
        ]
      )
    );
  }

  Widget _buildSecSidebarItem(IconData icon, String title, bool isActive, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), 
      decoration: BoxDecoration(color: isActive ? const Color(0xFF1B59F8) : Colors.transparent, borderRadius: BorderRadius.circular(8)), 
      child: ListTile(
        leading: Icon(icon, size: 18, color: isActive ? Colors.white : Colors.grey), 
        title: Text(title, style: TextStyle(color: isActive ? Colors.white : Colors.grey[700], fontWeight: isActive ? FontWeight.bold : FontWeight.w500, fontSize: 13)), 
        dense: true, 
        visualDensity: const VisualDensity(vertical: -2), 
        onTap: onTap
      )
    );
  }
}