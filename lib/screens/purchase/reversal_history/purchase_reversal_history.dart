import 'package:flutter/material.dart';
import '../../components/app_sidebar.dart';

class PurchaseReversalHistoryPage extends StatefulWidget {
  const PurchaseReversalHistoryPage({super.key});

  @override
  State<PurchaseReversalHistoryPage> createState() => _PurchaseReversalHistoryPageState();
}

class _PurchaseReversalHistoryPageState extends State<PurchaseReversalHistoryPage> {
  String selectedPurchaseType = "All Types";

  // Dummy data
  final List<Map<String, dynamic>> _reversalData = [
    {
      "date": "21 May 2026",
      "reversalNo": "#REV-3",
      "refInvoice": "N/A",
      "vendor": "test",
      "material": "testadd",
      "type": "Raw Material",
      "reason": "Wrong Item Received",
      "amount": "156.75",
    },
    // Adding more dummy rows to demonstrate S.No and pagination layout
    {
      "date": "20 May 2026",
      "reversalNo": "#REV-2",
      "refInvoice": "INV-990",
      "vendor": "Global Supplies",
      "material": "Sugar 50kg",
      "type": "Raw Material",
      "reason": "Damaged Packaging",
      "amount": "2450.00",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(
        children: [
          const AppSidebar(activeMenu: "Reversal History"),
          Expanded(
            child: Column(
              children: [
                _buildTopHeader(),
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

  Widget _buildTopHeader() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white, 
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Color(0xFF64748B), size: 20),
          const SizedBox(width: 20),
          const Text("Home / Purchase Section / Reversal History", 
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
            radius: 16, 
            backgroundColor: Color(0xFF0D6EFD), 
            child: Text("R", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))
          ),
          const SizedBox(width: 8),
          const Text("RTS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B))),
          const Icon(Icons.arrow_drop_down, size: 20, color: Color(0xFF64748B)),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
        ],
        border: Border.all(color: Colors.grey.shade200)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 5, height: 40,
                      decoration: BoxDecoration(color: const Color(0xFFE11D48), borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.history, color: Color(0xFFE11D48), size: 22),
                            SizedBox(width: 8),
                            Text("Purchase Reversal History", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text("Track all returned items, stock reversals, and purchase adjustments.", style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text("Refresh"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF475569),
                    side: BorderSide(color: Colors.grey.shade300),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9), thickness: 1.5),
          
          // Filters Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildDateFilter("FROM DATE", "21-05-2026"),
                const SizedBox(width: 20),
                _buildDateFilter("TO DATE", "21-05-2026"),
                const SizedBox(width: 20),
                _buildModernDropdownFilter("PURCHASE TYPE"),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list, size: 16),
                  label: const Text("Apply Filters"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE11D48),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9), thickness: 1.5),

          _buildDataTable(),
          _buildPaginationFooter(),
        ],
      ),
    );
  }

  Widget _buildDateFilter(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
        const SizedBox(height: 8),
        SizedBox(
          width: 200, height: 42,
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: value, 
              hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF1E293B), fontWeight: FontWeight.w500),
              suffixIcon: const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF64748B)),
              filled: true, fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            ),
          ),
        ),
      ],
    );
  }

  // Modern Dropdown implementation similar to your second image
  Widget _buildModernDropdownFilter(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
        const SizedBox(height: 8),
        Container(
          width: 240, height: 42,
          decoration: BoxDecoration(
            color: Colors.white, 
            border: Border.all(color: const Color(0xFFE2E8F0)), 
            borderRadius: BorderRadius.circular(6)
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedPurchaseType,
              isExpanded: true,
              icon: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xFF64748B)),
              ),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(8),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B), fontWeight: FontWeight.w500),
              selectedItemBuilder: (BuildContext context) {
                return ["All Types", "Raw Material / Daily Usage", "Packaging Material"].map((String value) {
                  return Align(alignment: Alignment.centerLeft, child: Text(value));
                }).toList();
              },
              items: ["All Types", "Raw Material / Daily Usage", "Packaging Material"].map((String value) {
                bool isSelected = value == selectedPurchaseType;
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF0D6EFD) : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      value, 
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF1E293B),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (v) => setState(() => selectedPurchaseType = v!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(const Color(0xFFF8FAFC)),
        dataRowHeight: 70,
        columnSpacing: 40,
        horizontalMargin: 25,
        headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF64748B), fontSize: 12),
        columns: const [
          DataColumn(label: Text("S.NO")),
          DataColumn(label: Text("DATE")),
          DataColumn(label: Text("REVERSAL #")),
          DataColumn(label: Text("REF. INVOICE")),
          DataColumn(label: Text("VENDOR NAME")),
          DataColumn(label: Text("MATERIAL DETAILS")),
          DataColumn(label: Text("TYPE")),
          DataColumn(label: Text("REASON / NOTES")),
          DataColumn(label: Text("REVERSAL AMOUNT")),
          DataColumn(label: Text("ACTION")),
        ],
        rows: _reversalData.asMap().entries.map((entry) {
          int index = entry.key;
          var data = entry.value;
          return DataRow(
            color: MaterialStateProperty.all(Colors.white),
            cells: [
              DataCell(Text((index + 1).toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF64748B)))),
              DataCell(Text(data['date'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF334155)))),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.red.shade100)),
                  child: Text(data['reversalNo'], style: TextStyle(color: Colors.red.shade600, fontSize: 11, fontWeight: FontWeight.bold)),
                )
              ),
              DataCell(Text(data['refInvoice'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B)))),
              DataCell(Text(data['vendor'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xFF475569)))),
              DataCell(Text(data['material'], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xFF475569)))),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: const Color(0xFF0D6EFD), borderRadius: BorderRadius.circular(20)),
                  child: Text(data['type'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                )
              ),
              DataCell(Text(data['reason'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B)))),
              DataCell(Text("₹${data['amount']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFFE11D48)))),
              DataCell(
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.red.shade200),
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Icon(Icons.print_outlined, size: 18, color: Colors.red.shade400),
                  ),
                )
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPaginationFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0)))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Showing 1 to 2 of 2 entries", style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500)),
          Row(
            children: [
              _paginationBtn("Previous", isDisabled: true),
              const SizedBox(width: 5),
              _paginationBtn("1", isActive: true),
              const SizedBox(width: 5),
              _paginationBtn("Next", isDisabled: true),
            ],
          )
        ],
      ),
    );
  }

  Widget _paginationBtn(String text, {bool isActive = false, bool isDisabled = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF0D6EFD) : (isDisabled ? Colors.grey.shade100 : Colors.white),
        border: Border.all(color: isActive ? const Color(0xFF0D6EFD) : const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(6)
      ),
      child: Text(
        text, 
        style: TextStyle(
          color: isActive ? Colors.white : (isDisabled ? Colors.grey : const Color(0xFF475569)),
          fontSize: 12, fontWeight: FontWeight.bold
        )
      ),
    );
  }
}