import 'package:flutter/material.dart';

// Enum to manage tabs
enum OperationTab { purchaseEntry, purchaseOrder, invoiceManagement }

class PackagingSubSidebar extends StatelessWidget {
  final OperationTab activeTab;
  final Function(OperationTab) onTabChanged;
  final bool isMobile;

  const PackagingSubSidebar({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildOperationItem("Purchase Entry", Icons.receipt_long,
                  isActive: activeTab == OperationTab.purchaseEntry,
                  isHorizontal: true,
                  onTap: () => onTabChanged(OperationTab.purchaseEntry)),
              _buildOperationItem("Purchase Order", Icons.shopping_cart_outlined,
                  isActive: activeTab == OperationTab.purchaseOrder,
                  isHorizontal: true,
                  onTap: () => onTabChanged(OperationTab.purchaseOrder)),
              _buildOperationItem("Invoice Management", Icons.description_outlined,
                  isActive: activeTab == OperationTab.invoiceManagement,
                  isHorizontal: true,
                  onTap: () => onTabChanged(OperationTab.invoiceManagement)),
            ],
          ),
        ),
      );
    }

    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              "OPERATIONS MENU",
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5),
            ),
          ),
          _buildOperationItem("Purchase Entry", Icons.receipt_long,
              isActive: activeTab == OperationTab.purchaseEntry,
              onTap: () => onTabChanged(OperationTab.purchaseEntry)),
          _buildOperationItem("Purchase Order", Icons.shopping_cart_outlined,
              isActive: activeTab == OperationTab.purchaseOrder,
              onTap: () => onTabChanged(OperationTab.purchaseOrder)),
          _buildOperationItem("Invoice Management", Icons.description_outlined,
              isActive: activeTab == OperationTab.invoiceManagement,
              onTap: () => onTabChanged(OperationTab.invoiceManagement)),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildOperationItem(String title, IconData icon,
      {bool isActive = false, VoidCallback? onTap, bool isHorizontal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: isHorizontal ? null : double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF2563EB) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: isActive ? Colors.white : Colors.grey.shade500),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive ? Colors.white : Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}