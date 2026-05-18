import 'package:flutter/material.dart';
import '../../dashboard/dashboard_screen.dart';
import 'rm_master_page.dart';
import 'material_type_master_page.dart';
import 'vendor_master_page.dart';
import 'section_master_page.dart';
import 'uom_page.dart';
import 'pm_master_page.dart';
import 'pm_vendor_master_page.dart';
import 'pm_uom_page.dart';

// ==========================================
// 1. SECONDARY SIDEBAR (DESKTOP)
// ==========================================
class SecondaryMastersSidebar extends StatelessWidget {
  final String activePage;
  const SecondaryMastersSidebar({super.key, this.activePage = 'UOM'});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("All Masters", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: Text("RAW MATERIAL", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blue)),
          ),
          _secMenuItem(context, Icons.inventory_2_outlined, "RM Master", isActive: activePage == 'RM Master', destination: const RMMasterPage()),
          _secMenuItem(context, Icons.sell_outlined, "Material Type Master", destination: const MaterialTypeMasterPage(), isActive: activePage == 'Material Type Master'),
          _secMenuItem(context, Icons.group_outlined, "Vendor Master", destination: const VendorMasterPage(), isActive: activePage == 'Vendor Master'), 
          _secMenuItem(context, Icons.domain_outlined, "Section Master", destination: const SectionMasterPage(), isActive: activePage == 'Section Master'),
          _secMenuItem(context, Icons.straighten, "UOM", destination: const UOMPage(), isActive: activePage == 'UOM'), 
          
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: Text("PACKAGING MATERIAL", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blue)),
          ),
        
          _secMenuItem(context, Icons.inventory_2_outlined, "PM Master", destination: const PMMasterPage(), isActive: activePage == 'PM Master'),
          _secMenuItem(context, Icons.group_outlined, "PM Vendor Master", isActive: activePage == 'PM Vendor Master', destination: const PMVendorMasterPage()), 
          _secMenuItem(context, Icons.straighten, "PM UOM", isActive: activePage == 'PM UOM', destination: const PMUOMPage()),
        ],
      ),
    );
  }

  Widget _secMenuItem(BuildContext context, IconData icon, String label, {bool isActive = false, Widget? destination}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(color: isActive ? const Color(0xFF0D47A1) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -2),
        leading: Icon(icon, size: 20, color: isActive ? Colors.white : Colors.blueGrey),
        title: Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.blueGrey.shade700, fontSize: 13, fontWeight: isActive ? FontWeight.bold : FontWeight.w600)),
        onTap: () {
          if (destination != null && !isActive) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination));
          }
        },
      ),
    );
  }
}

// ==========================================
// 2. MOBILE SECONDARY MENU
// ==========================================
class MobileSecondaryMenu extends StatelessWidget {
  final String activePage;
  const MobileSecondaryMenu({super.key, this.activePage = 'UOM'});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _mobChip(context, "RM Master", destination: const RMMasterPage(), isActive: activePage == 'RM Master'), 
          _mobChip(context, "Material Type Master", destination: const MaterialTypeMasterPage(), isActive: activePage == 'Material Type Master'), 
          _mobChip(context, "Vendor Master", destination: const VendorMasterPage(), isActive: activePage == 'Vendor Master'), 
          _mobChip(context, "Section Master", destination: const SectionMasterPage(), isActive: activePage == 'Section Master'),
          _mobChip(context, "UOM", destination: const UOMPage(), isActive: activePage == 'UOM'), 
          _mobChip(context, "PM Master", destination: const PMMasterPage(), isActive: activePage == 'PM Master'), 
          _mobChip(context, "PM Vendor Master", destination: const PMVendorMasterPage(), isActive: activePage == 'PM Vendor Master'), 
          _mobChip(context, "PM UOM", destination: const PMUOMPage(), isActive: activePage == 'PM UOM'),
        ],
      ),
    );
  }

  Widget _mobChip(BuildContext context, String label, {bool isActive = false, Widget? destination}) {
    return GestureDetector(
      onTap: () {
        if (destination != null && !isActive) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0D47A1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? const Color(0xFF0D47A1) : Colors.grey.shade300)
        ),
        child: Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

// ==========================================
// 3. MASTER TOPBAR
// ==========================================
class MasterTopbar extends StatelessWidget {
  final String breadcrumb;
  const MasterTopbar({super.key, this.breadcrumb = "Home / Purchase Section / Masters"});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey),
          const SizedBox(width: 15),
          Text(breadcrumb, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const Spacer(),
          Container(
            width: 300, height: 40, decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
            child: const TextField(decoration: InputDecoration(hintText: "Search menus...", prefixIcon: Icon(Icons.search, size: 20), border: InputBorder.none)),
          ),
          const SizedBox(width: 25),
          const CircleAvatar(radius: 18, backgroundColor: Colors.blue, child: Text("R", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}

// ==========================================
// 4. PRIMARY SIDEBAR
// ==========================================
class MasterPrimarySidebar extends StatelessWidget {
  const MasterPrimarySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE1F5FE),
      child: Column(
        children: [
          const SizedBox(height: 35),
          Container(
            height: 90, width: 90,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: ClipOval(child: Padding(padding: const EdgeInsets.all(4.0), child: Image.asset('assets/images/rts_logo.png', fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image)))),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _navItem(context, Icons.speed, "Overall Dashboard", const DashboardScreen()),
                const SizedBox(height: 15),
                _headerItem(Icons.shopping_cart_outlined, "Purchase Section"),
                const SizedBox(height: 10),
                _subItem(Icons.inventory_2_outlined, "Raw Material", badge: "192"),
                _subItem(Icons.assignment_turned_in_outlined, "RM Request Management"),
                _subItem(Icons.event_available_outlined, "Daily Usage Management"),
                _subItem(Icons.inventory_2_outlined, "Packaging Material"),
                Container(
                  color: const Color(0xFF0D47A1),
                  child: ListTile(
                    visualDensity: const VisualDensity(vertical: -4),
                    leading: const Icon(Icons.storage_outlined, size: 22, color: Colors.white),
                    title: const Text("Masters", style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const UOMPage())),
                  ),
                ),
                _subItem(Icons.account_balance_wallet_outlined, "Stock Cost"),
                _subItem(Icons.assignment_outlined, "Inventory Audit Entry"),
                _subItem(Icons.delete_outline, "Wastage Management"),
                _subItem(Icons.history, "Reversal History"),
                _subItem(Icons.shopping_cart_checkout, "Bakery Products"),
                _subItem(Icons.update, "Purchase Transfer History"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, IconData icon, String label, Widget destination) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -2),
        leading: Icon(icon, color: const Color(0xFF1A237E), size: 22),
        title: Text(label, style: const TextStyle(color: Color(0xFF1A237E), fontSize: 13, fontWeight: FontWeight.bold)),
        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination)),
      ),
    );
  }

  Widget _headerItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -2),
        leading: Icon(icon, color: const Color(0xFF1A237E), size: 22),
        title: Text(label, style: const TextStyle(color: Color(0xFF1A237E), fontSize: 13, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _subItem(IconData icon, String text, {String? badge}) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 25, right: 15),
      visualDensity: const VisualDensity(vertical: -4),
      leading: Icon(icon, size: 20, color: const Color(0xFF1A237E)),
      title: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF1A237E), fontWeight: FontWeight.w600)),
      trailing: badge != null ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10)),
        child: Text(badge, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ) : null,
    );
  }
}