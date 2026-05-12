import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'vendor_master_page.dart';
import 'material_type_master_page.dart'; 
import 'section_master_page.dart'; 
import 'pm_master_page.dart';
import 'pm_vendor_master_page.dart'; 
import 'pm_uom_page.dart';
import 'rm_master_page.dart';

class MastersPage extends StatefulWidget {
  const MastersPage({super.key});

  @override
  State<MastersPage> createState() => _MastersPageState();
}

class _MastersPageState extends State<MastersPage> {
  final List<String> units = ['bag', 'box', 'gram', 'kg', 'ltr', 'ml', 'nos', 'pcs', 'per roll', 'pkt'];

  void _showCreateUnitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: SizedBox(
            width: 550, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Create Unit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, size: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey.shade300),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Unit Name (e.g., kg, pcs, ltr)", style: TextStyle(fontSize: 13, color: Colors.black87)),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Colors.blue)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          SizedBox(
                            height: 38,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Close", style: TextStyle(color: Colors.white, fontSize: 13)),
                            ),
                          ),
                          SizedBox(
                            height: 38,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Save Unit", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void _showEditUnitDialog(BuildContext context, String currentUnitName) {
    TextEditingController controller = TextEditingController(text: currentUnitName);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: SizedBox(
            width: 550, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Edit Unit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, size: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey.shade300),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Unit Name (e.g., kg, pcs, ltr)", style: TextStyle(fontSize: 13, color: Colors.black87)),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Colors.blue)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          SizedBox(
                            height: 38,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Close", style: TextStyle(color: Colors.white, fontSize: 13)),
                            ),
                          ),
                          SizedBox(
                            height: 38,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Update Unit", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFF8BB86), width: 4), 
                  ),
                  child: const Center(
                    child: Text("!", style: TextStyle(fontSize: 50, color: Color(0xFFF8BB86), fontWeight: FontWeight.w300)),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  "Are you sure?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF545454)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "You won't be able to revert this!",
                  style: TextStyle(fontSize: 14, color: Color(0xFF545454)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10, 
                  runSpacing: 10, 
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC3545), 
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007BFF), 
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;
    bool isTablet = screenWidth < 850;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: MasterPrimarySidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text("Unit of Measurement", style: TextStyle(color: Colors.black, fontSize: 16)),
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const SizedBox(width: 250, child: MasterPrimarySidebar()),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) const MasterTopbar(),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isTablet) const SizedBox(width: 260, child: SecondaryMastersSidebar()),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isTablet) const MobileSecondaryMenu(),
                                if (isTablet) const SizedBox(height: 20),
                                _buildPageHeader(context, isTablet), 
                                const SizedBox(height: 20),
                                _buildDataTable(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context, bool isTablet) {
    return Flex(
      direction: isTablet ? Axis.vertical : Axis.horizontal,
      crossAxisAlignment: isTablet ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        const Text(
          "Unit of Measurement", 
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))
        ),
        if (!isTablet) const Spacer(),
        if (isTablet) const SizedBox(height: 15),
        
        Container(
          width: isTablet ? double.infinity : 280,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(6), 
            border: Border.all(color: Colors.grey.shade300)
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Search units...", 
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
              prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey),
              border: InputBorder.none, 
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        SizedBox(width: isTablet ? 0 : 15, height: isTablet ? 15 : 0),
        
        SizedBox(
          width: isTablet ? double.infinity : null,
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () => _showCreateUnitDialog(context),
            icon: const Icon(Icons.add, size: 18, color: Colors.white),
            label: const Text("Create New Unit", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D47A1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Unit Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: units.length,
            separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(units[index], style: const TextStyle(fontSize: 14, color: Colors.black87)),
                    Row(
                      children: [
                        _actionBtn(Icons.edit_outlined, Colors.blue, () => _showEditUnitDialog(context, units[index])),
                        const SizedBox(width: 8),
                        _actionBtn(Icons.delete_outline, Colors.red, () => _showDeleteDialog(context)),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: 32, height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 16, color: color),
        onPressed: onTap,
      ),
    );
  }
}

// ==========================================
// 2. SECONDARY SIDEBAR ("ALL MASTERS")
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
          _secMenuItem(context, Icons.straighten, "UOM", destination: const MastersPage(), isActive: activePage == 'UOM'), 
          
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
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0D47A1) : Colors.transparent, 
        borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -2),
        leading: Icon(icon, size: 20, color: isActive ? Colors.white : Colors.blueGrey),
        title: Text(label, style: TextStyle(
          color: isActive ? Colors.white : Colors.blueGrey.shade700, 
          fontSize: 13, 
          fontWeight: isActive ? FontWeight.bold : FontWeight.w600
        )),
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
// 3. PRIMARY SIDEBAR
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
            child: ClipOval(child: Padding(padding: const EdgeInsets.all(4.0), child: Image.asset('assets/images/rts_logo.png', fit: BoxFit.cover))),
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

// ==========================================
// 4. TOPBAR
// ==========================================
class MasterTopbar extends StatelessWidget {
  final String breadcrumb; // Dynamic breadcrumb path
  const MasterTopbar({super.key, this.breadcrumb = "Home / Purchase Section / Masters / Units"});

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
// 5. MOBILE SECONDARY MENU
// ==========================================
// masters_page.dart-la intha class-ah replace pannunga
class MobileSecondaryMenu extends StatelessWidget {
  final String activePage;
  
  // constructor
  const MobileSecondaryMenu({super.key, this.activePage = 'UOM'});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _mobChip(context, "RM Master", isActive: activePage == 'RM Master'), 
          _mobChip(context, "Material Type Master", destination: const MaterialTypeMasterPage(), isActive: activePage == 'Material Type Master'), 
          _mobChip(context, "Vendor Master", destination: const VendorMasterPage(), isActive: activePage == 'Vendor Master'), 
          _mobChip(context, "Section Master", destination: const SectionMasterPage(), isActive: activePage == 'Section Master'),
          _mobChip(context, "UOM", destination: const MastersPage(), isActive: activePage == 'UOM'), 
          _mobChip(context, "PM Master", destination: const PMMasterPage(), isActive: activePage == 'PM Master'), 
          _mobChip(context, "PM Vendor Master", isActive: activePage == 'PM Vendor Master'), 
          _mobChip(context, "PM UOM", isActive: activePage == 'PM UOM'),
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