import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/components/app_sidebar.dart';

class PurchaseReportPage extends StatefulWidget {
  const PurchaseReportPage({super.key});

  @override
  State<PurchaseReportPage> createState() => _PurchaseReportPageState();
}

class _PurchaseReportPageState extends State<PurchaseReportPage> {
  String _selectedQuickSelect = "Monthly";
  String _selectedTab = "Purchase Orders";
  
  // Dummy Table Data: Purchase Orders
  final List<Map<String, dynamic>> _poData = [
    {"date": "04-05-2026", "poId": "PO-PO-67", "vendor": "test", "items": "1", "qty": "1", "arrival": "-", "status": "purchased"},
    {"date": "05-05-2026", "poId": "PO-PO-68", "vendor": "test", "items": "1", "qty": "1", "arrival": "06-05-2026", "status": "pending"},
    {"date": "05-05-2026", "poId": "PO-PO-69", "vendor": "test", "items": "1", "qty": "10", "arrival": "06-05-2026", "status": "waiting_for_approval"},
    {"date": "07-05-2026", "poId": "PO-PO-70", "vendor": "test", "items": "1", "qty": "1", "arrival": "08-05-2026", "status": "waiting_for_approval"},
    {"date": "08-05-2026", "poId": "PO-PO-71", "vendor": "test", "items": "1", "qty": "10", "arrival": "09-05-2026", "status": "approved"},
    {"date": "08-05-2026", "poId": "PO-PO-73", "vendor": "test", "items": "1", "qty": "10", "arrival": "-", "status": "approved"},
    {"date": "08-05-2026", "poId": "PO-PO-74", "vendor": "test", "items": "1", "qty": "50", "arrival": "09-05-2026", "status": "approved"},
  ];

  // Dummy Table Data: Purchase Received
  final List<Map<String, dynamic>> _receivedData = [
    {"date": "29-04-2026", "invoice": "", "vendor": "test", "total": "1,291.50", "paid": "0.00", "balance": "1,291.50", "status": "unpaid"},
    {"date": "29-04-2026", "invoice": "", "vendor": "test", "total": "10,000.00", "paid": "0.00", "balance": "10,000.00", "status": "unpaid"},
    {"date": "29-04-2026", "invoice": "", "vendor": "test", "total": "1,050.00", "paid": "1,000.00", "balance": "50.00", "status": "partial"},
    {"date": "29-04-2026", "invoice": "", "vendor": "test", "total": "1,050.00", "paid": "0.00", "balance": "1,050.00", "status": "unpaid"},
    {"date": "30-04-2026", "invoice": "1480", "vendor": "SATHURAGIRI EGG", "total": "17,400.00", "paid": "0.00", "balance": "17,400.00", "status": "unpaid"},
    {"date": "30-04-2026", "invoice": "PUR-202605-0001", "vendor": "SATHURAGIRI COCONUT", "total": "12,150.00", "paid": "0.00", "balance": "12,150.00", "status": "unpaid"},
    {"date": "30-04-2026", "invoice": "PUR-202605-0002", "vendor": "VELMURUGAN BROILERS", "total": "1,700.00", "paid": "0.00", "balance": "1,700.00", "status": "unpaid"},
    {"date": "30-04-2026", "invoice": "46", "vendor": "SRI BALAJI TRADERS", "total": "14,900.00", "paid": "0.00", "balance": "14,900.00", "status": "unpaid"},
  ];

  // Dummy Data: Raw Material Stock
  final List<Map<String, dynamic>> _rawMaterialData = [
    {"name": "Fruit Palam (Nilan's)", "qty": "30.00", "unit": "KG", "tags": "BAKERY, SWEET, DONATION, COVAI", "color": const Color(0xFF3B82F6)},
    {"name": "Padikaram", "qty": "12.00", "unit": "KG", "tags": "SWEET, DONATION, COVAI", "color": const Color(0xFF10B981)},
    {"name": "White Ell", "qty": "5003.50", "unit": "KG", "tags": "BAKERY, KITCHEN, SWEET, KAJU, KADALAI MITTAI, MURUKKU, KAARAM, DONATION, HOME, COVAI", "color": const Color(0xFFF59E0B)},
    {"name": "Briyani Rice", "qty": "5814.00", "unit": "KG", "tags": "KITCHEN, HOME, DONATION, COVAI", "color": const Color(0xFFEF4444)},
    {"name": "Garam Masala", "qty": "5518.00", "unit": "PKT", "tags": "BAKERY, MURUKKU, KAARAM, KITCHEN, DONATION, HOME, COVAI", "color": const Color(0xFF3B82F6)},
    {"name": "Pattai", "qty": "5503.80", "unit": "KG", "tags": "BAKERY, KITCHEN, DONATION, HOME, COVAI", "color": const Color(0xFF10B981)},
    {"name": "Ghee 1 Lit", "qty": "5537.00", "unit": "LIT", "tags": "MURUKKU, SWEET, KAJU, BAKERY, KADALAI MITTAI, KITCHEN, KOLUKATTI, DONATION, HOME, COVAI", "color": const Color(0xFFF59E0B)},
    {"name": "Briyani Ilai", "qty": "4999.95", "unit": "KG", "tags": "BAKERY, KITCHEN, DONATION, HOME, COVAI", "color": const Color(0xFFEF4444)},
    {"name": "S.S Cashew", "qty": "5507.00", "unit": "KG", "tags": "DONATION, COVAI", "color": const Color(0xFF3B82F6)},
    {"name": "Ravai", "qty": "5496.00", "unit": "KG", "tags": "SWEET, KAJU, KITCHEN, HOME, DONATION, COVAI", "color": const Color(0xFF10B981)},
    {"name": "Idly Powder", "qty": "5520.00", "unit": "PKT", "tags": "KITCHEN, HOME, DONATION, COVAI", "color": const Color(0xFFF59E0B)},
    {"name": "Gingelly Oil", "qty": "5497.00", "unit": "LIT", "tags": "KITCHEN, KOLUKATTI, HOME, DONATION, COVAI", "color": const Color(0xFFEF4444)},
  ];

  // Dummy Data: Vendor Wise Report
  final List<Map<String, dynamic>> _vendorData = [
    {"vendor": "test", "orders": "10", "billed": "15,789.55", "paid": "1,176.75", "due": "14,612.80"},
    {"vendor": "SATHURAGIRI EGG", "orders": "16", "billed": "4,32,726.00", "paid": "0.00", "due": "4,32,726.00"},
    {"vendor": "SATHURAGIRI COCONUT", "orders": "7", "billed": "89,272.40", "paid": "0.00", "due": "89,272.40"},
    {"vendor": "VELMURUGAN BROILERS", "orders": "17", "billed": "28,900.00", "paid": "0.00", "due": "28,900.00"},
    {"vendor": "SRI BALAJI TRADERS", "orders": "7", "billed": "75,425.00", "paid": "0.00", "due": "75,425.00"},
    {"vendor": "K.R.BUTTER GHEE STORE", "orders": "6", "billed": "3,20,920.00", "paid": "0.00", "due": "3,20,920.00"},
    {"vendor": "MEENACHI MILK KOVA", "orders": "14", "billed": "2,01,556.00", "paid": "0.00", "due": "2,01,556.00"},
    {"vendor": "M.RAMSINGH AGRO FOODS P LTD", "orders": "8", "billed": "1,59,653.52", "paid": "0.00", "due": "1,59,653.52"},
    {"vendor": "PRAKASH KARTHI", "orders": "4", "billed": "4,38,140.00", "paid": "0.00", "due": "4,38,140.00"},
    {"vendor": "PARANJOTHI TRADERS", "orders": "5", "billed": "28,160.00", "paid": "0.00", "due": "28,160.00"},
    {"vendor": "HARIHARAN TRADERS", "orders": "12", "billed": "2,56,001.50", "paid": "0.00", "due": "2,56,001.50"},
    {"vendor": "VISWA FOODS", "orders": "36", "billed": "4,22,240.89", "paid": "0.00", "due": "4,22,240.89"},
  ];

  // Dummy Data: Section Wise Consumption
  final List<Map<String, dynamic>> _sectionData = [
    {"date": "2026-05-21 15:44:28", "section": "KOLUKATTAI", "item": "Idiyapa Mavu", "qty": "44.000", "unit": "pkt"},
    {"date": "2026-05-21 15:44:28", "section": "KOLUKATTAI", "item": "Vellam", "qty": "6.000", "unit": "kg"},
    {"date": "2026-05-21 15:44:28", "section": "KOLUKATTAI", "item": "Porikadalai", "qty": "7.000", "unit": "kg"},
    {"date": "2026-05-21 15:44:28", "section": "KOLUKATTAI", "item": "Sugar", "qty": "2.500", "unit": "kg"},
    {"date": "2026-05-21 15:44:28", "section": "KOLUKATTAI", "item": "Pasi Payaru", "qty": "9.000", "unit": "kg"},
    {"date": "2026-05-21 15:44:28", "section": "KOLUKATTAI", "item": "Karuppu Sundal", "qty": "9.000", "unit": "kg"},
    {"date": "2026-05-21 15:44:28", "section": "KOLUKATTAI", "item": "Coconut", "qty": "28.000", "unit": "pcs"},
    {"date": "2026-05-21 15:44:28", "section": "KOLUKATTAI", "item": "Coconut Oil", "qty": "1.000", "unit": "ltr"},
    {"date": "2026-05-21 15:44:28", "section": "KOLUKATTAI", "item": "Karuppu Ell", "qty": "0.250", "unit": "kg"},
    {"date": "2026-05-21 15:44:28", "section": "KOLUKATTAI", "item": "Yelakai", "qty": "0.250", "unit": "kg"},
    {"date": "2026-05-21 15:44:28", "section": "KOLUKATTAI", "item": "Onion - Big", "qty": "5.000", "unit": "kg"},
    {"date": "2026-05-21 15:40:28", "section": "KAARAM", "item": "Corn Chips", "qty": "6.000", "unit": "kg"},
    {"date": "2026-05-21 15:40:28", "section": "KAARAM", "item": "Butter - Milkymist", "qty": "5.000", "unit": "pcs"},
    {"date": "2026-05-21 15:40:28", "section": "KAARAM", "item": "Garlic - Small", "qty": "3.000", "unit": "kg"},
    {"date": "2026-05-21 15:39:32", "section": "WASHING", "item": "Exo Soap", "qty": "7.000", "unit": "pcs"},
    {"date": "2026-05-21 15:39:32", "section": "WASHING", "item": "Steel Scrubber", "qty": "4.000", "unit": "pcs"},
    {"date": "2026-05-21 15:36:33", "section": "PACKING", "item": "6 Cake Box", "qty": "150.000", "unit": "pcs"},
    {"date": "2026-05-21 15:36:33", "section": "PACKING", "item": "7*9 Nice Cover", "qty": "3.000", "unit": "kg"},
  ];

  // Dummy Data: Item Wise Report
  final List<Map<String, dynamic>> _itemWiseData = [
    {"item": "TESTP1", "qty": "222.00", "unit": "box"},
    {"item": "EGG", "qty": "73565.00", "unit": "nos"},
    {"item": "Coconut", "qty": "3630.00", "unit": "pcs"},
    {"item": "Chicken Boneless", "qty": "120.75", "unit": "kg"},
    {"item": "Onion - Big", "qty": "2830.00", "unit": "kg"},
    {"item": "Pottato", "qty": "878.00", "unit": "kg"},
    {"item": "Ghee 1 lit", "qty": "144.00", "unit": "lit"},
    {"item": "Kalakamthu", "qty": "545.00", "unit": "kg"},
    {"item": "Milk Cake", "qty": "155.00", "unit": "kg"},
    {"item": "Zeebra Rice", "qty": "1040.00", "unit": "kg"},
    {"item": "Idly Rice", "qty": "312.00", "unit": "kg"},
    {"item": "Briyani Rice", "qty": "390.00", "unit": "kg"},
    {"item": "kadalai Mavu 1 kg", "qty": "240.00", "unit": "kg"},
    {"item": "Sugar", "qty": "11250.00", "unit": "kg"},
    {"item": "Garlic - Big", "qty": "70.00", "unit": "kg"},
    {"item": "Garlic - Small", "qty": "150.00", "unit": "kg"},
    {"item": "Basmathi Rice", "qty": "240.00", "unit": "kg"},
    {"item": "25 kg Liquid Glucose", "qty": "4.00", "unit": "pcs"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(
        children: [
          const AppSidebar(activeMenu: "Purchase Report"),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(25),
                    child: _buildMainContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Color(0xFF64748B), size: 20),
          const SizedBox(width: 20),
          const Text("Home / Purchase Section / Purchase Report",
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13, fontWeight: FontWeight.w500)),
          const Spacer(),
          Container(
            width: 300, height: 38,
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search menus ( Press / )",
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 6),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(
            radius: 16, backgroundColor: Color(0xFF0D6EFD),
            child: Text("R", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          const Text("RTS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B))),
          const Icon(Icons.arrow_drop_down, size: 20),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title & Export Section
          _buildTitleRow(),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filters Row (Quick Select & Date Range)
                _buildFiltersRow(),
                
                const SizedBox(height: 35),
                
                // Summary Cards
                _buildSummaryCards(),
                
                const SizedBox(height: 35),
                
                // Content Tabs
                _buildTabs(),
                
                // Dynamic Tab View
                _buildActiveTabContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleRow() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.show_chart, color: Color(0xFF0D6EFD), size: 30),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Purchase & Inventory Report", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  SizedBox(height: 4),
                  Text("Track Procurement, Financials, and Stock Levels.", style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                ],
              ),
            ],
          ),
          Row(
            children: [
              _buildOutlinedButton("Print / PDF", Icons.print_outlined, const Color(0xFFDC3545)),
              const SizedBox(width: 12),
              _buildOutlinedButton("Export Excel", Icons.table_view_outlined, const Color(0xFF198754)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOutlinedButton(String title, IconData icon, Color color) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(title),
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color.withOpacity(0.4)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
      ),
    );
  }

  Widget _buildFiltersRow() {
    return Wrap(
      spacing: 30,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        // Quick Select
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("QUICK SELECT", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
            const SizedBox(height: 8),
            Container(
              height: 40,
              clipBehavior: Clip.antiAlias, 
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF0D6EFD)), 
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildQuickSelectBtn("Today", isFirst: true),
                  Container(width: 1, color: const Color(0xFF0D6EFD)),
                  _buildQuickSelectBtn("Weekly"),
                  Container(width: 1, color: const Color(0xFF0D6EFD)),
                  _buildQuickSelectBtn("Monthly", isLast: true),
                ],
              ),
            ),
          ],
        ),
        
        // Date Range
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("DATE RANGE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
            const SizedBox(height: 8),
            Container(
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDatePart("30-04-2026"),
                  Container(
                    width: 40, alignment: Alignment.center,
                    color: const Color(0xFF0D6EFD),
                    child: const Text("to", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                  _buildDatePart("30-05-2026"),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 30),
        
        // Apply Filter Button
        SizedBox(
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.filter_list, size: 16),
            label: const Text("Apply Filter"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D6EFD),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickSelectBtn(String text, {bool isFirst = false, bool isLast = false}) {
    bool isSelected = _selectedQuickSelect == text;
    return InkWell(
      onTap: () => setState(() => _selectedQuickSelect = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.center,
        color: isSelected ? const Color(0xFF0D6EFD) : Colors.white,
        child: Text(
          text, 
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF0D6EFD), 
            fontWeight: FontWeight.w600, 
            fontSize: 13
          )
        ),
      ),
    );
  }

  Widget _buildDatePart(String date) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B), fontWeight: FontWeight.w500)),
          const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.black87),
        ],
      ),
    );
  }

  // --- SUMMARY CARDS WITH HOVER LIFTUP EFFECT ---
  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(child: HoverElevateCard(child: _buildSingleCardInner("TOTAL POS RAISED", "11", const Color(0xFF06B6D4), const Color(0xFF1E293B)))),
        const SizedBox(width: 20),
        Expanded(child: HoverElevateCard(child: _buildSingleCardInner("PENDING ORDERS", "3", const Color(0xFFF59E0B), const Color(0xFFF59E0B)))),
        const SizedBox(width: 20),
        Expanded(child: HoverElevateCard(child: _buildSingleCardInner("TOTAL SPENT (RECEIVED)", "₹1,176.75", const Color(0xFF10B981), const Color(0xFF10B981)))),
        const SizedBox(width: 20),
        Expanded(child: HoverElevateCard(child: _buildSingleCardInner("LOW STOCK ALERTS", "0", const Color(0xFFEF4444), const Color(0xFFEF4444)))),
      ],
    );
  }

  Widget _buildSingleCardInner(String title, String value, Color topBorderColor, Color valueColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade200, width: 1), 
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, 
          children: [
            Container(height: 4, width: double.infinity, color: topBorderColor),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF64748B))),
                  const SizedBox(height: 10),
                  Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: valueColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    final tabs = [
      {"name": "Purchase Orders", "icon": Icons.bar_chart},
      {"name": "Purchase Received", "icon": Icons.receipt_long},
      {"name": "Raw Material Stock", "icon": Icons.inventory_2_outlined},
      {"name": "Vendor Wise Report", "icon": Icons.people_outline},
      {"name": "Section Wise Consumption", "icon": Icons.pie_chart_outline},
      {"name": "Item Wise Report", "icon": Icons.category_outlined},
    ];

    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            bool isSelected = _selectedTab == tab["name"];
            return InkWell(
              onTap: () => setState(() => _selectedTab = tab["name"] as String),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: isSelected ? const Color(0xFF0D6EFD) : Colors.transparent, width: 3))
                ),
                child: Row(
                  children: [
                    Icon(tab["icon"] as IconData, size: 18, color: isSelected ? const Color(0xFF0D6EFD) : const Color(0xFF64748B)),
                    const SizedBox(width: 8),
                    Text(
                      tab["name"] as String, 
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF0D6EFD) : const Color(0xFF475569), 
                        fontWeight: FontWeight.bold, 
                        fontSize: 13
                      )
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // --- DYNAMIC CONTENT SWITCHER ---
  Widget _buildActiveTabContent() {
    if (_selectedTab == "Purchase Orders") {
      return _buildPurchaseOrdersTable();
    } else if (_selectedTab == "Purchase Received") {
      return _buildPurchaseReceivedTable();
    } else if (_selectedTab == "Raw Material Stock") {
      return _buildRawMaterialStockGrid();
    } else if (_selectedTab == "Vendor Wise Report") {
      return _buildVendorWiseReportTable();
    } else if (_selectedTab == "Section Wise Consumption") {
      return _buildSectionWiseConsumptionTable();
    } else if (_selectedTab == "Item Wise Report") {
      return _buildItemWiseReportTable();
    } else {
      return const SizedBox(); 
    }
  }

  // 1. PURCHASE ORDERS TABLE
  Widget _buildPurchaseOrdersTable() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(1.5), // ORDER DATE
          1: FlexColumnWidth(1.2), // PO ID
          2: FlexColumnWidth(1.5), // VENDOR
          3: FlexColumnWidth(1.0), // ITEMS
          4: FlexColumnWidth(1.2), // TOTAL QTY
          5: FlexColumnWidth(1.5), // EST. ARRIVAL
          6: FlexColumnWidth(1.5), // STATUS
        },
        children: [
          TableRow(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))),
            children: [
              _headerCell("ORDER DATE"), _headerCell("PO ID"), _headerCell("VENDOR"),
              _headerCell("ITEMS"), _headerCell("TOTAL QTY"), _headerCell("EST. ARRIVAL"), _headerCell("STATUS"),
            ],
          ),
          ..._poData.map((data) {
            return TableRow(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF8FAFC)))),
              children: [
                _dataCellText(data['date'], isBold: true),
                _dataCellPoId(data['poId']),
                _dataCellText(data['vendor']),
                _dataCellText(data['items'], isBold: true),
                _dataCellText(data['qty'], isBold: true),
                _dataCellText(data['arrival']),
                _dataCellStatus(data['status']),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  // 2. PURCHASE RECEIVED TABLE
  Widget _buildPurchaseReceivedTable() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(1.5), // DATE
          1: FlexColumnWidth(1.8), // INVOICE #
          2: FlexColumnWidth(2.5), // VENDOR
          3: FlexColumnWidth(1.5), // TOTAL AMOUNT
          4: FlexColumnWidth(1.2), // PAID
          5: FlexColumnWidth(1.2), // BALANCE
          6: FlexColumnWidth(1.5), // PAYMENT STATUS
        },
        children: [
          TableRow(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))),
            children: [
              _headerCell("DATE"), _headerCell("INVOICE #"), _headerCell("VENDOR"),
              _headerCell("TOTAL AMOUNT", alignRight: true), _headerCell("PAID", alignRight: true), 
              _headerCell("BALANCE", alignRight: true), _headerCell("PAYMENT STATUS", alignRight: true),
            ],
          ),
          ..._receivedData.map((data) {
            return TableRow(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF8FAFC)))),
              children: [
                _dataCellText(data['date']),
                _dataCellText(data['invoice'], isBold: true),
                _dataCellText(data['vendor']),
                _dataCellText("₹${data['total']}", isBold: true, alignRight: true),
                _dataCellText("₹${data['paid']}", color: const Color(0xFF10B981), alignRight: true), // Green Paid
                _dataCellText("₹${data['balance']}", color: const Color(0xFFEF4444), alignRight: true), // Red Balance
                _buildPaymentStatusPill(data['status']),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  // 3. RAW MATERIAL STOCK GRID
  Widget _buildRawMaterialStockGrid() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.5,
        ),
        itemCount: _rawMaterialData.length,
        itemBuilder: (context, index) {
          final item = _rawMaterialData[index];
          return HoverElevateCard(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item['name'], 
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: item['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.show_chart, color: item['color'], size: 18),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(item['qty'], style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                      const SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(item['unit'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Icon(Icons.sell_outlined, size: 12, color: Color(0xFF94A3B8)),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                item['tags'], 
                                style: const TextStyle(fontSize: 10, color: Color(0xFF64748B), height: 1.3),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF10B981)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text("Good", style: TextStyle(color: Color(0xFF10B981), fontSize: 10, fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 4. VENDOR WISE REPORT
  Widget _buildVendorWiseReportTable() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(3.0), // VENDOR NAME
          1: FlexColumnWidth(1.0), // ORDERS
          2: FlexColumnWidth(2.0), // TOTAL BILLED
          3: FlexColumnWidth(2.0), // TOTAL PAID
          4: FlexColumnWidth(2.0), // OUTSTANDING DUE
        },
        children: [
          TableRow(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))),
            children: [
              _headerCell("VENDOR NAME"),
              _headerCell("ORDERS", alignRight: true),
              _headerCell("TOTAL BILLED", alignRight: true),
              _headerCell("TOTAL PAID", alignRight: true),
              _headerCell("OUTSTANDING DUE", alignRight: true),
            ],
          ),
          ..._vendorData.map((data) {
            return TableRow(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF8FAFC)))),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Color(0xFF0D6EFD), shape: BoxShape.circle),
                        child: const Icon(Icons.add, color: Colors.white, size: 14),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text(data['vendor'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B)))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFF64748B), borderRadius: BorderRadius.circular(20)),
                      child: Text(data['orders'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                _dataCellText("₹${data['billed']}", isBold: true, alignRight: true),
                _dataCellText("₹${data['paid']}", color: const Color(0xFF10B981), isBold: true, alignRight: true),
                _dataCellText("₹${data['due']}", color: const Color(0xFFEF4444), isBold: true, alignRight: true),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  // 5. SECTION WISE CONSUMPTION
  Widget _buildSectionWiseConsumptionTable() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(2.0), // DATE
          1: FlexColumnWidth(2.0), // SECTION
          2: FlexColumnWidth(3.0), // ITEM NAME
          3: FlexColumnWidth(1.5), // QTY CONSUMED
          4: FlexColumnWidth(1.0), // UNIT
          5: FlexColumnWidth(2.0), // STATUS
        },
        children: [
          TableRow(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))),
            children: [
              _headerCell("DATE"),
              _headerCell("SECTION"),
              _headerCell("ITEM NAME"),
              _headerCell("QTY CONSUMED", alignRight: true),
              _headerCell("UNIT"),
              _headerCell("STATUS", alignRight: true),
            ],
          ),
          ..._sectionData.map((data) {
            return TableRow(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF8FAFC)))),
              children: [
                _dataCellText(data['date'], isBold: true),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                      child: Text(data['section'], style: const TextStyle(color: Color(0xFF475569), fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                _dataCellText(data['item'], isBold: true),
                _dataCellText(data['qty'], isBold: true, alignRight: true),
                _dataCellText(data['unit']),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0xFF10B981), borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.check_circle_outline, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text("Routine Usage", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  // 6. ITEM WISE REPORT
  Widget _buildItemWiseReportTable() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(2.5), // ITEM NAME
          1: FlexColumnWidth(1.0), // TYPE
          2: FlexColumnWidth(1.5), // TRANSACTIONS
          3: FlexColumnWidth(1.2), // TOTAL QTY
          4: FlexColumnWidth(0.8), // UNIT
          5: FlexColumnWidth(1.5), // LAST PURCHASED
          6: FlexColumnWidth(1.5), // AVG. PRICE
          7: FlexColumnWidth(1.5), // TOTAL SPENT
        },
        children: [
          TableRow(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))),
            children: [
              _headerCell("ITEM NAME"),
              _headerCell("TYPE"),
              _headerCell("TRANSACTIONS", alignRight: true),
              _headerCell("TOTAL QTY", alignRight: true),
              _headerCell("UNIT"),
              _headerCell("LAST PURCHASED", alignRight: true),
              _headerCell("AVG. PRICE", alignRight: true),
              _headerCell("TOTAL SPENT", alignRight: true),
            ],
          ),
          ..._itemWiseData.map((data) {
            return TableRow(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFF8FAFC)))),
              children: [
                _dataCellText(data['item'], isBold: true),
                _dataCellText(data['type'] ?? ""),
                _dataCellText(data['trans'] ?? "", alignRight: true),
                _dataCellText(data['qty'], isBold: true, alignRight: true),
                _dataCellText(data['unit']),
                _dataCellText(data['last'] ?? "-", alignRight: true),
                _dataCellText("₹${data['avg'] ?? "NaN"}", isBold: true, alignRight: true),
                _dataCellText("₹${data['spent'] ?? "NaN"}", isBold: true, alignRight: true),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  // HELPER WIDGETS
  Widget _headerCell(String text, {bool alignRight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        text, 
        textAlign: alignRight ? TextAlign.right : TextAlign.left,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B), fontSize: 11)
      ),
    );
  }

  Widget _dataCellText(String text, {bool isBold = false, Color? color, bool alignRight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        text, 
        textAlign: alignRight ? TextAlign.right : TextAlign.left,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500, 
          fontSize: 13, 
          color: color ?? (isBold ? const Color(0xFF1E293B) : const Color(0xFF475569))
        )
      ),
    );
  }

  Widget _dataCellPoId(String poId) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
          child: Text(poId, style: const TextStyle(color: Color(0xFF475569), fontSize: 12, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _dataCellStatus(String status) {
    Color bgColor;
    String displayText = status.replaceAll("_", " ");
    switch (status) {
      case "purchased": bgColor = const Color(0xFF64748B); break;
      case "pending": bgColor = const Color(0xFFF59E0B); break;
      case "waiting_for_approval": bgColor = const Color(0xFF64748B); break;
      case "approved": bgColor = const Color(0xFF10B981); break;
      default: bgColor = const Color(0xFF64748B);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
          child: Text(displayText, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildPaymentStatusPill(String status) {
    Color bgColor;
    if (status == "unpaid") {
      bgColor = const Color(0xFFEF4444); 
    } else if (status == "partial") {
      bgColor = const Color(0xFF06B6D4); 
    } else {
      bgColor = const Color(0xFF10B981); 
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
          child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

// Custom Widget for Hover Elevation (Lift Up) Effect
class HoverElevateCard extends StatefulWidget {
  final Widget child;
  const HoverElevateCard({super.key, required this.child});

  @override
  State<HoverElevateCard> createState() => _HoverElevateCardState();
}

class _HoverElevateCardState extends State<HoverElevateCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _isHovered ? -5.0 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered
              ? [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 8))]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}