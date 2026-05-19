import 'package:flutter/material.dart';
import '../../components/app_sidebar.dart';
import 'subsidebar.dart';

class DailyUsageRequestPage extends StatefulWidget {
  const DailyUsageRequestPage({super.key});

  @override
  State<DailyUsageRequestPage> createState() => _DailyUsageRequestPageState();
}

class _DailyUsageRequestPageState extends State<DailyUsageRequestPage> {
  String selectedBatch = "Batch 01";

  // List of outlets from the second image
  final List<String> outlets = [
    "SR PURAM", "AMBA", "LPM", "PC", "ITI", "RN", "AL", "BODI-1", 
    "MANDAPAM", "FOREST ROAD", "NAINAAS", "GMB", "TEST", "BODI-2", 
    "N.RESTAURANT", "N.RESTAURANT ( ITI )", "NRT CAFE", "COVAI", "TESTING", "N.R (PURCHASE)"
  ];

  // Dummy Data for Table
  final List<Map<String, dynamic>> tableData = [
    {"name": "Atta Flour", "unit": "kg", "production": "50.00"},
    {"name": "Maida", "unit": "kg", "production": "120.00"},
    {"name": "Sugar", "unit": "kg", "production": "80.00"},
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
                _buildTopBar(),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DailyUsageSubSidebar(activePage: "Daily Usage Request"),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(),
                              const SizedBox(height: 15),
                              _buildBatchSelection(),
                              const SizedBox(height: 20),
                              _buildRequestMatrix(),
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

  Widget _buildTopBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey, size: 20),
          const SizedBox(width: 15),
          const Text("Home / Purchase Section / Daily Usage Management / Request", 
            style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Spacer(),
          Container(
            width: 300, height: 38,
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search menus ( Press / )",
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 18),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 10),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(radius: 16, backgroundColor: Color(0xFF0D6EFD), child: Text("R", style: TextStyle(color: Colors.white, fontSize: 12))),
          const SizedBox(width: 8),
          const Text("RTS", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          const Icon(Icons.arrow_drop_down, size: 18),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Daily Usage Request", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, size: 14),
          label: const Text("Back to History", style: TextStyle(fontSize: 12)),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey.shade700,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
        ),
      ],
    );
  }

  Widget _buildBatchSelection() {
    List<String> batches = ["Batch 01", "Batch 02", "Batch 03", "Batch 04", "main test"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          children: batches.map((batch) {
            bool isSelected = selectedBatch == batch;
            return ChoiceChip(
              label: Text(batch),
              selected: isSelected,
              onSelected: (val) => setState(() => selectedBatch = batch),
              selectedColor: const Color(0xFF0D6EFD),
              labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontSize: 13, fontWeight: FontWeight.w600),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6), side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey.shade300)),
              showCheckmark: false,
            );
          }).toList(),
        ),
        const SizedBox(height: 15),
        const Text("ALL", style: TextStyle(color: Color(0xFF0D6EFD), fontWeight: FontWeight.bold, fontSize: 12, decoration: TextDecoration.underline)),
      ],
    );
  }

  Widget _buildRequestMatrix() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Daily Usage Request Matrix", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("Consolidated demand from Production and Outlets", style: TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
                const Spacer(),
                const Text("DATE: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
                  child: Row(children: const [Text("19-05-2026", style: TextStyle(fontSize: 12)), SizedBox(width: 8), Icon(Icons.calendar_month, size: 14)]),
                ),
                const SizedBox(width: 10),
                _actionBtn("Generate PO", const Color(0xFF64748B), Icons.receipt_long),
                const SizedBox(width: 8),
                _actionBtn("Bulk Transfer All", const Color(0xFF0D6EFD), Icons.swap_horiz),
                const SizedBox(width: 10),
                _iconBtn(Icons.description_outlined, Colors.green),
                const SizedBox(width: 5),
                _iconBtn(Icons.picture_as_pdf_outlined, Colors.red),
                const SizedBox(width: 5),
                _iconBtn(Icons.print_outlined, Colors.grey),
              ],
            ),
          ),
          
          // HORIZONTAL SCROLLABLE GRID (Matches Image 2)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Table Header
                Container(
                  color: const Color(0xFFF8FAFC),
                  child: Row(
                    children: [
                      _cell("S.NO", 50, isHeader: true),
                      _cell("RAW MATERIAL NAME", 200, isHeader: true),
                      _cell("UNIT", 80, isHeader: true),
                      _cell("PRODUCTION", 110, isHeader: true, color: const Color(0xFF0D6EFD), textColor: Colors.white),
                      ...outlets.map((o) => _cell(o, 100, isHeader: true)),
                      _cell("TOTAL", 100, isHeader: true, color: const Color(0xFF0D6EFD), textColor: Colors.white),
                    ],
                  ),
                ),
                // Table Rows
                ...List.generate(tableData.length, (index) {
                  final item = tableData[index];
                  return Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
                    child: Row(
                      children: [
                        _cell("${index + 1}", 50),
                        _cell(item['name'], 200, alignLeft: true),
                        _cell(item['unit'], 80),
                        _cell(item['production'], 110, color: const Color(0xFFEBF3FF), textColor: const Color(0xFF0D6EFD), isBold: true),
                        ...outlets.map((o) => _cell("-", 100)),
                        _cell(item['production'], 100, color: const Color(0xFF0D6EFD), textColor: Colors.white, isBold: true),
                      ],
                    ),
                  );
                }),
                // Empty state if no data
                if (tableData.isEmpty)
                  Container(
                    width: 2800, height: 200, alignment: Alignment.center,
                    child: const Text("No daily requests found for this date and batch.", style: TextStyle(color: Colors.grey)),
                  )
              ],
            ),
          ),

          // Pagination Footer
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Showing 1 to ${tableData.length} of ${tableData.length} entries", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Row(
                  children: [
                    _pageBtn("Previous", false),
                    const SizedBox(width: 5),
                    _pageBtn("1", true),
                    const SizedBox(width: 5),
                    _pageBtn("Next", false),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _cell(String text, double width, {bool isHeader = false, Color? color, Color? textColor, bool isBold = false, bool alignLeft = false}) {
    return Container(
      width: width, height: 45,
      decoration: BoxDecoration(color: color, border: Border.all(color: Colors.grey.shade200, width: 0.2)),
      alignment: alignLeft ? Alignment.centerLeft : Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(text, 
        textAlign: alignLeft ? TextAlign.left : TextAlign.center,
        style: TextStyle(
          fontSize: 11, 
          fontWeight: (isHeader || isBold) ? FontWeight.bold : FontWeight.normal,
          color: textColor ?? (isHeader ? const Color(0xFF64748B) : Colors.black87)
        )
      ),
    );
  }

  Widget _actionBtn(String label, Color color, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 14),
      label: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
    );
  }

  Widget _iconBtn(IconData icon, Color color) {
    return Container(
      height: 32, width: 32,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
      child: Icon(icon, color: color, size: 16),
    );
  }

  Widget _pageBtn(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: active ? const Color(0xFF0D6EFD) : Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
      child: Text(text, style: TextStyle(fontSize: 11, color: active ? Colors.white : Colors.black87)),
    );
  }
}