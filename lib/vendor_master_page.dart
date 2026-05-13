import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'masters_page.dart'; 
import 'material_type_master_page.dart';
import 'section_master_page.dart';

class VendorMasterPage extends StatefulWidget {
  const VendorMasterPage({super.key});

  @override
  State<VendorMasterPage> createState() => _VendorMasterPageState();
}

class _VendorMasterPageState extends State<VendorMasterPage> {
  final List<Map<String, String>> vendors = [
    {'name': 'BEYONDEX COOLS', 'address': 'VASANTHAM NAGAR, SARUTHAPATTI, 1 THENI', 'phone': '9600441889', 'gst': '33AWIPA5855H1ZM'},
    {'name': 'SREE GOWMARIYAMMAN PET INDUSTRIES', 'address': '355/J4, MADURAI MAIN ROAD KARUVELANNAYAKKANPATTY, THENI', 'phone': '9597915656', 'gst': '33EJSPM9648K1Z8'},
    {'name': 'ANNAI PRINTERS', 'address': '136,MADURAI ROAD,NEAR CANARA BANK, THENI', 'phone': '9965459431', 'gst': ''},
    {'name': 'GANESH STORE', 'address': '1A - FOREST ROAD THENI - 625531', 'phone': '9894271047', 'gst': '33AIPPG2194L1ZY'},
    {'name': 'K.T.BALAN AND SONS', 'address': '29 NRT MAIN ROAD THENI', 'phone': '8883899995', 'gst': '33ANJPV5809L1ZF'},
    {'name': 'SREE LAKSHMI ENTERPRISES', 'address': '19,Salimara Steet Allinagaram ,Theni Tamilnadu - 625531', 'phone': '8248008681', 'gst': '33BLAPL7359D1Z9'},
    {'name': 'AARUDHRA TRADERS', 'address': 'B5, Jeyam Nagar, Thanakkankulam, Harveypatti, Madurai , Tamilnadu , 625006', 'phone': '9626933512', 'gst': '33ARVPN7123P2ZZ'},
    {'name': 'PRAKASH (R.NAGAR)', 'address': '', 'phone': '', 'gst': ''},
    {'name': 'PACHAIYAPA TRADERS', 'address': '6/1, NESHAMANI LANE THIRUMALAPURAM BODINAYAKANUR THENI - 625513', 'phone': '8608650892', 'gst': '33AQJPG0937D1ZA'},
    {'name': 'KS & SONS', 'address': 'D.NO : 104 Jaganathan Street,Old Tvs Road Theni - 625531', 'phone': '9965787532', 'gst': '33BLEPP5117P1ZS'},
  ];

  // ==========================================
  // DIALOGS
  // ==========================================
  void _showCreateVendorDialog(BuildContext context) {
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
                      const Text("Create Vendor", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                      InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 20, color: Colors.grey)),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey.shade300),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dialogField("Vendor Name", maxLines: 1),
                      const SizedBox(height: 15),
                      _dialogField("Address", maxLines: 3),
                      const SizedBox(height: 15),
                      _dialogField("Phone Number", maxLines: 1),
                      const SizedBox(height: 15),
                      _dialogField("GST Number", maxLines: 1),
                      const SizedBox(height: 25),
                      Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 10,
                        children: [
                          _dialogBtn("Close", const Color(0xFF6C757D), () => Navigator.pop(context)),
                          _dialogBtn("Save", const Color(0xFF0D47A1), () => Navigator.pop(context)),
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

  void _showEditVendorDialog(BuildContext context, Map<String, String> vendor) {
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
                      const Text("Edit Vendor", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                      InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 20, color: Colors.grey)),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey.shade300),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dialogField("Vendor Name", maxLines: 1, initialValue: vendor['name']),
                      const SizedBox(height: 15),
                      _dialogField("Address", maxLines: 3, initialValue: vendor['address']),
                      const SizedBox(height: 15),
                      _dialogField("Phone Number", maxLines: 1, initialValue: vendor['phone']),
                      const SizedBox(height: 15),
                      _dialogField("GST Number", maxLines: 1, initialValue: vendor['gst']),
                      const SizedBox(height: 25),
                      Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 10,
                        children: [
                          _dialogBtn("Close", const Color(0xFF6C757D), () => Navigator.pop(context)),
                          _dialogBtn("Save", const Color(0xFF0D47A1), () => Navigator.pop(context)),
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
                  width: 80, height: 80,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 4)),
                  child: const Center(child: Text("!", style: TextStyle(fontSize: 50, color: Color(0xFFF8BB86), fontWeight: FontWeight.w300))),
                ),
                const SizedBox(height: 25),
                const Text("Are you sure?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                const Text("You won't be able to revert this!", style: TextStyle(fontSize: 14, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 30),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10, runSpacing: 10,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC3545), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
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

  Widget _dialogField(String label, {int maxLines = 1, String? initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black87)),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: initialValue,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Colors.blue)),
          ),
        ),
      ],
    );
  }

  Widget _dialogBtn(String label, Color color, VoidCallback onTap) {
    return SizedBox(
      height: 38,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
      ),
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
              title: const Text("Vendor Master", style: TextStyle(color: Colors.black, fontSize: 16)),
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const SizedBox(width: 250, child: MasterPrimarySidebar()),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) const VendorTopbar(),
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
        const Text("Vendor Master", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
        if (!isTablet) const Spacer(),
        if (isTablet) const SizedBox(height: 15),
        
        SizedBox(
          width: isTablet ? double.infinity : null,
          height: 38,
          child: ElevatedButton.icon(
            onPressed: () => _showCreateVendorDialog(context),
            icon: const Icon(Icons.add, size: 18, color: Colors.white),
            label: const Text("Create New Vendor", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Search by name...", hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                          prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey),
                          border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text("Showing 10 of 74 records", style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
            child: const Row(
              children: [
                SizedBox(width: 50, child: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), // Added S.No Column Header
                Expanded(flex: 3, child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                Expanded(flex: 4, child: Text("Address", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                Expanded(flex: 2, child: Text("Phone", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                Expanded(flex: 2, child: Text("GST Number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                SizedBox(width: 80, child: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center)),
              ],
            ),
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: vendors.length,
            separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              final v = vendors[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    SizedBox(width: 50, child: Text("${index + 1}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87))), // Added S.No Row value
                    Expanded(flex: 3, child: Text(v['name']!, style: const TextStyle(fontSize: 12, color: Colors.black87))),
                    Expanded(flex: 4, child: Text(v['address']!, style: const TextStyle(fontSize: 12, color: Colors.black87), maxLines: 2, overflow: TextOverflow.ellipsis)),
                    Expanded(flex: 2, child: Text(v['phone']!, style: const TextStyle(fontSize: 12, color: Colors.black87))),
                    Expanded(flex: 2, child: Text(v['gst']!, style: const TextStyle(fontSize: 12, color: Colors.black87))),
                    SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _actionBtn(Icons.edit_outlined, Colors.blue, () => _showEditVendorDialog(context, v)),
                          const SizedBox(width: 8),
                          _actionBtn(Icons.delete_outline, Colors.red, () => _showDeleteDialog(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          
          Divider(height: 1, color: Colors.grey.shade300),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _pageBtn("Previous"),
                  _pageBtn("1", isActive: true),
                  _pageBtn("2"), _pageBtn("3"), _pageBtn("4"), _pageBtn("5"), _pageBtn("6"), _pageBtn("7"), _pageBtn("8"),
                  _pageBtn("Next"),
                ],
              ),
            ),
          )
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
        icon: Icon(icon, size: 14, color: color),
        onPressed: onTap,
      ),
    );
  }

  Widget _pageBtn(String text, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0D47A1) : Colors.white,
        border: Border.all(color: isActive ? const Color(0xFF0D47A1) : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: TextStyle(color: isActive ? Colors.white : Colors.blue, fontSize: 12)),
    );
  }
}

// ==========================================
// 2. SECONDARY SIDEBAR
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
          _secMenuItem(context, Icons.sell_outlined, "Material Type Master", destination: MaterialTypeMasterPage()),
          _secMenuItem(context, Icons.group_outlined, "Vendor Master", isActive: true),
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
          if (destination != null) {
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
                
                // MASTERS ACTIVE
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
// 4. TOPBAR
// ==========================================
class VendorTopbar extends StatelessWidget {
  const VendorTopbar({super.key});
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
          const Text("Home / Purchase Section / Masters / Rm Vendors", style: TextStyle(color: Colors.grey, fontSize: 13)),
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
// 5. MOBILE SECONDARY MENU
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
          _mobChip(context, "Material Type Master", destination: MaterialTypeMasterPage()), 
          _mobChip(context, "Vendor Master", isActive: true), 
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