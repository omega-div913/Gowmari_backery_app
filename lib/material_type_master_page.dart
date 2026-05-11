import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'masters_page.dart';
import 'vendor_master_page.dart';

class MaterialTypeMasterPage extends StatefulWidget {
  const MaterialTypeMasterPage({super.key});

  @override
  State<MaterialTypeMasterPage> createState() => _MaterialTypeMasterPageState();
}

class _MaterialTypeMasterPageState extends State<MaterialTypeMasterPage> {
  // Data matching your image exactly
  final List<String> materialTypes = [
    'BAKERY', 'CHAT MATERIAL', 'CLEANING MATERIAL', 'PACKING MATERIAL',
    'RAW MATERIAL', 'SERVICE MATERIAL', 'TEA COFFE MATERIAL',
    'VADA MATERIAL', 'VEGETABLES'
  ];

  // State variables to manage Add/Edit modes
  bool isEditing = false;
  String? currentlyEditingType;
  final TextEditingController _typeController = TextEditingController();

  // Handle Edit Click
  void _startEdit(String type) {
    setState(() {
      isEditing = true;
      currentlyEditingType = type;
      _typeController.text = type;
    });
  }

  // Handle Cancel Edit
  void _cancelEdit() {
    setState(() {
      isEditing = false;
      currentlyEditingType = null;
      _typeController.clear();
    });
  }

  // ==========================================
  // EXACT DELETE DIALOG FROM IMAGE 1 (Overflow fixed)
  // ==========================================
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: Container(
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Orange Exclamation Circle
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, 
                    border: Border.all(color: const Color(0xFFF8BB86), width: 3)
                  ),
                  child: const Center(
                    child: Text("!", style: TextStyle(fontSize: 50, color: Color(0xFFF8BB86), fontWeight: FontWeight.w300))
                  ),
                ),
                const SizedBox(height: 25),
                const Text("Are you sure?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                const Text("You won't be able to revert this!", style: TextStyle(fontSize: 14, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 25),
                // Buttons Wrapped to prevent overflow
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10, runSpacing: 10,
                  children: [
                    ElevatedButton(
                      // Purple color matching Image 1
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7367F0), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK", style: TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                    ElevatedButton(
                      // Grey color matching Image 1
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF82868B), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
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
              backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black),
              title: const Text("Material Type Master", style: TextStyle(color: Colors.black, fontSize: 16)),
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const SizedBox(width: 250, child: MasterPrimarySidebar()),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) const MaterialTypeTopbar(),
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
                                const Text("Material Type Master", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                                const SizedBox(height: 20),
                                
                                // Form and Table Layout
                                if (isTablet)
                                  Column(
                                    children: [
                                      _buildActionForm(),
                                      const SizedBox(height: 20),
                                      _buildDataTable(),
                                    ],
                                  )
                                else
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(flex: 2, child: _buildActionForm()),
                                      const SizedBox(width: 25),
                                      Expanded(flex: 5, child: _buildDataTable()),
                                    ],
                                  )
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

  // ==========================================
  // LEFT SIDE FORM (ADD / EDIT STATE)
  // ==========================================
  Widget _buildActionForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEditing ? "Edit Material Type" : "Add New Material Type", 
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 40,
            child: TextField(
              controller: _typeController,
              decoration: InputDecoration(
                hintText: isEditing ? "" : "e.g. Sweets",
                hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF8F9FA),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          if (!isEditing) // ADD STATE (Image 2)
            SizedBox(
              width: double.infinity, height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                onPressed: () {}, // Save Logic Here
                child: const Text("Save Type", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            )
          else // EDIT STATE (Image 3)
            Column(
              children: [
                SizedBox(
                  width: double.infinity, height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                    onPressed: () => _cancelEdit(), // Update Logic Here
                    child: const Text("Update Type", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity, height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF3F4F6), 
                      elevation: 0, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
                    ),
                    onPressed: _cancelEdit,
                    child: const Text("Cancel", style: TextStyle(color: Colors.black87, fontSize: 13)),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }

  // ==========================================
  // RIGHT SIDE DATA TABLE
  // ==========================================
  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          // Search Input
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 40,
              decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(6)),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search material types...", hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),

          // Table Rows
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: materialTypes.length,
            separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(materialTypes[index], style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        _pillButton("Edit", Colors.blue, () => _startEdit(materialTypes[index])),
                        const SizedBox(width: 10),
                        _pillButton("Delete", Colors.red, () => _showDeleteDialog(context)),
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

  // Exact pill-shaped buttons shown in table
  Widget _pillButton(String text, Color color, VoidCallback onTap) {
    return SizedBox(
      height: 28,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          side: BorderSide(color: color.withOpacity(0.4)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: onTap,
        child: Text(text, style: TextStyle(color: color, fontSize: 12)),
      ),
    );
  }
}

// ==========================================
// SECONDARY SIDEBAR ("ALL MASTERS")
// ==========================================
class SecondaryMastersSidebar extends StatelessWidget {
  const SecondaryMastersSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(left: 10), child: Text("All Masters", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)))),
          const SizedBox(height: 20), const Divider(), const SizedBox(height: 10),
          
          const Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text("RAW MATERIAL", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blue))),
          _secMenuItem(context, Icons.inventory_2_outlined, "RM Master"),
          _secMenuItem(context, Icons.sell_outlined, "Material Type Master", isActive: true), // ACTIVE
          _secMenuItem(context, Icons.group_outlined, "Vendor Master", destination: const VendorMasterPage()), 
          _secMenuItem(context, Icons.domain_outlined, "Section Master"),
          _secMenuItem(context, Icons.straighten, "UOM", destination: const MastersPage()), 
          
          const SizedBox(height: 20),
          const Padding(padding: EdgeInsets.only(left: 10, bottom: 10), child: Text("PACKAGING MATERIAL", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blue))),
          _secMenuItem(context, Icons.inventory_2_outlined, "PM Master"),
          _secMenuItem(context, Icons.group_outlined, "PM Vendor Master"),
          _secMenuItem(context, Icons.straighten, "PM UOM"),
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
          if (destination != null) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination));
          }
        },
      ),
    );
  }
}

// ==========================================
// PRIMARY SIDEBAR
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
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MastersPage())),
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
// TOPBAR
// ==========================================
class MaterialTypeTopbar extends StatelessWidget {
  const MaterialTypeTopbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, 
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey),
          const SizedBox(width: 15),
          const Text("Home / Purchase Section / Masters / Product Types", style: TextStyle(color: Colors.grey, fontSize: 13)),
          const Spacer(),
          Container(
            width: 300, height: 40, 
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
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
// MOBILE SECONDARY MENU
// ==========================================
class MobileSecondaryMenu extends StatelessWidget {
  const MobileSecondaryMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _mobChip(context, "RM Master"), 
          _mobChip(context, "Material Type Master", isActive: true), 
          _mobChip(context, "Vendor Master", destination: const VendorMasterPage()), 
          _mobChip(context, "Section Master"),
          _mobChip(context, "UOM", destination: const MastersPage()), 
          _mobChip(context, "PM Master"), 
          _mobChip(context, "PM Vendor Master"), 
          _mobChip(context, "PM UOM"),
        ],
      ),
    );
  }

  Widget _mobChip(BuildContext context, String label, {bool isActive = false, Widget? destination}) {
    return GestureDetector(
      onTap: () {
        if (destination != null) {
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