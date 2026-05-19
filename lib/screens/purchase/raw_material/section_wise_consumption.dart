import 'package:flutter/material.dart';
import '../../components/app_sidebar.dart'; 
import 'subsidebar.dart'; 
import 'record_section_consumption.dart'; // Added import for navigation

class SectionWiseConsumptionScreen extends StatefulWidget {
  const SectionWiseConsumptionScreen({Key? key}) : super(key: key);

  @override
  State<SectionWiseConsumptionScreen> createState() =>
      _SectionWiseConsumptionScreenState();
}

class _SectionWiseConsumptionScreenState
    extends State<SectionWiseConsumptionScreen> {
  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();
  String? selectedSection;
  String? selectedSubSection;
  final TextEditingController searchController = TextEditingController();

  final List<String> sections = ['All Active Sections', 'Kitchen', 'Bakery', 'Store'];
  final List<String> subSections = ['All Sub Sections', 'Sub 1', 'Sub 2'];

  final List<Map<String, dynamic>> tableData = [
    {"date": "19-05-2026", "section": "Kitchen", "sub": "Main Kitchen", "status": "Completed", "amount": "₹ 1,250.00"},
    {"date": "19-05-2026", "section": "Bakery", "sub": "Oven Area", "status": "Pending", "amount": "₹ 850.00"},
    {"date": "18-05-2026", "section": "Store", "sub": "Raw Stock", "status": "Completed", "amount": "₹ 2,400.00"},
  ];

  String _formatDate(DateTime? date) {
    if (date == null) return 'DD-MM-YYYY';
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) fromDate = picked; else toDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          // 1. Main Sidebar
          const AppSidebar(activeMenu: "Raw Material"), 

          Expanded(
            child: Column(
              children: [
                // 2. Top Header Bar (Breadcrumbs, Search, Profile) - Matches Image 1 & 3
                _buildTopBar(),

                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 3. Subsidebar
                      const RawMaterialSubSidebar(activePage: 'Section Wise Consumption'),

                      // 4. Page Content Area
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPageHeader(),
                              const SizedBox(height: 25),
                              _buildFilterRow(),
                              const SizedBox(height: 20),
                              _buildSearchRow(),
                              const SizedBox(height: 25),
                              Expanded(child: _buildDataTableGrid()),
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

  // NEW: Top Navigation Bar to match Image 1 & 3
  Widget _buildTopBar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey, size: 22),
          const SizedBox(width: 20),
          const Text(
            "Home / Purchase Section / Raw Material",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const Spacer(),
          // Search Pill
          Container(
            width: 350,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search menus ( Press / )",
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 8),
              ),
            ),
          ),
          const SizedBox(width: 25),
          // Profile Section
          Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: const BoxDecoration(color: Color(0xFF0D6EFD), shape: BoxShape.circle),
                child: const Center(child: Text("R", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
              ),
              const SizedBox(width: 12),
              const Text("RTS", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const Icon(Icons.arrow_drop_down, color: Colors.black87),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Section Wise Consumption', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            SizedBox(height: 4),
            Text('Operational Material Usage Registry', style: TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Updated navigation to RecordSectionConsumptionScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RecordSectionConsumptionScreen()),
            );
          },
          icon: const Icon(Icons.add, size: 18),
          label: const Text('New Entry'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D6EFD),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: [
        Expanded(child: _buildInputLabelField("FROM DATE", _formatDate(fromDate), () => _selectDate(context, true))),
        const SizedBox(width: 15),
        Expanded(child: _buildInputLabelField("TO DATE", _formatDate(toDate), () => _selectDate(context, false))),
        const SizedBox(width: 15),
        Expanded(child: _buildDropdownLabelField("FILTER SECTIONS", sections, selectedSection, (val) => setState(() => selectedSection = val))),
        const SizedBox(width: 15),
        Expanded(child: _buildDropdownLabelField("FILTER SUB SECTIONS", subSections, selectedSubSection, (val) => setState(() => selectedSubSection = val))),
      ],
    );
  }

  Widget _buildSearchRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("SEARCH RECORDS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 8),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Section, item, etc...',
                  prefixIcon: const Icon(Icons.search, size: 20, color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E293B),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text("Filter"),
        ),
        const SizedBox(width: 10),
        Container(
          height: 55, width: 55,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
          child: IconButton(icon: const Icon(Icons.refresh, color: Colors.grey), onPressed: () => setState(() => searchController.clear())),
        ),
      ],
    );
  }

  Widget _buildDataTableGrid() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: const BoxDecoration(color: Color(0xFFF1F5F9), borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            child: Row(
              children: [
                _tableHeaderText("S.NO", 0.5),
                _tableHeaderText("DATE ↓", 1.2),
                _tableHeaderText("SECTION NAME ↑↓", 2),
                _tableHeaderText("SUB SECTION", 2),
                _tableHeaderText("STATUS", 1.5),
                _tableHeaderText("TOTAL AMOUNT ↑↓", 2),
                _tableHeaderText("ACTIONS", 1),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: tableData.length,
              separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade100),
              itemBuilder: (context, index) {
                final item = tableData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(flex: 5, child: Text("${index + 1}", style: const TextStyle(fontSize: 13))),
                      Expanded(flex: 12, child: Text(item['date'])),
                      Expanded(flex: 20, child: Text(item['section'], style: const TextStyle(fontWeight: FontWeight.w500))),
                      Expanded(flex: 20, child: Text(item['sub'])),
                      Expanded(flex: 15, child: _statusBadge(item['status'])),
                      Expanded(flex: 20, child: Text(item['amount'], style: const TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 10, child: Row(children: [
                        Icon(Icons.edit_outlined, size: 18, color: Colors.blue.shade600),
                        const SizedBox(width: 8),
                        const Icon(Icons.delete_outline, size: 18, color: Colors.redAccent),
                      ])),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Showing 1 to ${tableData.length} of ${tableData.length} entries", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Row(children: [ _pageBtn("Previous", false), const SizedBox(width: 5), _pageBtn("1", true), const SizedBox(width: 5), _pageBtn("Next", false)])
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    bool isDone = status == "Completed";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: isDone ? Colors.green.shade50 : Colors.orange.shade50, borderRadius: BorderRadius.circular(5)),
      child: Text(status, style: TextStyle(fontSize: 11, color: isDone ? Colors.green : Colors.orange, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
    );
  }

  Widget _pageBtn(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: active ? const Color(0xFF0D6EFD) : Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
      child: Text(text, style: TextStyle(fontSize: 12, color: active ? Colors.white : Colors.black87)),
    );
  }

  Widget _tableHeaderText(String text, double flex) => Expanded(flex: (flex * 10).toInt(), child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B))));

  Widget _buildInputLabelField(String label, String value, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(value, style: const TextStyle(fontSize: 14)), const Icon(Icons.calendar_today, size: 16, color: Colors.grey)]),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownLabelField(String label, List<String> items, String? value, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
          child: DropdownButtonHideUnderline(child: DropdownButton<String>(isExpanded: true, value: value, hint: Text(items[0], style: const TextStyle(fontSize: 14)), items: items.map((String val) => DropdownMenuItem<String>(value: val, child: Text(val))).toList(), onChanged: onChanged)),
        ),
      ],
    );
  }
}