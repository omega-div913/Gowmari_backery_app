import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/dashboard/dashboard_screen.dart';
import 'package:gowmari_mobile/screens/masters/masters_page.dart';
import 'package:gowmari_mobile/screens/masters/vendor_master_page.dart';
import 'package:gowmari_mobile/screens/masters/section_master_page.dart';

class MaterialTypeMasterPage extends StatefulWidget {
  const MaterialTypeMasterPage({super.key});

  @override
  State<MaterialTypeMasterPage> createState() => _MaterialTypeMasterPageState();
}

class _MaterialTypeMasterPageState extends State<MaterialTypeMasterPage> {
  final List<String> materialTypes = [
    'BAKERY', 'CHAT MATERIAL', 'CLEANING MATERIAL', 'PACKING MATERIAL',
    'RAW MATERIAL', 'SERVICE MATERIAL', 'TEA COFFE MATERIAL',
    'VADA MATERIAL', 'VEGETABLES'
  ];

  // --- PAGINATION STATE ---
  int _currentPage = 1;
  int _itemsPerPage = 5;

  List<String> get paginatedTypes {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (startIndex >= materialTypes.length) return [];
    if (endIndex > materialTypes.length) endIndex = materialTypes.length;
    return materialTypes.sublist(startIndex, endIndex);
  }

  bool isEditing = false;
  String? currentlyEditingType;
  final TextEditingController _typeController = TextEditingController();

  void _startEdit(String type) {
    setState(() {
      isEditing = true;
      currentlyEditingType = type;
      _typeController.text = type;
    });
  }

  void _cancelEdit() {
    setState(() {
      isEditing = false;
      currentlyEditingType = null;
      _typeController.clear();
    });
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 3)),
                  child: const Center(child: Text("!", style: TextStyle(fontSize: 50, color: Color(0xFFF8BB86), fontWeight: FontWeight.w300))),
                ),
                const SizedBox(height: 25),
                const Text("Are you sure?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                const Text("You won't be able to revert this!", style: TextStyle(fontSize: 14, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 25),
                Wrap(
                  alignment: WrapAlignment.center, spacing: 10, runSpacing: 10,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7367F0), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK", style: TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                    ElevatedButton(
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
                                if (isTablet)
                                  Column(children: [_buildActionForm(), const SizedBox(height: 20), _buildDataTable()])
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

  Widget _buildActionForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isEditing ? "Edit Material Type" : "Add New Material Type", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
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
          if (!isEditing)
            SizedBox(
              width: double.infinity, height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                onPressed: () {},
                child: const Text("Save Type", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            )
          else
            Column(
              children: [
                SizedBox(
                  width: double.infinity, height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                    onPressed: () => _cancelEdit(),
                    child: const Text("Update Type", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity, height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF3F4F6), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
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

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 40,
              decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(6)),
              child: const TextField(decoration: InputDecoration(hintText: "Search material types...", hintStyle: TextStyle(fontSize: 13, color: Colors.grey), contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12), border: InputBorder.none)),
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: Row(
              children: const [
                SizedBox(width: 50, child: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), // Added S.No
                Expanded(child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                SizedBox(width: 80, child: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center)),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: paginatedTypes.length,
            separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              int sNo = index + 1 + (_currentPage - 1) * _itemsPerPage;
              String currentType = paginatedTypes[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    SizedBox(width: 50, child: Text("$sNo", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87))), // Added S.No Value
                    Expanded(child: Text(currentType, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600))),
                    SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _actionBtn(Icons.edit_outlined, Colors.blue, () => _startEdit(currentType)), // Changed to icon
                          const SizedBox(width: 8),
                          _actionBtn(Icons.delete_outline, Colors.red, () => _showDeleteDialog(context)), // Changed to icon
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          _buildPagination(), // Added Pagination
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: 30, height: 30,
      decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 16, color: color),
        onPressed: onTap,
      ),
    );
  }

  // --- PAGINATION WIDGET ---
  Widget _buildPagination() {
    int totalPages = (materialTypes.length / _itemsPerPage).ceil();
    if (totalPages <= 1) totalPages = 1;

    List<Widget> pageButtons = [];
    
    pageButtons.add(_pageBox("Prev", false, () {
      if (_currentPage > 1) setState(() => _currentPage--);
    }));
    pageButtons.add(const SizedBox(width: 5));

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(_pageBox("$i", _currentPage == i, () {
        setState(() => _currentPage = i);
      }));
      if (i < totalPages) pageButtons.add(const SizedBox(width: 5));
    }

    pageButtons.add(const SizedBox(width: 5));
    pageButtons.add(_pageBox("Next", false, () {
      if (_currentPage < totalPages) setState(() => _currentPage++);
    }));

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Showing ${paginatedTypes.length} of ${materialTypes.length} entries", style: const TextStyle(fontSize: 13, color: Colors.grey)),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 2, 
            runSpacing: 8,
            children: pageButtons
          ),
        ],
      ),
    );
  }

  Widget _pageBox(String t, bool active, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), 
      decoration: BoxDecoration(
        color: active ? Colors.blue : Colors.white, 
        border: Border.all(color: active ? Colors.blue : Colors.grey.shade300), 
        borderRadius: BorderRadius.circular(4)
      ), 
      child: Text(t, style: TextStyle(color: active ? Colors.white : Colors.blue, fontSize: 12, fontWeight: FontWeight.bold))
    ),
  );
}

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
          _secMenuItem(context, Icons.sell_outlined, "Material Type Master", isActive: true),
          _secMenuItem(context, Icons.group_outlined, "Vendor Master", destination: VendorMasterPage()),
          _secMenuItem(context, Icons.domain_outlined, "Section Master", destination: SectionMasterPage()),
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
          if (destination != null) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination));
        },
      ),
    );
  }
}

class MasterPrimarySidebar extends StatelessWidget {
  const MasterPrimarySidebar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE1F5FE),
      child: Column(
        children: [
          const SizedBox(height: 35),
          Container(height: 90, width: 90, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: ClipOval(child: Padding(padding: const EdgeInsets.all(4.0), child: Image.asset('assets/images/rts_logo.png', fit: BoxFit.cover)))),
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
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: ListTile(visualDensity: const VisualDensity(vertical: -2), leading: Icon(icon, color: const Color(0xFF1A237E), size: 22), title: Text(label, style: const TextStyle(color: Color(0xFF1A237E), fontSize: 13, fontWeight: FontWeight.bold)), onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination))));
  }

  Widget _headerItem(IconData icon, String label) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: ListTile(visualDensity: const VisualDensity(vertical: -2), leading: Icon(icon, color: const Color(0xFF1A237E), size: 22), title: Text(label, style: const TextStyle(color: Color(0xFF1A237E), fontSize: 13, fontWeight: FontWeight.bold))));
  }

  Widget _subItem(IconData icon, String text, {String? badge}) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 25, right: 15), visualDensity: const VisualDensity(vertical: -4),
      leading: Icon(icon, size: 20, color: const Color(0xFF1A237E)),
      title: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF1A237E), fontWeight: FontWeight.w600)),
      trailing: badge != null ? Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10)), child: Text(badge, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))) : null,
    );
  }
}

class MaterialTypeTopbar extends StatelessWidget {
  const MaterialTypeTopbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey),
          const SizedBox(width: 15),
          const Text("Home / Purchase Section / Masters / Product Types", style: TextStyle(color: Colors.grey, fontSize: 13)),
          const Spacer(),
          Container(width: 300, height: 40, decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)), child: const TextField(decoration: InputDecoration(hintText: "Search menus...", prefixIcon: Icon(Icons.search, size: 20), border: InputBorder.none))),
          const SizedBox(width: 25),
          const CircleAvatar(radius: 18, backgroundColor: Colors.blue, child: Text("R", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}

class MobileSecondaryMenu extends StatelessWidget {
  const MobileSecondaryMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _mobChip(context, "RM Master"), 
          _mobChip(context, "Material Type Master", isActive: true), 
          _mobChip(context, "Vendor Master", destination: VendorMasterPage()), 
          _mobChip(context, "Section Master", destination: SectionMasterPage()),
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
        if (destination != null) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(color: isActive ? const Color(0xFF0D47A1) : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: isActive ? const Color(0xFF0D47A1) : Colors.grey.shade300)),
        child: Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }
}