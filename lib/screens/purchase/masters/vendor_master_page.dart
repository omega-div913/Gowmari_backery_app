import 'package:flutter/material.dart';
import 'subsidebar.dart'; // Import unified layout

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
                      _dialogField("Vendor Name", maxLines: 1), const SizedBox(height: 15),
                      _dialogField("Address", maxLines: 3), const SizedBox(height: 15),
                      _dialogField("Phone Number", maxLines: 1), const SizedBox(height: 15),
                      _dialogField("GST Number", maxLines: 1), const SizedBox(height: 25),
                      Wrap(
                        alignment: WrapAlignment.end, spacing: 10,
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
                      _dialogField("Vendor Name", maxLines: 1, initialValue: vendor['name']), const SizedBox(height: 15),
                      _dialogField("Address", maxLines: 3, initialValue: vendor['address']), const SizedBox(height: 15),
                      _dialogField("Phone Number", maxLines: 1, initialValue: vendor['phone']), const SizedBox(height: 15),
                      _dialogField("GST Number", maxLines: 1, initialValue: vendor['gst']), const SizedBox(height: 25),
                      Wrap(
                        alignment: WrapAlignment.end, spacing: 10,
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
            width: 400, padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 4)), child: const Center(child: Text("!", style: TextStyle(fontSize: 50, color: Color(0xFFF8BB86), fontWeight: FontWeight.w300)))),
                const SizedBox(height: 25),
                const Text("Are you sure?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                const Text("You won't be able to revert this!", style: TextStyle(fontSize: 14, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 30),
                Wrap(
                  alignment: WrapAlignment.center, spacing: 10, runSpacing: 10,
                  children: [
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC3545), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))), onPressed: () => Navigator.pop(context), child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white, fontSize: 14))),
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))), onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 14))),
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
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black87)), const SizedBox(height: 6),
        TextFormField(initialValue: initialValue, maxLines: maxLines, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Colors.blue)))),
      ],
    );
  }

  Widget _dialogBtn(String label, Color color, VoidCallback onTap) {
    return SizedBox(height: 38, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: color, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), onPressed: onTap, child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold))));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;
    bool isTablet = screenWidth < 850;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: MasterPrimarySidebar()) : null,
      appBar: isMobile ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Vendor Master", style: TextStyle(color: Colors.black, fontSize: 16))) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const SizedBox(width: 250, child: MasterPrimarySidebar()),
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
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isTablet) const MobileSecondaryMenu(activePage: 'Vendor Master'),
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
          width: isTablet ? double.infinity : null, height: 38,
          child: ElevatedButton.icon(onPressed: () => _showCreateVendorDialog(context), icon: const Icon(Icons.add, size: 18, color: Colors.white), label: const Text("Create New Vendor", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), elevation: 0)),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 300), child: Container(height: 38, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)), child: const TextField(decoration: InputDecoration(hintText: "Search by name...", hintStyle: TextStyle(fontSize: 13, color: Colors.grey), prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 12)))))),
                const SizedBox(width: 10),
                const Text("Showing 10 of 74 records", style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
            child: const Row(children: [SizedBox(width: 50, child: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), Expanded(flex: 3, child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), Expanded(flex: 4, child: Text("Address", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), Expanded(flex: 2, child: Text("Phone", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), Expanded(flex: 2, child: Text("GST Number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), SizedBox(width: 80, child: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center))]),
          ),
          ListView.separated(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: vendors.length, separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              final v = vendors[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    SizedBox(width: 50, child: Text("${index + 1}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87))),
                    Expanded(flex: 3, child: Text(v['name']!, style: const TextStyle(fontSize: 12, color: Colors.black87))),
                    Expanded(flex: 4, child: Text(v['address']!, style: const TextStyle(fontSize: 12, color: Colors.black87), maxLines: 2, overflow: TextOverflow.ellipsis)),
                    Expanded(flex: 2, child: Text(v['phone']!, style: const TextStyle(fontSize: 12, color: Colors.black87))),
                    Expanded(flex: 2, child: Text(v['gst']!, style: const TextStyle(fontSize: 12, color: Colors.black87))),
                    SizedBox(width: 80, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [_actionBtn(Icons.edit_outlined, Colors.blue, () => _showEditVendorDialog(context, v)), const SizedBox(width: 8), _actionBtn(Icons.delete_outline, Colors.red, () => _showDeleteDialog(context))])),
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
                children: [_pageBtn("Previous"), _pageBtn("1", isActive: true), _pageBtn("2"), _pageBtn("3"), _pageBtn("4"), _pageBtn("5"), _pageBtn("6"), _pageBtn("7"), _pageBtn("8"), _pageBtn("Next")],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: 30, height: 30, decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)),
      child: IconButton(padding: EdgeInsets.zero, icon: Icon(icon, size: 14, color: color), onPressed: onTap),
    );
  }

  Widget _pageBtn(String text, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: isActive ? const Color(0xFF0D47A1) : Colors.white, border: Border.all(color: isActive ? const Color(0xFF0D47A1) : Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
      child: Text(text, style: TextStyle(color: isActive ? Colors.white : Colors.blue, fontSize: 12)),
    );
  }
}