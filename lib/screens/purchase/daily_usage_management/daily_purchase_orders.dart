import 'package:flutter/material.dart';
import '../../components/app_sidebar.dart';
import 'subsidebar.dart';

class DailyPurchaseOrdersPage extends StatefulWidget {
  const DailyPurchaseOrdersPage({super.key});

  @override
  State<DailyPurchaseOrdersPage> createState() => _DailyPurchaseOrdersPageState();
}

class _DailyPurchaseOrdersPageState extends State<DailyPurchaseOrdersPage> {
  bool _isAddingNewOrder = false; // Toggles the Form view
  bool _isEditingOrder = false;   // Determines if the Form is New or Edit

  // --- List View State ---
  String? selectedVendor = "All Vendors";
  final List<String> vendors = ["All Vendors", "SRI GANESH VILAS", "test", "Chicken Masala"];
  
  final List<Map<String, dynamic>> _orders = [
    {"orderDate": "01-05-2026", "reqDate": "30-04-2026", "vendor": "test", "materials": "Party Papper (100.00 pcs)", "status": "Purchased"},
    {"orderDate": "25-04-2026", "reqDate": "24-04-2026", "vendor": "test", "materials": "1 kg Birthday Cake Box (100.00 pcs), 1 kg Sweet Box...", "status": "Purchased"},
    {"orderDate": "24-04-2026", "reqDate": "23-04-2026", "vendor": "test", "materials": "Good Day Chocochips (1.00 pcs), Mango (1.00 pcs)", "status": "Purchased"},
    {"orderDate": "26-03-2026", "reqDate": "26-03-2026", "vendor": "Chicken Masala", "materials": "Chicken Masala (10.00 pcs), L.G 500 gms (100.00 pcs)", "status": "Pending"},
  ];

  // --- Form State ---
  List<Map<String, dynamic>> _dynamicItems = [];

  void _openCreateForm() {
    setState(() {
      _isEditingOrder = false;
      _isAddingNewOrder = true;
      _dynamicItems = [{"material": "", "available": "0.00", "qty": "1", "unit": "N/A"}];
    });
  }

  void _openEditForm() {
    setState(() {
      _isEditingOrder = true;
      _isAddingNewOrder = true;
      _dynamicItems = [
        {"material": "Party Papper", "available": "324.00", "qty": "100", "unit": "pcs"},
        {"material": "", "available": "0.00", "qty": "1", "unit": "N/A"}
      ];
    });
  }

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
                      const DailyUsageSubSidebar(activePage: "Daily Usage PO"),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(25),
                          child: _isAddingNewOrder ? _buildOrderForm() : _buildListView(),
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

  // --- EXACT HEADER ---
  Widget _buildExactHeader() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Color(0xFF64748B), size: 20),
          const SizedBox(width: 20),
          const Text("Home / Purchase Section / Daily Usage Management / Request", style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
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

  // --- THE LIST VIEW ---
  Widget _buildListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Daily Purchase Orders", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            ElevatedButton.icon(
              onPressed: _openCreateForm,
              icon: const Icon(Icons.add, size: 18),
              label: const Text("Create New Daily Order"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildListFiltersCard(),
        const SizedBox(height: 20),
        _buildDataTableContainer(),
      ],
    );
  }

  Widget _buildListFiltersCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Vendor:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedVendor,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    filled: true, fillColor: Colors.white,
                  ),
                  items: vendors.map((v) => DropdownMenuItem(value: v, child: Text(v, style: const TextStyle(fontSize: 13)))).toList(),
                  onChanged: (val) => setState(() => selectedVendor = val),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(child: _buildListDateInput("From:")),
          const SizedBox(width: 15),
          Expanded(child: _buildListDateInput("To:")),
          const SizedBox(width: 15),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), side: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            child: const Text("Reset Filters", style: TextStyle(color: Color(0xFF64748B))),
          ),
        ],
      ),
    );
  }

  Widget _buildListDateInput(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
        const SizedBox(height: 8),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: "dd-mm-yyyy", hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
            suffixIcon: const Icon(Icons.calendar_month, size: 18, color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            filled: true, fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDataTableContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FIX FOR RED OVERFLOW LINE: SingleChildScrollView horizontal
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.6),
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(const Color(0xFFF8FAFC)),
                dataRowHeight: 70,
                columnSpacing: 25,
                columns: const [
                  DataColumn(label: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("Order Date", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("Vendor", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("Material(s)", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: _orders.asMap().entries.map((entry) {
                  int index = entry.key + 1;
                  var data = entry.value;
                  bool isPurchased = data['status'] == 'Purchased';
                  return DataRow(cells: [
                    DataCell(Text(index.toString(), style: const TextStyle(fontSize: 13))),
                    DataCell(Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['orderDate'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        Text("Req: ${data['reqDate']}", style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    )),
                    DataCell(Text(data['vendor'], style: const TextStyle(fontSize: 13))),
                    DataCell(SizedBox(width: 300, child: Text(data['materials'], style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis))),
                    DataCell(Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: isPurchased ? const Color(0xFFE1F7E7) : const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(4)),
                      child: Text(data['status'], style: TextStyle(color: isPurchased ? Colors.green.shade700 : Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                    )),
                    DataCell(Row(
                      children: [
                        _actionBtn(Icons.print_outlined, Colors.blue, _showPrintDialog),
                        _actionBtn(Icons.chat_bubble_outline, Colors.green, () => _showWhatsAppDialog(data['vendor'])),
                        _actionBtn(Icons.edit_outlined, Colors.orange, _openEditForm),
                        _actionBtn(Icons.delete_outline, Colors.red, _showDeleteDialog),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
          _buildPaginationFooter(),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.2)), borderRadius: BorderRadius.circular(6)),
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }

  Widget _buildPaginationFooter() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Showing 1 to 4 of 4 entries", style: TextStyle(color: Colors.grey, fontSize: 13)),
          Row(
            children: [
              _pageBtn("Previous", enabled: false), const SizedBox(width: 5),
              _pageBtn("1", active: true), const SizedBox(width: 5),
              _pageBtn("Next", enabled: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pageBtn(String text, {bool active = false, bool enabled = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF0D6EFD) : Colors.white,
        border: Border.all(color: active ? const Color(0xFF0D6EFD) : const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text, style: TextStyle(color: active ? Colors.white : (enabled ? Colors.black87 : Colors.grey), fontSize: 13)),
    );
  }

  // --- DIALOG MODALS ---

  void _showPrintDialog() {
    String format = 'A4';
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          titlePadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: const [Icon(Icons.print_outlined, size: 20), SizedBox(width: 8), Text("Print Options", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))]),
                InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 20, color: Colors.grey)),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Print Format:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Radio<String>(value: 'A4', groupValue: format, onChanged: (v) => setState(() => format = v!)),
                  const Text("A4 (Normal)", style: TextStyle(fontSize: 13)),
                  const SizedBox(width: 15),
                  Radio<String>(value: '80mm', groupValue: format, onChanged: (v) => setState(() => format = v!)),
                  const Text("80mm (Thermal)", style: TextStyle(fontSize: 13)),
                ],
              ),
            ],
          ),
          actionsPadding: const EdgeInsets.all(20),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), style: TextButton.styleFrom(foregroundColor: Colors.grey.shade700), child: const Text("Cancel")),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.print, size: 16), label: const Text("Print"),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _showWhatsAppDialog(String vendor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.all(30),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Phone Number Missing", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Please enter a WhatsApp number for $vendor.", style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 25),
            TextField(
              decoration: InputDecoration(
                hintText: "e.g., 919876543210", contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF93C5FD))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF93C5FD))),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                  child: const Text("Send WhatsApp", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF64748B), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                  child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF97316), width: 4)),
              child: const Icon(Icons.priority_high, color: Color(0xFFF97316), size: 40),
            ),
            const SizedBox(height: 25),
            const Text("Delete Order?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("This cannot be undone!", style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                  child: const Text("Yes, delete it!", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF64748B), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                  child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // --- COMBINED NEW & EDIT FORM ---
  Widget _buildOrderForm() {
    String title = _isEditingOrder ? "Edit Daily Purchase Order" : "New Daily Purchase Order";
    String btnText = _isEditingOrder ? "Update Order" : "Save Order";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            OutlinedButton.icon(
              onPressed: () => setState(() => _isAddingNewOrder = false),
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text("Back to List"),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.grey, side: const BorderSide(color: Colors.grey)),
            ),
          ],
        ),
        const SizedBox(height: 25),

        // SECTION: ORDER DETAILS
        _buildFormSection(
          title: "Order Details",
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _formField("Vendor", _isEditingOrder ? "test" : "Select a vendor...", isSearch: !_isEditingOrder)),
                  const SizedBox(width: 15),
                  Expanded(child: _formField("Order Date", "01-05-2026", isDate: true)),
                  const SizedBox(width: 15),
                  Expanded(child: _formField("Request Date", "01-05-2026", isDate: true)),
                  const SizedBox(width: 15),
                  Expanded(child: _formField("Estimation Days", _isEditingOrder ? "1" : "0")),
                  if (_isEditingOrder) const SizedBox(width: 15),
                  if (_isEditingOrder) Expanded(child: _formField("Status", "Purchased", isDropdown: true)),
                ],
              ),
              const SizedBox(height: 15),
              _formField("Notes", "", isMultiline: true),
            ],
          ),
        ),

        const SizedBox(height: 25),

        // SECTION: ITEMS (Dynamic Rows)
        _buildFormSection(
          title: "Items",
          action: ElevatedButton.icon(
            onPressed: () => setState(() => _dynamicItems.add({"material": "", "available": "0.00", "qty": "1", "unit": "N/A"})),
            icon: const Icon(Icons.add, size: 16),
            label: const Text("Add Item"),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white),
          ),
          child: Column(
            children: [
              // Table Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                decoration: BoxDecoration(color: Colors.grey.shade50, border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                child: Row(
                  children: const [
                    Expanded(flex: 4, child: Text("Raw Material", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 2, child: Text("Available Qty", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 2, child: Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 2, child: Text("Unit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    SizedBox(width: 40),
                  ],
                ),
              ),
              // Dynamic Rows
              ..._dynamicItems.asMap().entries.map((entry) {
                int index = entry.key;
                var item = entry.value;
                bool isAddedEmpty = item["material"] == "";
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(flex: 4, child: _tableInput(isAddedEmpty ? "Select a material..." : item["material"], isSearch: isAddedEmpty)),
                      const SizedBox(width: 10),
                      Expanded(flex: 2, child: _tableInput(item["available"], isReadOnly: true)),
                      const SizedBox(width: 10),
                      Expanded(flex: 2, child: _tableInput(item["qty"])),
                      const SizedBox(width: 10),
                      Expanded(flex: 2, child: _tableInput(item["unit"], isReadOnly: true)),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () => setState(() => _dynamicItems.removeAt(index)),
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                      )
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // FOOTER BUTTONS
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => setState(() => _isAddingNewOrder = false),
              style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20), foregroundColor: Colors.grey),
              child: const Text("Cancel"),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(btnText, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormSection({required String title, required Widget child, Widget? action}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
              if (action != null) action,
            ],
          ),
          const Divider(height: 30),
          child,
        ],
      ),
    );
  }

  Widget _formField(String label, String hint, {bool isDate = false, bool isSearch = false, bool isMultiline = false, bool isDropdown = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
        const SizedBox(height: 8),
        TextField(
          maxLines: isMultiline ? 3 : 1, readOnly: isDate || isDropdown,
          decoration: InputDecoration(
            hintText: hint, hintStyle: TextStyle(fontSize: 14, color: isDropdown || !_isAddingNewOrder ? Colors.black87 : Colors.grey),
            suffixIcon: isDate ? const Icon(Icons.calendar_month, size: 18) : (isSearch ? const Icon(Icons.search, size: 18) : (isDropdown ? const Icon(Icons.keyboard_arrow_down, size: 18) : null)),
            filled: true, fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade200)),
          ),
        ),
      ],
    );
  }

  Widget _tableInput(String hint, {bool isReadOnly = false, bool isSearch = false}) {
    return TextField(
      readOnly: isReadOnly,
      decoration: InputDecoration(
        hintText: hint, hintStyle: TextStyle(fontSize: 13, color: isReadOnly || hint != "Select a material..." ? Colors.black87 : Colors.grey),
        prefixIcon: isSearch ? const Icon(Icons.search, size: 16) : null,
        filled: true, fillColor: isReadOnly ? const Color(0xFFF1F5F9) : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade200)),
      ),
    );
  }
}