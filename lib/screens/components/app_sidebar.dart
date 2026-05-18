import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/dashboard/dashboard_screen.dart';

// --- CORRECTED IMPORTS BASED ON YOUR SCREENSHOT ---
import 'package:gowmari_mobile/screens/purchase/masters/uom_page.dart'; 
import 'package:gowmari_mobile/screens/purchase/bakery_products/bakery_products_page.dart';
// 👉 CORRECTED PATH: The file is inside the 'packaging_material' subfolder
import 'package:gowmari_mobile/screens/purchase/packaging_material/packaging_material_page.dart'; 


class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEBF3FF), 
      child: Column(
        children: [
          const SizedBox(height: 35),
          Container(
            height: 100, width: 100,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('assets/images/rts_logo.png', fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image)),
              ),
            ),
          ),
          const SizedBox(height: 35),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _menuItem(context, Icons.dashboard, "Dashboard", destination: const DashboardScreen()),
                const SizedBox(height: 10),
                
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 15, bottom: 10),
                  child: Text("Purchase Section", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                ),
                
                _subItem(context, Icons.inventory_2_outlined, "Raw Material", badge: "192"),
                _subItem(context, Icons.assignment_turned_in_outlined, "RM Request Management"),
                _subItem(context, Icons.event_available_outlined, "Daily Usage Management"),
                
                // This will now work correctly
                _subItem(context, Icons.inventory_2_outlined, "Packaging Material", destination: const PackagingMaterialPage()),
                _subItem(context, Icons.storage_outlined, "Masters", destination: const UOMPage()), 
                
                _subItem(context, Icons.account_balance_wallet_outlined, "Stock Cost"),
                _subItem(context, Icons.assignment_outlined, "Inventory Audit Entry"),
                _subItem(context, Icons.delete_outline, "Wastage Management"),
                _subItem(context, Icons.history, "Reversal History"),
                
                _subItem(context, Icons.shopping_cart_checkout, "Bakery Products", destination: const BakeryProductsPage()),
                _subItem(context, Icons.update, "Purchase Transfer History"),
                _subItem(context, Icons.shopping_cart_checkout, "Purchase Report"),
              ],
            ),
          ),
          const Divider(height: 1),
          _subItem(context, Icons.verified_user_outlined, "Access Provider"),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _menuItem(BuildContext context, IconData icon, String label, {Widget? destination}) {
    bool isActive = destination != null && 
                    ModalRoute.of(context)?.settings is MaterialPageRoute &&
                    (ModalRoute.of(context)?.settings as MaterialPageRoute).builder(context).runtimeType == destination.runtimeType;
    
    if (label == "Dashboard" && destination.runtimeType == DashboardScreen) isActive = true;

    return Container(
      decoration: BoxDecoration(color: isActive ? const Color(0xFF0D6EFD) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -2),
        leading: Icon(icon, color: isActive ? Colors.white : const Color(0xFF1A237E), size: 22),
        title: Text(label, style: TextStyle(color: isActive ? Colors.white : const Color(0xFF1A237E), fontSize: 14, fontWeight: FontWeight.bold)),
        onTap: () {
          if (destination != null) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination));
          }
        },
      ),
    );
  }

  Widget _subItem(BuildContext context, IconData icon, String text, {String? badge, Widget? destination}) {
    bool isActive = destination != null && 
                    ModalRoute.of(context)?.settings is MaterialPageRoute &&
                    (ModalRoute.of(context)?.settings as MaterialPageRoute).builder(context).runtimeType == destination.runtimeType;

    return ListTile(
      selected: isActive,
      selectedTileColor: Colors.white, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      visualDensity: const VisualDensity(vertical: -2),
      leading: Icon(icon, size: 20, color: const Color(0xFF4A5568)), 
      title: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF4A5568), fontWeight: FontWeight.w600)),
      trailing: badge != null ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(12)),
        child: Text(badge, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ) : null,
      onTap: () {
        if (destination != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination));
        }
      },
    );
  }
}