import 'package:flutter/material.dart';
import 'subsidebar.dart'; // Import unified layout

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 450, padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(isEdit ? "Edit Packaging Vendor" : "Create Packaging Vendor", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 20)),
                ],
              ),
              const SizedBox(height: 20),
              _fieldLabel("Vendor Name"), _textField(nameCtrl), const SizedBox(height: 15),
              _fieldLabel("Address"), _textField(addrCtrl, maxLines: 3), const SizedBox(height: 15),
              _fieldLabel("Phone Number"), _textField(phoneCtrl), const SizedBox(height: 15),
              _fieldLabel("GST Number"), _textField(gstCtrl), const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), elevation: 0), child: const Text("Close", style: TextStyle(color: Colors.white))), const SizedBox(width: 10),
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), elevation: 0), child: const Text("Save Changes", style: TextStyle(color: Colors.white))),
                ],
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 400, padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 80, width: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 3)), child: const Center(child: Text("!", style: TextStyle(fontSize: 45, color: Color(0xFFF8BB86))))),
              const SizedBox(height: 20),
              const Text("Are you sure?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 8),
              const Text("You won't be able to revert this!", style: TextStyle(color: Colors.grey, fontSize: 14)), const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC3545), elevation: 0), child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white))), const SizedBox(width: 10),
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), elevation: 0), child: const Text("Cancel", style: TextStyle(color: Colors.white))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87)));
  Widget _textField(TextEditingController ctrl, {int maxLines = 1}) => Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)), child: TextField(controller: ctrl, maxLines: maxLines, decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)), style: const TextStyle(fontSize: 14)));

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;
    bool isTablet = screenWidth < 850;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: MasterPrimarySidebar()) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const SizedBox(width: 250, child: MasterPrimarySidebar()),
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
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isTablet) const MobileSecondaryMenu(activePage: 'PM Vendor Master'),
                              _buildHeader(isTablet),
                              const SizedBox(height: 20),
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Packaging Vendor Master", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            ElevatedButton.icon(
              onPressed: () => _showVendorDialog(), icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: const Text("Create New Vendor", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: 350, height: 40, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)), child: const TextField(decoration: InputDecoration(hintText: "Search by name...", prefixIcon: Icon(Icons.search, size: 18), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 10)))),
          ],
        )
      ],
    );
  }

  Widget _buildTable() {
    return Container(
      width: double.infinity, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                    columns: const [DataColumn(label: Text('S.No')), DataColumn(label: Text('Name')), DataColumn(label: Text('Address')), DataColumn(label: Text('Phone')), DataColumn(label: Text('GST Number')), DataColumn(label: Text('Actions'))],
                    rows: paginatedVendors.asMap().entries.map((entry) {
                      int index = entry.key; Vendor v = entry.value; int sNo = (_currentPage - 1) * _itemsPerPage + index + 1; 
                      return DataRow(cells: [
                        DataCell(Text('$sNo', style: const TextStyle(fontWeight: FontWeight.bold))), 
                        DataCell(Text(v.name)), DataCell(Text(v.address)), DataCell(Text(v.phone)), DataCell(Text(v.gst)),
                        DataCell(Row(children: [_actionIcon(Icons.edit_outlined, Colors.blue, () => _showVendorDialog(vendor: v)), const SizedBox(width: 8), _actionIcon(Icons.delete_outline, Colors.red, _showDeleteDialog)])),
                      ]);
                    }).toList(),
                  ),
                ),
              );
            }
          ),
          const Divider(height: 1),
          _buildPagination(), 
        ],
      ),
    );
  }

  Widget _actionIcon(IconData icon, Color color, VoidCallback onTap) {
    return Container(width: 30, height: 30, decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)), child: IconButton(padding: EdgeInsets.zero, icon: Icon(icon, size: 16, color: color), onPressed: onTap));
  }

  Widget _buildPagination() {
    int totalPages = (vendors.length / _itemsPerPage).ceil();
    if (totalPages <= 1) totalPages = 1;

    List<Widget> pageButtons = [];
    pageButtons.add(_pageBox("Prev", false, () { if (_currentPage > 1) setState(() => _currentPage--); }));
    pageButtons.add(const SizedBox(width: 5));

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(_pageBox("$i", _currentPage == i, () { setState(() => _currentPage = i); }));
      if (i < totalPages) pageButtons.add(const SizedBox(width: 5));
    }

    pageButtons.add(const SizedBox(width: 5));
    pageButtons.add(_pageBox("Next", false, () { if (_currentPage < totalPages) setState(() => _currentPage++); }));

    int startRecord = vendors.isEmpty ? 0 : ((_currentPage - 1) * _itemsPerPage) + 1;
    int endRecord = _currentPage * _itemsPerPage;
    if (endRecord > vendors.length) endRecord = vendors.length;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Showing $startRecord to $endRecord of ${vendors.length} records", style: const TextStyle(fontSize: 13, color: Colors.grey)),
          Wrap(alignment: WrapAlignment.center, spacing: 2, runSpacing: 8, children: pageButtons),
        ],
      ),
    );
  }

  Widget _pageBox(String t, bool active, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), 
      decoration: BoxDecoration(color: active ? Colors.blue : Colors.white, border: Border.all(color: active ? Colors.blue : Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), 
      child: Text(t, style: TextStyle(color: active ? Colors.white : Colors.blue, fontSize: 12, fontWeight: FontWeight.bold))
    ),
  );
}