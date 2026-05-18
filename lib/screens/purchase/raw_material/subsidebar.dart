import 'package:flutter/material.dart';
import 'purchase_order.dart';
import 'purchase_entry.dart';

class RawMaterialSubSidebar extends StatelessWidget {
  final String activePage;
  const RawMaterialSubSidebar({super.key, required this.activePage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text("Stock settings", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
          ),
          const SizedBox(height: 10),
          _menuItem(context, Icons.shopping_bag_outlined, "Purchase Order", isActive: activePage == 'Purchase Order'),
          _menuItem(context, Icons.shopping_cart_outlined, "Purchase Entry", isActive: activePage == 'Purchase Entry'),
          _menuItem(context, Icons.receipt_long_outlined, "Invoice Management", isActive: activePage == 'Invoice Management'),
          _menuItem(context, Icons.pie_chart_outline, "Section Wise\nConsumption", isActive: activePage == 'Section Wise Consumption'),
          _menuItem(context, Icons.assignment_outlined, "Inventory Audit Entry", isActive: activePage == 'Inventory Audit Entry'),
        ],
      ),
    );
  }

  Widget _menuItem(BuildContext context, IconData icon, String text, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0D6EFD) : Colors.transparent,
        borderRadius: BorderRadius.circular(6)
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon, size: 18, color: isActive ? Colors.white : Colors.grey.shade600),
        title: Text(text, style: TextStyle(fontSize: 13, fontWeight: isActive ? FontWeight.bold : FontWeight.w500, color: isActive ? Colors.white : Colors.grey.shade800)),
        onTap: () {
          if (text == "Purchase Order") {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const RawMaterialPurchaseOrderPage()));
          } else if (text == "Purchase Entry") {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const RawMaterialPurchaseEntryPage()));
          }
        },
      ),
    );
  }
}