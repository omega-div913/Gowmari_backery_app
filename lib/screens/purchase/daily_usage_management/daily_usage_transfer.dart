import 'package:flutter/material.dart';
import '../../components/app_sidebar.dart';
import 'subsidebar.dart';
import 'daily_usage_manual_batch.dart';

class DailyUsageTransferPage extends StatefulWidget {
  const DailyUsageTransferPage({super.key});

  @override
  State<DailyUsageTransferPage> createState() => _DailyUsageTransferPageState();
}

class _DailyUsageTransferPageState extends State<DailyUsageTransferPage> {
  String selectedTab = "Batch 01";
  bool pendingOnly = true;

  // --- Edit Mode State ---
  bool _isEditingOrder = false;
  Map<String, dynamic>? _editingOrderData;
  String _editSelectedTab = "ALL";
  
  final List<String> _editTabs = [
    "ALL", "BAKERY", "CHAT MATERIAL", "CLEANING MATERIAL", 
    "PACKING MATERIAL", "RAW MATERIAL", "SERVICE MATERIAL", 
    "TEA COFFE MATERIAL", "VADA MATERIAL"
  ];

  // Exact Dummy Data for the Edit Grid based on your screenshots
  final List<Map<String, dynamic>> _editDummyItems = [
    {"name": "MILK 1 Lit", "category": "BAKERY", "price": "43", "unit": "ltr", "origQty": "145.00", "adjQty": "145"},
    {"name": "WATER CAN 20 LIT", "category": "SERVICE MATERIAL", "price": "20", "unit": "pcs", "origQty": "8.00", "adjQty": "8"},
    {"name": "1 kg P.P Cover", "category": "PACKING MATERIAL", "price": "7", "unit": "kg", "origQty": "-", "adjQty": "-"},
    {"name": "1 kg Birthday Cake Box", "category": "PACKING MATERIAL", "price": "18.48", "unit": "pcs", "origQty": "-", "adjQty": "-"},
    {"name": "1 kg Cake Bag", "category": "PACKING MATERIAL", "price": "8.62", "unit": "pcs", "origQty": "-", "adjQty": "-"},
    {"name": "1 kg Square Cake Bottom", "category": "PACKING MATERIAL", "price": "8.79", "unit": "pcs", "origQty": "-", "adjQty": "-"},
    {"name": "1 kg Sweet Box", "category": "PACKING MATERIAL", "price": "16.80", "unit": "pcs", "origQty": "-", "adjQty": "-"},
    {"name": "1 kg Sweet Container", "category": "PACKING MATERIAL", "price": "17.5", "unit": "pcs", "origQty": "-", "adjQty": "-"},
    {"name": "1 kg Sweet Sticker New (100 gms = 19 Pcs)", "category": "PACKING MATERIAL", "price": "2.46", "unit": "pcs", "origQty": "-", "adjQty": "-"},
    {"name": "1 Parcel Covers", "category": "SERVICE MATERIAL", "price": "71.4", "unit": "pkt", "origQty": "-", "adjQty": "-"},
    {"name": "1.5 kg Square Cake Bottom", "category": "PACKING MATERIAL", "price": "9.79", "unit": "pcs", "origQty": "-", "adjQty": "-"},
  ];

  // --- Main Table Data ---
  final List<Map<String, dynamic>> _transferData = [
    {
      "batch": "rb260517-033",
      "bills": "2002, 2001",
      "sections": {"SERVICE MATERIAL": "8.00", "BAKERY": "145.00"},
      "outlet": "AL",
      "date": "17-05-2026",
      "time": "04:57 PM",
      "qty": "153.00",
      "amount": "6395.00",
      "status": "Pending"
    },
    {
      "batch": "rb260517-038",
      "bills": "2012",
      "sections": {"BAKERY": "132.00"},
      "outlet": "AMBA",
      "date": "17-05-2026",
      "time": "04:57 PM",
      "qty": "132.00",
      "amount": "5676.00",
      "status": "Pending"
    },
    {
      "batch": "rb260517-036",
      "bills": "2008, 2007, 2009",
      "sections": {"SERVICE MATERIAL": "11.00", "BAKERY": "130.00", "TEA COFFE MATERIAL": "5.00"},
      "outlet": "BODI-1",
      "date": "17-05-2026",
      "time": "04:57 PM",
      "qty": "146.00",
      "amount": "6255.00",
      "status": "Pending"
    },
    {
      "batch": "rb260517-034",
      "bills": "2004, 2003",
      "sections": {"SERVICE MATERIAL": "7.00", "BAKERY": "125.00"},
      "outlet": "FOREST ROAD",
      "date": "17-05-2026",
      "time": "04:57 PM",
      "qty": "132.00",
      "amount": "5515.00",
      "status": "Pending"
    },
    {
      "batch": "rb260517-035",
      "bills": "2006, 2005",
      "sections": {"SERVICE MATERIAL": "15.00", "BAKERY": "190.00"},
      "outlet": "ITI",
      "date": "17-05-2026",
      "time": "04:57 PM",
      "qty": "205.00",
      "amount": "8470.00",
      "status": "Pending"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F9),
      body: Row(
        children: [
          const AppSidebar(activeMenu: "Daily Usage Management"),
          Expanded(
            child: Column(
              children: [
                _buildExactHeader(),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DailyUsageSubSidebar(activePage: "Daily Usage Transfer"),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(25),
                          child: _isEditingOrder 
                              ? _buildEditOrderView() 
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildTopControls(),
                                    const SizedBox(height: 20),
                                    _buildTabs(),
                                    const SizedBox(height: 20),
                                    _buildDataTableContainer(),
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

  // ===========================================================================
  // EDIT ORDER VIEW (NEW)
  // ===========================================================================
  Widget _buildEditOrderView() {
    String outletName = _editingOrderData?['outlet'] ?? "AL";
    
    // Filter data based on tab
    List<Map<String, dynamic>> filteredItems = _editSelectedTab == "ALL" 
        ? _editDummyItems 
        : _editDummyItems.where((item) => item['category'] == _editSelectedTab).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Header
        Row(
          children: [
            InkWell(
              onTap: () => setState(() => _isEditingOrder = false),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back, color: Colors.white, size: 14),
                    SizedBox(width: 6),
                    Text("Back", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            const Icon(Icons.edit_square, color: Color(0xFFEAB308), size: 20),
            const SizedBox(width: 8),
            Text("Modify Order: $outletName", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            const SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: Colors.amber.shade400, borderRadius: BorderRadius.circular(12)),
              child: const Text("Pending Phase", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
            const Spacer(),
            Container(
              width: 250, height: 38,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Find material to modify...", hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  prefixIcon: Icon(Icons.search, size: 16, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.only(top: 6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),

        // Tabs
        Container(
          width: double.infinity,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _editTabs.map((tab) {
                bool isSelected = _editSelectedTab == tab;
                return InkWell(
                  onTap: () => setState(() => _editSelectedTab = tab),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isSelected ? const Color(0xFF0D6EFD) : Colors.transparent, width: 2))),
                    child: Text(
                      tab,
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF0D6EFD) : const Color(0xFF475569),
                        fontWeight: FontWeight.bold, fontSize: 12,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Data Grid Container
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
            border: Border.all(color: Colors.grey.shade200)
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(Colors.white),
                  dataRowHeight: 70,
                  columnSpacing: 40,
                  horizontalMargin: 25,
                  headingRowHeight: 50,
                  border: TableBorder(horizontalInside: BorderSide(color: Colors.grey.shade200)),
                  columns: const [
                    DataColumn(label: Text("MATERIAL NAME", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF64748B)))),
                    DataColumn(label: Text("PRICE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF64748B)))),
                    DataColumn(label: Text("UNIT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF64748B)))),
                    DataColumn(label: Text("ORIGINAL QTY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF64748B)))),
                    DataColumn(label: Text("ADJUSTED QTY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF0D6EFD)))),
                  ],
                  rows: filteredItems.map((item) {
                    bool hasQty = item['origQty'] != "-";
                    return DataRow(
                      cells: [
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B))),
                              Text("(${item['category']})", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF3B82F6))),
                            ],
                          ),
                        ),
                        DataCell(Text(item['price'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF3B82F6)))),
                        DataCell(Text(item['unit'], style: const TextStyle(fontSize: 13, color: Color(0xFF475569)))),
                        DataCell(
                          hasQty 
                            ? Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(color: const Color(0xFF64748B), borderRadius: BorderRadius.circular(20)),
                                child: Text(item['origQty'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                              )
                            : const Text("-", style: TextStyle(color: Colors.grey)),
                        ),
                        DataCell(
                          hasQty
                            ? SizedBox(
                                width: 90, height: 35,
                                child: TextField(
                                  controller: TextEditingController(text: item['adjQty']),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF0D6EFD))),
                                  ),
                                ),
                              )
                            : const Text("-", style: TextStyle(color: Colors.grey)),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 20),

        // Footer
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: const [
                    Text("Displaying: ", style: TextStyle(color: Color(0xFF475569), fontSize: 13, fontWeight: FontWeight.bold)),
                    Text("873", style: TextStyle(color: Color(0xFF1E293B), fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => setState(() => _isEditingOrder = false),
                icon: const Icon(Icons.save, size: 16),
                label: const Text("Update Order"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // MAIN VIEW LIST METHODS
  // ===========================================================================

  Widget _buildExactHeader() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Color(0xFF64748B), size: 20),
          const SizedBox(width: 20),
          const Text("Home / Purchase Section / Daily Usage Management / Transfer", style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
          const Spacer(),
          Container(
            width: 300, height: 38,
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search menus ( Press / )", hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.only(top: 6),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(radius: 16, backgroundColor: Color(0xFF0D6EFD), child: Text("R", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
          const SizedBox(width: 8),
          const Text("RTS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const Icon(Icons.arrow_drop_down, size: 20),
        ],
      ),
    );
  }

  Widget _buildTopControls() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 20,
      runSpacing: 15,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                const Text("Daily Usage Transfer", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(20)),
                  child: Text("19 Pending", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.amber.shade900)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text("Manage daily material dispatches to outlets", style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 180, height: 38,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Records...", hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, size: 16, color: Colors.grey),
                  filled: true, fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                ),
              ),
            ),
            Container(
              width: 130, height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: "All Outlets", isExpanded: true,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                  icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                  items: ["All Outlets", "AL", "AMBA"].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                  onChanged: (v) {},
                ),
              ),
            ),
            SizedBox(
              width: 130, height: 38,
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "17-05-2026", hintStyle: const TextStyle(fontSize: 13, color: Colors.black87),
                  suffixIcon: const Icon(Icons.calendar_month, size: 16, color: Colors.blue),
                  filled: true, fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.blue.shade200)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.blue.shade200)),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch(value: pendingOnly, onChanged: (v) => setState(() => pendingOnly = v), activeColor: Colors.blue, activeTrackColor: Colors.blue.shade100),
                const Text("Pending Only", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.local_shipping, size: 16), label: const Text("Dispatch All", style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DailyUsageManualBatchPage()));
              },
              icon: const Icon(Icons.add, size: 16), label: const Text("Manual Batch", style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildTabs() {
    List<String> tabs = ["Batch 01", "Batch 02", "Batch 03", "Batch 04", "main test"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...tabs.map((tab) => _tabItem(tab, Icons.access_time)),
          const SizedBox(width: 10),
          _tabItem("Quick Transfer", Icons.bolt, isSpecial: true),
        ],
      ),
    );
  }

  Widget _tabItem(String title, IconData icon, {bool isSpecial = false}) {
    bool isActive = selectedTab == title;
    return InkWell(
      onTap: () => setState(() => selectedTab = title),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0D6EFD) : Colors.white,
          border: Border.all(color: isActive ? const Color(0xFF0D6EFD) : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: isActive ? Colors.white : (isSpecial ? Colors.amber.shade600 : Colors.grey.shade600)),
            const SizedBox(width: 6),
            Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isActive ? Colors.white : Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTableContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, 
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(const Color(0xFFF8FAFC)),
          dataRowHeight: 90, columnSpacing: 25, horizontalMargin: 20,
          headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B), fontSize: 13),
          columns: const [
            DataColumn(label: SizedBox(width: 20, child: Icon(Icons.check_box_outline_blank, color: Colors.grey, size: 20))),
            DataColumn(label: Text("Batch\nCode")), DataColumn(label: Text("Bill No")), DataColumn(label: Text("Section Totals")),
            DataColumn(label: Text("Outlet Name")), DataColumn(label: Text("Date\n& Time")), DataColumn(label: Text("Total\nQty")),
            DataColumn(label: Text("Total\nAmount")), DataColumn(label: Text("Status")), DataColumn(label: Text("D.Status")),
            DataColumn(label: Text("Actions")), 
          ],
          rows: _transferData.asMap().entries.map((entry) {
            int index = entry.key; var data = entry.value;
            return DataRow(
              color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                return index % 2 != 0 ? const Color(0xFFF8FAFC) : Colors.white;
              }),
              cells: [
                const DataCell(Icon(Icons.check_box_outline_blank, color: Colors.grey, size: 20)),
                DataCell(Text(data['batch'], style: const TextStyle(color: Color(0xFF0D6EFD), fontWeight: FontWeight.w600, fontSize: 13))),
                DataCell(_buildBillPill(data['bills'])),
                DataCell(_buildSectionTotals((data['sections'] as Map).cast<String, String>())),
                DataCell(Text(data['outlet'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                DataCell(Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(data['date'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), Text(data['time'], style: const TextStyle(fontSize: 11, color: Colors.grey))])),
                DataCell(Text(data['qty'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                DataCell(Text("₹ ${data['amount']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF10B981), fontSize: 13))),
                DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.amber.shade200)), child: Text(data['status'], style: TextStyle(color: Colors.amber.shade600, fontSize: 11, fontWeight: FontWeight.bold)))),
                const DataCell(Text("-", style: TextStyle(color: Colors.grey))),
                DataCell(_buildActionRow(data)), 
              ]
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBillPill(String bills) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.blue.shade100)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.receipt_long, size: 14, color: Color(0xFF0D6EFD)),
          const SizedBox(width: 6),
          Text(bills, style: const TextStyle(fontSize: 12, color: Color(0xFF0D6EFD), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionTotals(Map<String, String> sections) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.entries.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: RichText(text: TextSpan(children: [TextSpan(text: "${e.key}: ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF334155))), TextSpan(text: e.value, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)))]))
        );
      }).toList(),
    );
  }

  Widget _buildActionRow(Map<String, dynamic> data) {
    return Row(
      children: [
        _iconBtn(Icons.visibility, const Color(0xFF06B6D4), onTap: () => _showViewDialog(data)),
        // EDIT BUTTON - OPENS EDIT VIEW
        _iconBtn(Icons.edit_square, const Color(0xFFEAB308), onTap: () => setState(() {
          _isEditingOrder = true;
          _editingOrderData = data;
          _editSelectedTab = "ALL";
        })), 
        _iconBtn(Icons.delete, const Color(0xFFEF4444), onTap: () => _showDeleteDialog()),
        const SizedBox(width: 8),
        _outlinedTextBtn("Full Bill"),
        _outlinedTextBtn("Mat. Bill", isBlue: true, onTap: () => _showMatBillDialog(data)),
        _outlinedTextBtn("Challan"),
        const SizedBox(width: 6),
        _filledTextBtn("Dispatch", const Color(0xFF0D6EFD)),
      ],
    );
  }

  Widget _iconBtn(IconData icon, Color color, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(4),
      child: Container(
        margin: const EdgeInsets.only(right: 6), padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4), border: Border.all(color: color.withOpacity(0.3))),
        child: Icon(icon, size: 14, color: color),
      ),
    );
  }

  Widget _outlinedTextBtn(String text, {bool isBlue = false, VoidCallback? onTap}) {
    Color color = isBlue ? const Color(0xFF0D6EFD) : Colors.grey.shade600;
    return InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(4),
      child: Container(
        margin: const EdgeInsets.only(right: 6), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: isBlue ? Colors.blue.shade200 : Colors.grey.shade300)),
        child: Row(children: [Icon(Icons.receipt, size: 12, color: color), const SizedBox(width: 4), Text(text, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold))]),
      ),
    );
  }

  Widget _filledTextBtn(String text, Color color) {
    return InkWell(
      onTap: (){}, borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        child: Text(text, style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // DIALOGS
  void _showViewDialog(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
          width: 550,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: const BoxDecoration(color: Color(0xFF06B6D4), borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Dispatch Details: ${data['batch']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: Colors.white, size: 20))
                  ]
                )
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(text: TextSpan(children: [const TextSpan(text: "Outlet: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)), TextSpan(text: data['outlet'], style: const TextStyle(color: Colors.black87, fontSize: 13))])),
                        RichText(text: TextSpan(children: [const TextSpan(text: "Date: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)), TextSpan(text: data['date'], style: const TextStyle(color: Colors.black87, fontSize: 13))])),
                      ]
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [const Text("Status: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)), child: Text(data['status'], style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)))]),
                        RichText(text: TextSpan(children: [const TextSpan(text: "Total: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13)), TextSpan(text: "₹ ${data['amount']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 13))])),
                      ]
                    ),
                    const Divider(height: 30, color: Color(0xFFE2E8F0)),
                    _buildViewSectionTable("BAKERY", [{"mat": "MILK 1 Lit", "qty": "145.00 ltr", "rate": "43.00", "total": "6235.00"}]),
                    const SizedBox(height: 20),
                    _buildViewSectionTable("SERVICE MATERIAL", [{"mat": "WATER CAN 20 LIT", "qty": "8.00 pcs", "rate": "20.00", "total": "160.00"}]),
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }

  Widget _buildViewSectionTable(String title, List<Map<String, String>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Color(0xFF0D6EFD), fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 10),
        Row(
          children: const [
            Expanded(flex: 3, child: Text("Material", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87))),
            Expanded(flex: 2, child: Text("Quantity", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87))),
            Expanded(flex: 1, child: Text("Rate", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87))),
            Expanded(flex: 2, child: Text("Total", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87))),
          ],
        ),
        const Divider(height: 15, color: Color(0xFFE2E8F0)),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(flex: 3, child: Text(item['mat']!, style: const TextStyle(fontSize: 13, color: Colors.black87))),
              Expanded(flex: 2, child: Text(item['qty']!, textAlign: TextAlign.right, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87))),
              Expanded(flex: 1, child: Text(item['rate']!, textAlign: TextAlign.right, style: const TextStyle(fontSize: 13, color: Colors.black87))),
              Expanded(flex: 2, child: Text(item['total']!, textAlign: TextAlign.right, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF10B981)))),
            ],
          ),
        )).toList(),
      ],
    );
  }

  void _showMatBillDialog(Map<String, dynamic> data) {
    Map<String, String> sections = (data['sections'] as Map).cast<String, String>();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
          width: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: const BoxDecoration(color: Color(0xFF0D6EFD), borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Select Material Type for Billing", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: Colors.white, size: 20))
                  ]
                )
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Available Material Types in this Order:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                    const SizedBox(height: 15),
                    ...sections.keys.map((section) => _buildChecklistItem(section)).toList(),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade600, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)), child: const Text("Cancel")),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.print, size: 16), label: const Text("Print Selected"), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14))),
                      ]
                    )
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }

  Widget _buildChecklistItem(String title) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isChecked = false;
        return Container(
          margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              SizedBox(width: 18, height: 18, child: Checkbox(value: isChecked, onChanged: (v) => setState(() => isChecked = v!), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)), side: BorderSide(color: Colors.grey.shade400, width: 1.5), activeColor: const Color(0xFF0D6EFD))),
              const SizedBox(width: 12),
              Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
            ]
          )
        );
      }
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF97316), width: 3)), child: const Icon(Icons.priority_high, color: Color(0xFFF97316), size: 45)),
                const SizedBox(height: 25),
                const Text("Delete Order?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 12),
                const Text("Are you sure you want to delete this pending order?\n(Requested materials will return to the matrix)", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF64748B), fontSize: 13, height: 1.5)),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14)), child: const Text("Yes, Delete!", style: TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(width: 12),
                    ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14)), child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold)))
                  ]
                )
              ]
            )
          )
        )
      )
    );
  }
}