import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/dashboard/dashboard_screen.dart';
import 'package:gowmari_mobile/screens/purchase/masters/uom_page.dart'; 
import 'package:gowmari_mobile/screens/purchase/bakery_products/bakery_products_page.dart';
import 'package:gowmari_mobile/screens/purchase/packaging_material/packaging_material_page.dart';
import 'package:gowmari_mobile/screens/purchase/raw_material/purchase_order.dart';
import 'package:gowmari_mobile/screens/purchase/daily_usage_management/daily_usage_request.dart';
import 'package:gowmari_mobile/screens/purchase/store_audit/store_audit.dart'; 
import 'package:gowmari_mobile/screens/purchase/reversal_history/purchase_reversal_history.dart';

class AppSidebar extends StatelessWidget {
  final String activeMenu;

  const AppSidebar({
    super.key, 
    this.activeMenu = '', 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270, 
      color: const Color(0xFFEBF3FF), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 35),
          Center(
            child: Container(
              height: 100, width: 100,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset('assets/images/rts_logo.png', fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16), 
              children: [
                _buildMenuItem(context, Icons.dashboard, "Overall Dashboard", destination: const DashboardScreen()),
                
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 15, bottom: 10),
                  child: Text("Purchase Section", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                ),
                
                _buildMenuItem(context, Icons.inventory_2_outlined, "Raw Material", badge: "192", destination: const RawMaterialPurchaseOrderPage()),
                _buildMenuItem(context, Icons.assignment_turned_in_outlined, "RM Request Management"),
                _buildMenuItem(context, Icons.event_available_outlined, "Daily Usage Management", destination: const DailyUsageRequestPage()),
                
                _buildMenuItem(context, Icons.inventory_2_outlined, "Packaging Material", destination: const PackagingMaterialPage()),
                _buildMenuItem(context, Icons.view_list, "Masters", destination: const UOMPage()), 
                
                _buildMenuItem(context, Icons.account_balance_wallet_outlined, "Stock Cost"),
                _buildMenuItem(context, Icons.bar_chart, "Store Audit", destination: const StoreAuditPage()),
                _buildMenuItem(context, Icons.delete_outline, "Wastage Management"),
                
                // UPDATED THIS LINE TO INCLUDE DESTINATION
                _buildMenuItem(context, Icons.history, "Reversal History", destination: const PurchaseReversalHistoryPage()),
                
                _buildMenuItem(context, Icons.shopping_cart_checkout, "Bakery Products", destination: const BakeryProductsPage()),
                _buildMenuItem(context, Icons.update, "Purchase Transfer History"),
                _buildMenuItem(context, Icons.shopping_cart_checkout, "Purchase Report"),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildMenuItem(context, Icons.verified_user_outlined, "Access Provider"),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String text, {String? badge, Widget? destination}) {
    bool isActive = false;
    
    if (activeMenu.isNotEmpty) {
      isActive = (activeMenu == text);
    } else {
      final currentRouteName = ModalRoute.of(context)?.settings.name;
      if (currentRouteName == text) {
        isActive = true;
      } else if (text == "Overall Dashboard" && (currentRouteName == '/' || currentRouteName == null)) {
        isActive = true;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 4), 
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0D6EFD) : Colors.transparent, 
        borderRadius: BorderRadius.circular(8) 
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        visualDensity: const VisualDensity(vertical: -2),
        leading: Icon(
          icon, 
          size: 22, 
          color: isActive ? Colors.white : const Color(0xFF1A237E)
        ), 
        title: Text(
          text, 
          style: TextStyle(
            fontSize: 14, 
            color: isActive ? Colors.white : const Color(0xFF1A237E), 
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600
          )
        ),
        trailing: badge != null ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(12)),
          child: Text(badge, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
        ) : null,
        onTap: () {
          if (destination != null && !isActive) {
            Navigator.pushReplacement(
              context, 
              PageRouteBuilder(
                settings: RouteSettings(name: text), 
                pageBuilder: (context, animation1, animation2) => destination,
                transitionDuration: Duration.zero, 
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
    );
  }
}