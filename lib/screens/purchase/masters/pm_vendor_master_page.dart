import 'package:flutter/material.dart';
import 'subsidebar.dart'; // Import unified layout
import 'package:gowmari_mobile/screens/components/app_sidebar.dart'; 

class Vendor {
  final String name;
  final String address;
  final String phone;
  final String gst;

  Vendor({required this.name, required this.address, required this.phone, required this.gst});
}

class PMVendorMasterPage extends StatefulWidget {
  const PMVendorMasterPage({super.key});

  @override
  State<PMVendorMasterPage> createState() => _PMVendorMasterPageState();
}

class _PMVendorMasterPageState extends State<PMVendorMasterPage> {
  final List<Vendor> vendors = [
    Vendor(name: "MILK (LPM)", address: "", phone: "", gst: ""),
    Vendor(name: "VENDOR3", address: "Theni", phone: "7259036351", gst: ""),
    Vendor(name: "Testvendors", address: "", phone: "", gst: ""),
    Vendor(name: "vendor1", address: "aa", phone: "9654223211", gst: "1"),
    Vendor(name: "test", address: "test", phone: "", gst: ""),
  ];

  int _currentPage = 1;
  final int _itemsPerPage = 10;

  List<Vendor> get paginatedVendors {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (startIndex >= vendors.length) return [];
    if (endIndex > vendors.length) endIndex = vendors.length;
    return vendors.sublist(startIndex, endIndex);
  }

  void _showVendorDialog({Vendor? vendor}) {
    bool isEdit = vendor != null;
    final nameCtrl = TextEditingController(text: vendor?.name ?? "");
    final addrCtrl = TextEditingController(text: vendor?.address ?? "");
    final phoneCtrl = TextEditingController(text: vendor?.phone ?? "");
    final gstCtrl = TextEditingController(text: vendor?.gst ?? "");

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Container(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 20, top: 20, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(isEdit ? "Edit Packaging Vendor" : "Create Packaging Vendor", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
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
                    _fieldLabel("Vendor Name"), _textField(nameCtrl), const SizedBox(height: 16),
                    _fieldLabel("Address"), _textField(addrCtrl, maxLines: 3), const SizedBox(height: 16),
                    _fieldLabel("Phone Number"), _textField(phoneCtrl), const SizedBox(height: 16),
                    _fieldLabel("GST Number"), _textField(gstCtrl), const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), 
                          child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600))
                        ), const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context), 
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), elevation: 2, shadowColor: const Color(0xFF2962FF).withOpacity(0.4), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), 
                          child: const Text("Save Changes", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        elevation: 10,
        child: Container(
          width: 400, padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle), child: const Center(child: Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 40))),
              const SizedBox(height: 24),
              const Text("Are you sure?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)), const SizedBox(height: 12),
              Text("This action cannot be undone. You won't be able to revert this!", style: TextStyle(color: Colors.grey.shade600, fontSize: 14, height: 1.5), textAlign: TextAlign.center), const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600)))), const SizedBox(width: 16),
                  Expanded(child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, elevation: 2, shadowColor: Colors.redAccent.withOpacity(0.4), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Delete", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)));
  
  Widget _textField(TextEditingController ctrl, {int maxLines = 1}) => TextFormField(
    controller: ctrl, maxLines: maxLines, 
    decoration: InputDecoration(filled: true, fillColor: Colors.grey.shade50, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2962FF), width: 1.5))), 
    style: const TextStyle(fontSize: 14)
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;
    bool isTablet = screenWidth < 850;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: AppSidebar(activeMenu: "Masters")) : null,

      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const AppSidebar(activeMenu: "Masters"),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) const MasterTopbar(breadcrumb: "Home / Purchase Section / Masters / Packaging Vendors"),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isTablet) const SizedBox(width: 260, child: SecondaryMastersSidebar(activePage: 'PM Vendor Master')),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(30), // Increased padding
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isTablet) const MobileSecondaryMenu(activePage: 'PM Vendor Master'),
                              if (isTablet) const SizedBox(height: 20),
                              _buildHeader(isTablet),
                              const SizedBox(height: 24),
                              _buildTable(),
                            ],
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

  Widget _buildHeader(bool isTablet) {
    return Flex(
      direction: isTablet ? Axis.vertical : Axis.horizontal,
      crossAxisAlignment: isTablet ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        const Text("Packaging Vendor Master", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1A237E))), // Modern Header
        if (!isTablet) const Spacer(),
        if (isTablet) const SizedBox(height: 15),
        SizedBox(
          width: isTablet ? double.infinity : null, height: 44,
          child: ElevatedButton.icon(
            onPressed: () => _showVendorDialog(), icon: const Icon(Icons.add, size: 18, color: Colors.white),
            label: const Text("Create New Vendor", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), shadowColor: const Color(0xFF2962FF).withOpacity(0.4), elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), // Pill shape
          ),
        ),
      ],
    );
  }

  Widget _buildTable() {
    return Container(
      width: double.infinity, 
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 5))]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 350, height: 44, 
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)), 
                    child: const TextField(decoration: InputDecoration(hintText: "Search by name...", hintStyle: TextStyle(fontSize: 14, color: Colors.grey), prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 12)))
                  ),
                  Text("Showing 1 to 5 of 5 records", style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), 
              color: const Color(0xFFF8FAFC), // Modern header
              child: const Row(children: [SizedBox(width: 60, child: Text("S.NO", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), Expanded(flex: 3, child: Text("NAME", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), Expanded(flex: 4, child: Text("ADDRESS", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), Expanded(flex: 2, child: Text("PHONE", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), Expanded(flex: 2, child: Text("GST NUMBER", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), SizedBox(width: 100, child: Text("ACTIONS", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey), textAlign: TextAlign.center))]),
            ),
            ListView.separated(
              shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: paginatedVendors.length, 
              separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade100),
              itemBuilder: (context, index) {
                final v = paginatedVendors[index];
                int sNo = (_currentPage - 1) * _itemsPerPage + index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  child: Row(
                    children: [
                      SizedBox(width: 60, child: Text("$sNo", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87))),
                      Expanded(flex: 3, child: Text(v.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87))),
                      Expanded(flex: 4, child: Text(v.address, style: const TextStyle(fontSize: 13, color: Colors.black54), maxLines: 2, overflow: TextOverflow.ellipsis)),
                      Expanded(flex: 2, child: Text(v.phone, style: const TextStyle(fontSize: 13, color: Colors.black87))),
                      Expanded(flex: 2, child: Text(v.gst, style: const TextStyle(fontSize: 13, color: Colors.black87))),
                      SizedBox(width: 100, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [_actionIcon(Icons.edit_rounded, Colors.blueAccent, () => _showVendorDialog(vendor: v)), const SizedBox(width: 12), _actionIcon(Icons.delete_outline_rounded, Colors.redAccent, _showDeleteDialog)])),
                    ],
                  ),
                );
              },
            ),
            Container(decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))), child: _buildPagination()), 
          ],
        ),
      ),
    );
  }

  Widget _actionIcon(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36, height: 36, 
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  Widget _buildPagination() {
    int totalPages = (vendors.length / _itemsPerPage).ceil();
    if (totalPages <= 1) totalPages = 1;

    List<Widget> pageButtons = [];
    pageButtons.add(_pageBox("Prev", false, () { if (_currentPage > 1) setState(() => _currentPage--); }));
    pageButtons.add(const SizedBox(width: 8));

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(_pageBox("$i", _currentPage == i, () { setState(() => _currentPage = i); }));
      if (i < totalPages) pageButtons.add(const SizedBox(width: 8));
    }

    pageButtons.add(const SizedBox(width: 8));
    pageButtons.add(_pageBox("Next", false, () { if (_currentPage < totalPages) setState(() => _currentPage++); }));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: pageButtons,
      ),
    );
  }

  Widget _pageBox(String t, bool active, VoidCallback onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), 
      decoration: BoxDecoration(color: active ? const Color(0xFF2962FF) : Colors.transparent, border: Border.all(color: active ? const Color(0xFF2962FF) : Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), 
      child: Text(t, style: TextStyle(color: active ? Colors.white : Colors.black87, fontSize: 13, fontWeight: active ? FontWeight.bold : FontWeight.w500))
    ),
  );
}