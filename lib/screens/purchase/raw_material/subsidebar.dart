import 'package:flutter/material.dart';
import 'purchase_order.dart';
import 'purchase_entry.dart'; // Make sure this matches your Purchase Entry file name
import 'invoice_management.dart'; // Make sure this matches your new Invoice Management file name
import 'section_wise_consumption.dart'; // Added import for Section Wise Consumption

class RawMaterialSubSidebar extends StatelessWidget {
  final String activePage;

  const RawMaterialSubSidebar({super.key, required this.activePage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(left: 25, top: 25, bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Stock settings",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
            ),
          ),
          
          // Menu Items
          _buildMenuItem(
            context, 
            "Purchase Order", 
            Icons.shopping_bag_outlined, 
            activePage == 'Purchase Order'
          ),
          _buildMenuItem(
            context, 
            "Purchase Entry", 
            Icons.shopping_cart_outlined, 
            activePage == 'Purchase Entry',
            targetPage: const RawMaterialPurchaseEntryPage() // Routes to Purchase Entry
          ),
          _buildMenuItem(
            context, 
            "Invoice Management", 
            Icons.receipt_long_outlined, 
            activePage == 'Invoice Management',
            targetPage: const InvoiceManagementPage() // Routes to Invoice Management
          ),
          _buildMenuItem(
            context, 
            "Section Wise Consumption", 
            Icons.pie_chart_outline, 
            activePage == 'Section Wise Consumption',
            targetPage: const SectionWiseConsumptionScreen() // Added routing to Section Wise Consumption
          ),
          _buildMenuItem(
            context, 
            "Inventory Audit Entry", 
            Icons.inventory_outlined, 
            activePage == 'Inventory Audit Entry'
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon, bool isActive, {Widget? targetPage}) {
    return InkWell(
      onTap: () {
        // Only navigate if the page is NOT currently active and a target route exists
        if (!isActive && targetPage != null) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => targetPage,
              transitionDuration: Duration.zero, // Zero duration for instant web-like snapping
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0D6EFD) : Colors.transparent, // Blue if active
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon, 
              size: 20, 
              color: isActive ? Colors.white : Colors.grey.shade600
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black87,
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}