import 'package:flutter/material.dart';
import 'subsidebar.dart'; // Import unified layout
import 'package:gowmari_mobile/screens/components/app_sidebar.dart'; 

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

  void _showCreateVendorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Modern rounded corners
          backgroundColor: Colors.white,
          elevation: 10,
          child: SizedBox(
            width: 550,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 20, top: 20, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Create Vendor", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                      InkWell(
                        onTap: () => Navigator.pop(context), 
                        borderRadius: BorderRadius.circular(20),
                        child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle), child: Icon(Icons.close, size: 18, color: Colors.grey.shade700))
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey.shade200),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dialogField("Vendor Name", maxLines: 1), const SizedBox(height: 16),
                      _dialogField("Address", maxLines: 3), const SizedBox(height: 16),
                      _dialogField("Phone Number", maxLines: 1), const SizedBox(height: 16),
                      _dialogField("GST Number", maxLines: 1), const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _dialogBtn("Cancel", isPrimary: false, onTap: () => Navigator.pop(context)),
                          const SizedBox(width: 12),
                          _dialogBtn("Save Vendor", isPrimary: true, onTap: () => Navigator.pop(context)),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          elevation: 10,
          child: SizedBox(
            width: 550,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 20, top: 20, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Edit Vendor", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                      InkWell(
                        onTap: () => Navigator.pop(context), 
                        borderRadius: BorderRadius.circular(20),
                        child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle), child: Icon(Icons.close, size: 18, color: Colors.grey.shade700))
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey.shade200),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dialogField("Vendor Name", maxLines: 1, initialValue: vendor['name']), const SizedBox(height: 16),
                      _dialogField("Address", maxLines: 3, initialValue: vendor['address']), const SizedBox(height: 16),
                      _dialogField("Phone Number", maxLines: 1, initialValue: vendor['phone']), const SizedBox(height: 16),
                      _dialogField("GST Number", maxLines: 1, initialValue: vendor['gst']), const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _dialogBtn("Cancel", isPrimary: false, onTap: () => Navigator.pop(context)),
                          const SizedBox(width: 12),
                          _dialogBtn("Update Vendor", isPrimary: true, onTap: () => Navigator.pop(context)),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          elevation: 10,
          child: Container(
            width: 400, padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container( // Modern icon container
                  width: 80, height: 80, 
                  decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle), 
                  child: const Center(child: Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 40))
                ),
                const SizedBox(height: 24),
                const Text("Delete Vendor?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87), textAlign: TextAlign.center),
                const SizedBox(height: 12),
                Text("This action cannot be undone. Are you sure you want to permanently delete this vendor?", style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5), textAlign: TextAlign.center),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), 
                        onPressed: () => Navigator.pop(context), 
                        child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600))
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, elevation: 2, shadowColor: Colors.redAccent.withOpacity(0.4), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), 
                        onPressed: () => Navigator.pop(context), 
                        child: const Text("Delete", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
                      ),
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
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)), const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue, 
          maxLines: maxLines, 
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), 
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none), 
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2962FF), width: 1.5))
          )
        ),
      ],
    );
  }

  Widget _dialogBtn(String label, {required bool isPrimary, required VoidCallback onTap}) {
    if (isPrimary) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), elevation: 2, shadowColor: const Color(0xFF2962FF).withOpacity(0.4), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), 
        onPressed: onTap, 
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
      );
    } else {
      return TextButton(
        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), 
        onPressed: onTap, 
        child: Text(label, style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;
    bool isTablet = screenWidth < 850;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: AppSidebar(activeMenu: "Masters")) : null,

      appBar: isMobile ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Vendor Master", style: TextStyle(color: Colors.black, fontSize: 16))) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const AppSidebar(activeMenu: "Masters"),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) const MasterTopbar(breadcrumb: "Home / Purchase Section / Masters / RM Vendors"),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isTablet) const SizedBox(width: 260, child: SecondaryMastersSidebar(activePage: 'Vendor Master')),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(30), // Increased padding
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isTablet) const MobileSecondaryMenu(activePage: 'Vendor Master'),
                                if (isTablet) const SizedBox(height: 20),
                                _buildPageHeader(context, isTablet), 
                                const SizedBox(height: 24),
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
        const Text("Vendor Master", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1A237E))), // Modern Header
        if (!isTablet) const Spacer(),
        if (isTablet) const SizedBox(height: 15),
        SizedBox(
          width: isTablet ? double.infinity : null, height: 44,
          child: ElevatedButton.icon(
            onPressed: () => _showCreateVendorDialog(context), 
            icon: const Icon(Icons.add, size: 18, color: Colors.white), 
            label: const Text("Create New Vendor", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)), 
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), shadowColor: const Color(0xFF2962FF).withOpacity(0.4), elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))) // Pill shape
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16), 
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 5))]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 350), 
                      child: Container(
                        height: 44, 
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)), 
                        child: TextField(decoration: InputDecoration(hintText: "Search by name...", hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400), prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey.shade500), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 12)))
                      )
                    )
                  ),
                  const SizedBox(width: 10),
                  Text("Showing 10 of 74 records", style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), 
              color: const Color(0xFFF8FAFC), // Modern header
              child: const Row(children: [SizedBox(width: 60, child: Text("S.NO", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), Expanded(flex: 3, child: Text("NAME", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), Expanded(flex: 4, child: Text("ADDRESS", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), Expanded(flex: 2, child: Text("PHONE", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), Expanded(flex: 2, child: Text("GST NUMBER", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), SizedBox(width: 100, child: Text("ACTIONS", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey), textAlign: TextAlign.center))]),
            ),
            ListView.separated(
              shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: vendors.length, 
              separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade100),
              itemBuilder: (context, index) {
                final v = vendors[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  child: Row(
                    children: [
                      SizedBox(width: 60, child: Text("${index + 1}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87))),
                      Expanded(flex: 3, child: Text(v['name']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87))),
                      Expanded(flex: 4, child: Text(v['address']!, style: const TextStyle(fontSize: 13, color: Colors.black54), maxLines: 2, overflow: TextOverflow.ellipsis)),
                      Expanded(flex: 2, child: Text(v['phone']!, style: const TextStyle(fontSize: 13, color: Colors.black87))),
                      Expanded(flex: 2, child: Text(v['gst']!, style: const TextStyle(fontSize: 13, color: Colors.black87))),
                      SizedBox(width: 100, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [_actionBtn(Icons.edit_rounded, Colors.blueAccent, () => _showEditVendorDialog(context, v)), const SizedBox(width: 12), _actionBtn(Icons.delete_outline_rounded, Colors.redAccent, () => _showDeleteDialog(context))])),
                    ],
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))),
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_pageBtn("Previous"), const SizedBox(width: 8), _pageBtn("1", isActive: true), const SizedBox(width: 8), _pageBtn("2"), const SizedBox(width: 8), _pageBtn("3"), const SizedBox(width: 8), _pageBtn("4"), const SizedBox(width: 8), _pageBtn("5"), const SizedBox(width: 8), _pageBtn("6"), const SizedBox(width: 8), _pageBtn("Next")],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36, height: 36, 
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  Widget _pageBtn(String text, {bool isActive = false}) {
    return InkWell(
      onTap: () {}, // Add logic as needed
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(color: isActive ? const Color(0xFF2962FF) : Colors.transparent, border: Border.all(color: isActive ? const Color(0xFF2962FF) : Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Text(text, style: TextStyle(color: isActive ? Colors.white : Colors.black87, fontSize: 13, fontWeight: isActive ? FontWeight.bold : FontWeight.w500)),
      ),
    );
  }
}