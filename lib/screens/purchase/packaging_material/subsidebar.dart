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
              _buildOperationItem("Purchase Entry", isActive: activeTab == OperationTab.purchaseEntry, isHorizontal: true, onTap: () => onTabChanged(OperationTab.purchaseEntry)),
              _buildOperationItem("Purchase Order", isActive: activeTab == OperationTab.purchaseOrder, isHorizontal: true, onTap: () => onTabChanged(OperationTab.purchaseOrder)),
              _buildOperationItem("Invoice Management", isActive: activeTab == OperationTab.invoiceManagement, isHorizontal: true, onTap: () => onTabChanged(OperationTab.invoiceManagement)),
            ],
          ),
        ),
      );
    }

    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text("Packaging Material", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text("OPERATIONS", style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          _buildOperationItem("Purchase Entry", isActive: activeTab == OperationTab.purchaseEntry, onTap: () => onTabChanged(OperationTab.purchaseEntry)),
          _buildOperationItem("Purchase Order", isActive: activeTab == OperationTab.purchaseOrder, onTap: () => onTabChanged(OperationTab.purchaseOrder)),
          _buildOperationItem("Invoice Management", isActive: activeTab == OperationTab.invoiceManagement, onTap: () => onTabChanged(OperationTab.invoiceManagement)),
        ],
      ),
    );
  }

  Widget _buildOperationItem(String title, {bool isActive = false, VoidCallback? onTap, bool isHorizontal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: isHorizontal ? null : double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF0D47A1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? Colors.white : Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}