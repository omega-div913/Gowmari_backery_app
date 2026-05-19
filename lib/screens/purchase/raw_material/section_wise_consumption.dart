import 'package:flutter/material.dart';
import '../../components/app_sidebar.dart'; // Path to your main sidebar
import 'subsidebar.dart'; // Path to your subsidebar

class SectionWiseConsumptionScreen extends StatefulWidget {
  const SectionWiseConsumptionScreen({Key? key}) : super(key: key);

  @override
  State<SectionWiseConsumptionScreen> createState() =>
      _SectionWiseConsumptionScreenState();
}

class _SectionWiseConsumptionScreenState
    extends State<SectionWiseConsumptionScreen> {
  // State variables
  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();
  String? selectedSection;
  String? selectedSubSection;
  final TextEditingController searchController = TextEditingController();

  // Dummy data
  final List<String> sections = ['All Active Sections', 'Kitchen', 'Bakery', 'Store'];
  final List<String> subSections = ['All Sub Sections', 'Sub 1', 'Sub 2'];

  // Manual Date Formatter (No intl package used)
  String _formatDate(DateTime? date) {
    if (date == null) return 'DD-MM-YYYY';
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day-$month-$year';
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
      backgroundColor: const Color(0xFFF8FAFC), // Modern light grey background
      body: Row(
        children: [
          // 1. Main Sidebar
          const AppSidebar(), 

          // 2. Main Content Area
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 3. Subsidebar (Stock Settings)
                const RawMaterialSubSidebar(activePage: 'Section Wise Consumption'),

                // 4. Page Content
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
                        Expanded(child: _buildDataTable()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Header with "New Entry" button
  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Section Wise Consumption',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
            ),
            SizedBox(height: 4),
            Text(
              'Operational Material Usage Registry',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add, size: 18),
          label: const Text('New Entry'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D6EFD), // Bootstrap Blue
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
        ),
      ],
    );
  }

  // First row of filters (Dates and Dropdowns)
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

  // Search input and Filter button row
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
            backgroundColor: const Color(0xFF1E293B), // Dark Navy
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text("Filter"),
        ),
        const SizedBox(width: 10),
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.refresh, color: Colors.grey),
            onPressed: () {
              setState(() {
                searchController.clear();
                selectedSection = null;
                selectedSubSection = null;
              });
            },
          ),
        ),
      ],
    );
  }

  // Data Table with Header and Empty State
  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9), // Light blue/grey header
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              children: [
                _tableHeaderText("DATE ↓", 1),
                _tableHeaderText("SECTION NAME ↑↓", 2),
                _tableHeaderText("SUB SECTION", 2),
                _tableHeaderText("STATUS", 2),
                _tableHeaderText("TOTAL AMOUNT ↑↓", 2),
                _tableHeaderText("ACTIONS", 1),
              ],
            ),
          ),
          // Empty state content
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined, size: 70, color: Colors.grey.shade300),
                  const SizedBox(height: 15),
                  const Text(
                    "No records found for the selected period.",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Table Headers
  Widget _tableHeaderText(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
      ),
    );
  }

  // Helper for Date fields
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
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: const TextStyle(fontSize: 14)),
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper for Dropdown fields
  Widget _buildDropdownLabelField(String label, List<String> items, String? value, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              hint: Text(items[0], style: const TextStyle(fontSize: 14)),
              items: items.map((String val) {
                return DropdownMenuItem<String>(value: val, child: Text(val));
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}