import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/components/app_sidebar.dart';

class PurchaseTransferHistoryPage extends StatefulWidget {
  const PurchaseTransferHistoryPage({super.key});

  @override
  State<PurchaseTransferHistoryPage> createState() => _PurchaseTransferHistoryPageState();
}

class _PurchaseTransferHistoryPageState extends State<PurchaseTransferHistoryPage> {
  String selectedReportTab = "Item Wise";

  // State for Filters
  String selectedPeriod = "This Month";
  String selectedCategory = "All Categories";
  String selectedItem = "All Items";
  String selectedLocation = "All Locations";
  String selectedMaterialType = "All Types";
  String fromDate = "30-04-2026";
  String toDate = "21-05-2026";

  // Scroll Controller for Detailed Report
  final ScrollController _detailedScrollController = ScrollController();

  // Data Lists
  final List<String> periods = ["This Month", "This Week", "Today", "Custom Range"];
  final List<String> categoriesList = ["All Categories", "Raw Materials", "Bakery Products"];
  final List<String> itemsList = [
    "All Items", "1 Parcel Covers", "1 kg Birthday Cake Box", "1 kg Cake Bag", 
    "1 kg Sweet Box", "1 kg Sweet Container", "1/2 kg Cake Bag", "1/2 Parcel Cover"
  ];
  final List<String> locations = [
    "All Locations", "BODI-1", "NAINAAS", "PC", "ITI", "FOREST ROAD", "LPM", "GMB", "AL", 
    "RN", "SR PURAM", "AMBA", "MANDAPAM", "BODI-2", "TEST", "COVAI", 
    "N.R (PURCHASE)", "N.RESTAURANT", "N.RESTAURANT (ITI)", "NRT CAFE", "TESTING"
  ];
  final List<String> materialTypesList = [
    "All Types", "BAKERY", "CHAT MATERIAL", "CLEANING MATERIAL", "PACKING MATERIAL", 
    "RAW MATERIAL", "SERVICE MATERIAL", "TEA COFFE MATERIAL", "UNCATEGORIZED", 
    "VEGETABLES", "Vendor Product"
  ];

  final List<String> tableLocations = [
    "BODI-1", "NAINAAS", "PC", "ITI", "FOREST ROAD", "LPM", "GMB", "AL", "RN", 
    "SR PURAM", "AMBA", "MANDAPAM", "BODI-2", "TEST", "COVAI", "N.R (PURCHASE)", 
    "N.RESTAURANT", "N.RESTAURANT (ITI)", "NRT CAFE", "TESTING"
  ];

  @override
  void dispose() {
    _detailedScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(
        children: [
          const AppSidebar(activeMenu: "Purchase Transfer History"),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(25),
                    child: _buildMainContainer(),
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
          const Text("Home / Purchase Section / Purchase Transfer History",
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
          const Text("RTS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const Icon(Icons.arrow_drop_down, size: 20),
        ],
      ),
    );
  }

  Widget _buildMainContainer() {
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
          const Padding(
            padding: EdgeInsets.all(25),
            child: Text("Purchase Transfer Report", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Wrap(
              spacing: 20,
              runSpacing: 15,
              children: [
                _buildDropdownFilter("Period:", selectedPeriod, periods, 180, (val) => setState(() => selectedPeriod = val!)),
                _buildDropdownFilter("Category:", selectedCategory, categoriesList, 200, (val) => setState(() => selectedCategory = val!)),
                _buildDropdownFilter("Item:", selectedItem, itemsList, 280, (val) => setState(() => selectedItem = val!)),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              height: 42,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search by Item Name, Batch Code...",
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 8),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                _buildDropdownFilter("Location:", selectedLocation, locations, 180, (val) => setState(() => selectedLocation = val!)),
                const SizedBox(width: 15),
                _buildDropdownFilter("Material Type:", selectedMaterialType, materialTypesList, 180, (val) => setState(() => selectedMaterialType = val!)),
                const SizedBox(width: 15),
                _buildDatePicker("From:", fromDate, true),
                const SizedBox(width: 15),
                _buildDatePicker("To:", toDate, false),
                const Spacer(),
                _buildExportButton("Excel", const Color(0xFF198754), Icons.table_view),
                const SizedBox(width: 8),
                _buildExportButton("PDF", const Color(0xFFDC3545), Icons.picture_as_pdf),
                const SizedBox(width: 8),
                _buildExportButton("Print", const Color(0xFF0DCAF0), Icons.print, isPrint: true),
              ],
            ),
          ),
          
          const SizedBox(height: 25),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                _buildTabButton("Item Wise", Icons.view_list),
                const SizedBox(width: 10),
                _buildTabButton("Material Type Wise", Icons.category),
                const SizedBox(width: 10),
                _buildTabButton("Detailed Report", Icons.description),
              ],
            ),
          ),
          
          const SizedBox(height: 25),
          _buildReportTable(),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter(String label, String value, List<String> list, double width, Function(String?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF475569))),
        const SizedBox(width: 8),
        Container(
          width: width, height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFCBD5E1)), borderRadius: BorderRadius.circular(6)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey),
              style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B)),
              onChanged: onChanged,
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(String label, String date, bool isFrom) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF475569))),
        const SizedBox(width: 8),
        InkWell(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              setState(() {
                String formatted = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                if (isFrom) fromDate = formatted; else toDate = formatted;
              });
            }
          },
          child: Container(
            width: 140, height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFCBD5E1)), borderRadius: BorderRadius.circular(6)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date, style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B))),
                const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExportButton(String label, Color color, IconData icon, {bool isPrint = false}) {
    return InkWell(
      onTap: isPrint ? () => _showPrintFormatDialog() : () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Icon(icon, size: 14, color: Colors.white),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _showPrintFormatDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Choose Print Format", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 20)),
                ],
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Select the format for the print preview.", style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
              ),
              const SizedBox(height: 25),
              _buildPrintOption(
                icon: Icons.description_outlined,
                title: "A4 Report",
                subtitle: "Standard document format",
                color: const Color(0xFF0D6EFD),
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 15),
              _buildPrintOption(
                icon: Icons.receipt_long_outlined,
                title: "Thermal Receipt",
                subtitle: "Compact 80mm format",
                color: Colors.grey.shade600,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrintOption({required IconData icon, required String title, required String subtitle, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, IconData icon) {
    bool isActive = selectedReportTab == label;
    return InkWell(
      onTap: () => setState(() => selectedReportTab = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0D6EFD) : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF0D6EFD)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: isActive ? Colors.white : const Color(0xFF0D6EFD)),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: isActive ? Colors.white : const Color(0xFF0D6EFD), fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildReportTable() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFE2E8F0)))),
      child: selectedReportTab == "Detailed Report"
          ? _buildDetailedReportView()
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: selectedReportTab == "Material Type Wise" 
                ? _buildMaterialTypeTable() 
                : _buildItemWiseTable(),
            ),
    );
  }

  Widget _buildItemWiseTable() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: const FixedColumnWidth(230),
        1: const FixedColumnWidth(80),
        for (var i = 2; i < 44; i++) i: const FixedColumnWidth(80),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
          children: [
            _headerCell("ITEM NAME", 1),
            _headerCell("UNIT", 1),
            ...tableLocations.expand((loc) => [_headerCell(loc, 1), const SizedBox()]).toList(),
            _headerCell("GRAND TOTAL", 1, isBlue: true),
            const SizedBox(),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
          children: [
            const SizedBox(), const SizedBox(),
            ...List.generate(21, (i) => _subHeaderRow()).expand((e) => e).toList(),
          ],
        ),
        _dataRow("1 kg Birthday Cake Box", "pcs", List.generate(20, (i) => ["-", "-"]), ["695.000", "12843.60"]),
        _dataRow("1 kg Cake Bag", "pcs", List.generate(20, (i) => ["-", "-"]), ["540.000", "4654.80"]),
        _dataRow("1 kg Sweet Box", "pcs", List.generate(20, (i) => ["-", "-"]), ["520.000", "8736.00"]),
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFF1E293B)),
          children: [
            _footerCell("GRAND TOTAL", align: Alignment.centerRight),
            const SizedBox(),
            ...List.generate(42, (i) => _footerCell(i % 2 == 0 ? "8308.900" : "275749.10")).toList(),
          ],
        ),
      ],
    );
  }

  Widget _buildMaterialTypeTable() {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: const FixedColumnWidth(230),
        1: const FixedColumnWidth(80),
        for (var i = 2; i < 44; i++) i: const FixedColumnWidth(80),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
          children: [
            _headerCell("MATERIAL TYPE", 1),
            _headerCell("UNIT", 1),
            ...tableLocations.expand((loc) => [_headerCell(loc, 1), const SizedBox()]).toList(),
            _headerCell("GRAND TOTAL", 1, isBlue: true),
            const SizedBox(),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
          children: [
            const SizedBox(), const SizedBox(),
            ...List.generate(21, (i) => _subHeaderRow()).expand((e) => e).toList(),
          ],
        ),
        _materialDataRow("BAKERY", "Mixed", ["1620.000", "51355.00"], ["1543.000", "55555.00"], ["4161.000", "122295.00"], ["29144.020", "974479.35"]),
        _materialDataRow("CHAT MATERIAL", "Mixed", ["450.000", "125447.83"], ["1022.900", "173724.09"], ["680.750", "113912.67"], ["3707.650", "744171.15"]),
        _materialDataRow("CLEANING MATERIAL", "Mixed", ["120.500", "5096.52"], ["81.000", "2794.31"], ["45.400", "2007.50"], ["1084.300", "46851.25"]),
        _materialDataRow("PACKING MATERIAL", "Mixed", ["5950.900", "83735.53"], ["8156.900", "90009.79"], ["7470.800", "84439.51"], ["58261.000", "720746.87"]),
        _materialDataRow("RAW MATERIAL", "Mixed", ["20.000", "3378.70"], ["26.000", "1263.25"], ["45.000", "4468.45"], ["8076.640", "793884.03"]),
        _materialDataRow("SERVICE MATERIAL", "Mixed", ["664.000", "37936.78"], ["663.000", "31678.19"], ["1130.000", "32125.44"], ["12186.200", "339494.93"]),
        _materialDataRow("TEA COFFE MATERIAL", "Mixed", ["703.150", "71046.96"], ["623.800", "66979.07"], ["941.700", "109353.73"], ["8007.350", "899409.71"]),
        _materialDataRow("UNCATEGORIZED", "Mixed", ["-", "-"], ["100.000", "600.00"], ["100.000", "336.00"], ["321.000", "7849.50"]),
        _materialDataRow("VEGETABLES", "Mixed", ["10.000", "-"], ["358.250", "19971.65"], ["38.550", "3702.00"], ["1907.900", "82662.47"]),
        _materialDataRow("Vendor Product", "Mixed", ["603.000", "19495.00"], ["682.000", "22800.00"], ["2115.000", "60040.00"], ["11938.000", "308181.67"]),
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFF1E293B)),
          children: [
            _footerCell("GRAND TOTAL", align: Alignment.centerRight),
            const SizedBox(),
            ...List.generate(42, (i) => _footerCell(i % 2 == 0 ? "134634.06" : "4917730.93")).toList(),
          ],
        ),
      ],
    );
  }

  // DETAILED REPORT VIEW 
  Widget _buildDetailedReportView() {
    return SizedBox(
      width: double.infinity, 
      child: Column(
        children: [
          // Table Headers
          Table(
            border: TableBorder.all(color: const Color(0xFFE2E8F0)),
            columnWidths: const {
              0: FlexColumnWidth(4),
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(1.8),
              3: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
                children: [
                  _headerCell("ITEM NAME / DESCRIPTION", 1),
                  _headerCell("UNIT", 1),
                  _headerCell("QUANTITY", 1, isBlue: true),
                  _headerCell("AMOUNT (₹)", 1, isBlue: true),
                ],
              ),
            ],
          ),
          
          // Scrollable Content
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 500), 
            child: Theme(
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.all(const Color(0xFF0D6EFD)),
                  radius: const Radius.circular(10),
                  thickness: MaterialStateProperty.all(5),
                )
              ),
              child: Scrollbar(
                controller: _detailedScrollController,
                child: SingleChildScrollView(
                  controller: _detailedScrollController,
                  child: Column(
                    children: [
                      // OUTLET: AL SECTION 
                      _detailedOutletHeader("OUTLET: AL"),
                      _detailedCategoryHeader("BAKERY"),
                      _detailedItemRow("50-50 Sweet & Salt", "pcs", "108.000", "1080.00"),
                      _detailedItemRow("7- up Fizz", "nos", "30.000", "600.00"),
                      _detailedItemRow("7- up Nimbooz", "nos", "30.000", "300.00"),
                      _detailedItemRow("Aqu 1 lit", "pcs", "36.000", "720.00"),
                      _detailedItemRow("Aqu 2 lit", "pcs", "18.000", "630.00"),
                      _detailedItemRow("Birthday Cap", "pcs", "10.000", "500.00"),
                      _detailedItemRow("Bisileri 1 lit", "pcs", "12.000", "240.00"),
                      _detailedItemRow("Bisileri 2 lit", "pcs", "10.000", "300.00"),
                      _detailedItemRow("Good day- Cashew Rs. 25", "pcs", "20.000", "500.00"),
                      _detailedItemRow("Gooday - Cashew", "pcs", "90.000", "900.00"),
                      _detailedItemRow("Gooday - Pista Bhadam", "pcs", "30.000", "750.00"),
                      _detailedItemRow("Kinley Water", "pcs", "15.000", "300.00"),
                      _detailedItemRow("Kissan Jam", "pcs", "20.000", "500.00"),
                      _detailedItemRow("Marie Gold Rs.10", "pcs", "96.000", "960.00"),
                      _detailedItemRow("MILK 1 Lit", "ltr", "445.000", "19135.00"),
                      _detailedItemRow("Milk Bikies Rs.10", "pcs", "240.000", "2400.00"),
                      _detailedItemRow("Milk Bikies Rs.35", "pcs", "26.000", "910.00"),
                      _detailedItemRow("Milk Classic Rs.10", "pcs", "240.000", "2400.00"),
                      _detailedItemRow("Milk Classic Rs.20", "pcs", "20.000", "400.00"),
                      _detailedItemRow("Milk Cream", "pcs", "40.000", "1400.00"),
                      _detailedItemRow("Miranda Orange", "nos", "30.000", "600.00"),
                      _detailedItemRow("Pepsi Cola", "nos", "30.000", "600.00"),
                      _detailedItemRow("Ruby - Bhadam Milk", "pcs", "72.000", "2520.00"),
                      _detailedItemRow("Winkin - Strawberry", "pcs", "30.000", "1200.00"),
                      _detailedSubtotalRow("Subtotal - BAKERY", "1881.000", "45425.00"),

                      // CLEANING MATERIAL SECTION 
                      _detailedCategoryHeader("CLEANING MATERIAL"),
                      _detailedItemRow("Colin", "pcs", "2.000", "214.88"),
                      _detailedItemRow("Exo Powder", "kg", "2.000", "52.68"),
                      _detailedItemRow("Exo Soap", "pcs", "2.000", "55.40"),
                      _detailedItemRow("Finaoil", "lit", "2.000", "760.00"),
                      _detailedItemRow("Lizal", "pcs", "1.000", "113.17"),
                      _detailedItemRow("Soapoil", "ltr", "1.000", "60.00"),
                      _detailedItemRow("Waste", "kg", "8.000", "316.50"),
                      _detailedSubtotalRow("Subtotal - CLEANING MATERIAL", "18.000", "1572.63"),

                      // PACKING MATERIAL SECTION 
                      _detailedCategoryHeader("PACKING MATERIAL"),
                      _detailedItemRow("100 Gms Butter Cover", "kg", "17.000", "4283.36"),
                      _detailedItemRow("120 ml Containar", "per roll", "4.000", "400.00"),
                      _detailedItemRow("13*16 Compostable Bag", "kg", "25.000", "4561.10"),
                      _detailedItemRow("16*20 Compostable Bag", "kg", "6.000", "1140.00"),
                      _detailedItemRow("2 Cake Box", "pcs", "435.000", "1461.60"),
                      _detailedItemRow("250 Gms Butter Cover", "kg", "7.000", "1764.10"),
                      _detailedItemRow("250 Gms Sweet Box", "pcs", "196.000", "921.20"),
                      _detailedItemRow("250 ml Containar", "per roll", "3.000", "480.00"),
                      _detailedItemRow("4 Cake Box", "pcs", "276.000", "1545.60"),
                      _detailedItemRow("500 gms Sweet Box", "pcs", "40.000", "344.80"),
                      _detailedItemRow("6 Cake Box", "pcs", "60.000", "423.60"),
                      _detailedItemRow("Brown Cover 1 st", "kg", "6.000", "378.00"),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // GRAND TOTAL FOOTER
          Table(
            border: TableBorder.all(color: const Color(0xFFE2E8F0)),
            columnWidths: const {
              0: FlexColumnWidth(4),
              1: FlexColumnWidth(1.2),
              2: FlexColumnWidth(1.8),
              3: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(color: Color(0xFF1E293B)),
                children: [
                  _footerCell("GRAND TOTAL (ALL OUTLETS)", align: Alignment.centerRight),
                  const SizedBox(),
                  _footerCell("134634.060"),
                  _footerCell("₹4917730.93"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailedOutletHeader(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      color: const Color(0xFF1E293B),
      child: Row(
        children: [
          const Icon(Icons.store_mall_directory_outlined, color: Colors.white, size: 16),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _detailedCategoryHeader(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
      color: const Color(0xFFF1F5F9),
      child: Row(
        children: [
          const Icon(Icons.sell_outlined, color: Color(0xFF64748B), size: 14),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _detailedItemRow(String name, String unit, String qty, String amt) {
    return Table(
      border: const TableBorder(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      columnWidths: const {
        0: FlexColumnWidth(4),
        1: FlexColumnWidth(1.2),
        2: FlexColumnWidth(1.8),
        3: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12), child: Text(name, style: const TextStyle(fontSize: 12, color: Color(0xFF475569)))),
            Padding(padding: const EdgeInsets.all(12), child: Text(unit, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)))),
            Padding(padding: const EdgeInsets.all(12), child: Text(qty, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)))),
            Padding(padding: const EdgeInsets.all(12), child: Text("₹$amt", textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)))),
          ],
        ),
      ],
    );
  }

  Widget _detailedSubtotalRow(String label, String qty, String amt) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(4),
        1: FlexColumnWidth(1.2),
        2: FlexColumnWidth(1.8),
        3: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
          children: [
            Padding(padding: const EdgeInsets.all(12), child: Text(label, textAlign: TextAlign.right, style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Color(0xFF64748B)))),
            const SizedBox(),
            Padding(padding: const EdgeInsets.all(12), child: Text(qty, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD)))),
            Padding(padding: const EdgeInsets.all(12), child: Text("₹$amt", textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF10B981)))),
          ],
        ),
      ],
    );
  }

  TableRow _materialDataRow(String type, String unit, List<String> bod, List<String> nai, List<String> pc, List<String> grand) {
    return TableRow(
      children: [
        _dataCell(type, bold: true),
        _dataCell(unit),
        ...[_dataCell(bod[0]), _dataCell(bod[1])],
        ...[_dataCell(nai[0]), _dataCell(nai[1])],
        ...[_dataCell(pc[0]), _dataCell(pc[1])],
        ...List.generate(34, (i) => _dataCell("-")), 
        ...[_dataCell(grand[0], isGrand: true), _dataCell(grand[1], isAmt: true, isGrand: true)],
      ],
    );
  }

  TableRow _dataRow(String name, String unit, List<List<String>> locData, List<String> grand) {
    return TableRow(
      children: [
        _dataCell(name, bold: true),
        _dataCell(unit),
        ...locData.expand((pair) => [_dataCell(pair[0]), _dataCell(pair[1])]).toList(),
        _dataCell(grand[0], isGrand: true),
        _dataCell(grand[1], isAmt: true, isGrand: true),
      ],
    );
  }

  Widget _headerCell(String text, int rowSpan, {bool isBlue = false}) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isBlue ? const Color(0xFFE0F2FE) : const Color(0xFFF8FAFC),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(text, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: isBlue ? const Color(0xFF0D6EFD) : const Color(0xFF1E293B))),
    );
  }

  List<Widget> _subHeaderRow() {
    return [
      Container(
        height: 35, alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE2E8F0))),
        child: const Text("QTY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF64748B))),
      ),
      Container(
        height: 35, alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE2E8F0))),
        child: const Text("AMT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF64748B))),
      ),
    ];
  }

  Widget _dataCell(String text, {bool bold = false, bool isAmt = false, bool isGrand = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isGrand ? const Color(0xFFF0F9FF) : Colors.white,
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: bold || isGrand ? FontWeight.bold : FontWeight.normal,
          color: isGrand ? const Color(0xFF0D6EFD) : (text == "-" ? Colors.grey : const Color(0xFF334155)),
        ),
      ),
    );
  }

  Widget _footerCell(String text, {Alignment align = Alignment.center}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      alignment: align,
      decoration: BoxDecoration(border: Border.all(color: Colors.white10)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 9)),
    );
  }
}