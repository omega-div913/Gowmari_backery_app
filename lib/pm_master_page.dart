import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'masters_page.dart';

class PackagingMaterial {
  final String id;
  String name;
  double openingStock;
  double alertQuantity;
  String unit;

  PackagingMaterial({
    required this.id,
    required this.name,
    required this.openingStock,
    required this.alertQuantity,
    required this.unit,
  });
}

class PMMasterPage extends StatefulWidget {
  const PMMasterPage({super.key});

  @override
  State<PMMasterPage> createState() => _PMMasterPageState();
}

class _PMMasterPageState extends State<PMMasterPage> {
  final int _itemsPerPage = 10;
  int _currentPage = 0;
  final List<PackagingMaterial> _allMaterials = _generateMockData();
  List<PackagingMaterial> _filteredMaterials = [];
  final TextEditingController _searchController = TextEditingController();
  final List<String> _availableUnits = ['kg', 'pcs', 'pkt', 'gram', 'ltr', 'ml', 'nos', 'box', 'per roll'];

  @override
  void initState() {
    super.initState();
    _filteredMaterials = _allMaterials;
    _searchController.addListener(() => _filterMaterials());
  }

  void _filterMaterials() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMaterials = _allMaterials.where((m) => m.name.toLowerCase().contains(query)).toList();
      _currentPage = 0;
    });
  }

  // ==========================================
  // 1. CREATE / EDIT DIALOG (2nd & 3rd Image)
  // ==========================================
  void _showMaterialDialog({PackagingMaterial? material}) {
    bool isEdit = material != null;
    final nameController = TextEditingController(text: material?.name ?? "");
    final openingStockController = TextEditingController(text: material?.openingStock.toString() ?? "0");
    final alertQuantityController = TextEditingController(text: material?.alertQuantity.toString() ?? "0");
    String? selectedUnit = material?.unit;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(isEdit ? "Edit Material" : "Create Material", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 20)),
                ],
              ),
              const SizedBox(height: 20),
              _dialogFieldLabel("MATERIAL NAME"),
              _dialogTextField(nameController),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    _dialogFieldLabel("OPENING STOCK QUANTITY"),
                    _dialogTextField(openingStockController, isNumeric: true),
                  ])),
                  const SizedBox(width: 15),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    _dialogFieldLabel("ALERT QUANTITY"),
                    _dialogTextField(alertQuantityController, isNumeric: true),
                  ])),
                ],
              ),
              const SizedBox(height: 15),
              _dialogFieldLabel("UNIT"),
              _dialogDropdown(selectedUnit, (val) => selectedUnit = val),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12), side: BorderSide(color: Colors.grey.shade300)),
                    child: const Text("Close", style: TextStyle(color: Colors.black87)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12), elevation: 0),
                    child: const Text("Save Record", style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 2. DELETE DIALOG (4th Image)
  // ==========================================
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 80, width: 80,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 3)),
                child: const Center(child: Text("!", style: TextStyle(fontSize: 45, color: Color(0xFFF8BB86)))),
              ),
              const SizedBox(height: 20),
              const Text("Are you sure?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 8),
              const Text("You won't be able to revert this!", style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC3545), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                    child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF5A95E0), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                    child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 3. IMPORT DIALOG (5th Image)
  // ==========================================
  void _showImportDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Bulk Import (.xlsx)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), padding: const EdgeInsets.symmetric(vertical: 12)),
                  child: const Text("Download Template", style: TextStyle(color: Colors.black87)),
                ),
              ),
              const SizedBox(height: 15),
              const Text("SELECT EXCEL FILE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
              const SizedBox(height: 5),
              Container(
                height: 40,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(color: Colors.grey.shade100, border: Border(right: BorderSide(color: Colors.grey.shade300))),
                      alignment: Alignment.center,
                      child: const Text("Choose File", style: TextStyle(fontSize: 12)),
                    ),
                    const SizedBox(width: 10),
                    const Text("No file chosen", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), elevation: 0, padding: const EdgeInsets.symmetric(vertical: 12)),
                  child: const Text("Upload Data", style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // --- DIALOG WIDGET HELPERS ---
  Widget _dialogFieldLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)));

  Widget _dialogTextField(TextEditingController ctrl, {bool isNumeric = false}) => Container(
    height: 40,
    decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)),
    child: TextField(
      controller: ctrl,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
      style: const TextStyle(fontSize: 13),
    ),
  );

  Widget _dialogDropdown(String? value, Function(String?) onChange) => Container(
    height: 40,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        hint: const Text("Please select one", style: TextStyle(fontSize: 13)),
        items: _availableUnits.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(),
        onChanged: (v) => setState(() => onChange(v)),
      ),
    ),
  );

  // --- MAIN LAYOUT ---
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
                if (!isMobile) const MasterTopbar(breadcrumb: "Home / Purchase Section / Masters / Packaging Materials"),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isTablet) const SizedBox(width: 260, child: SecondaryMastersSidebar(activePage: 'PM Master')),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isTablet) const MobileSecondaryMenu(activePage: 'PM Master'),
                              const Text("Packaging Raw Material List", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                              const SizedBox(height: 20),
                              _buildTopActionRow(isTablet),
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

  Widget _buildTopActionRow(bool isTablet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 300, height: 40,
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(hintText: "Search by name...", prefixIcon: Icon(Icons.search, size: 18), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 10)),
          ),
        ),
        if (!isTablet) Row(
          children: [
            _headerActionBtn("Import Excel", Icons.file_upload_outlined, Colors.green, _showImportDialog),
            const SizedBox(width: 10),
            _headerActionBtn("Export Excel", Icons.file_download_outlined, Colors.black54, () {}),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () => _showMaterialDialog(),
              icon: const Icon(Icons.add, size: 16, color: Colors.white),
              label: const Text("Create New Material", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), elevation: 0),
            ),
          ],
        )
      ],
    );
  }

  Widget _headerActionBtn(String label, IconData icon, Color color, VoidCallback onTap) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: color),
      label: Text(label, style: TextStyle(color: color, fontSize: 13)),
      style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
    );
  }

  Widget _buildDataTableContainer() {
    final paginatedData = _getPaginatedData();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        children: [
          DataTable(
            headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            dataRowMinHeight: 50, dataRowMaxHeight: 50,
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Opening Stock')),
              DataColumn(label: Text('Unit')),
              DataColumn(label: Text('Actions')),
            ],
            rows: paginatedData.map((m) => DataRow(cells: [
              DataCell(Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
              DataCell(Text(m.openingStock.toStringAsFixed(2), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
              DataCell(Text(m.unit, style: const TextStyle(fontSize: 13))),
              DataCell(Row(children: [
                _actionIconBtn(Icons.edit_outlined, Colors.blue, () => _showMaterialDialog(material: m)),
                const SizedBox(width: 8),
                _actionIconBtn(Icons.delete_outline, Colors.red, _showDeleteDialog),
              ])),
            ])).toList(),
          ),
          _buildPaginationControls(),
        ],
      ),
    );
  }

  Widget _actionIconBtn(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: 30, height: 30,
      decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)),
      child: IconButton(padding: EdgeInsets.zero, icon: Icon(icon, size: 16, color: color), onPressed: onTap),
    );
  }

  Widget _buildPaginationControls() {
    int total = _filteredMaterials.length;
    int pages = (total / _itemsPerPage).ceil();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Showing ${(_currentPage * _itemsPerPage) + 1} to ${(_currentPage + 1) * _itemsPerPage > total ? total : (_currentPage + 1) * _itemsPerPage} of $total records", style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Row(
            children: List.generate(pages, (index) => GestureDetector(
              onTap: () => setState(() => _currentPage = index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: _currentPage == index ? Colors.blue : Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                child: Text("${index + 1}", style: TextStyle(color: _currentPage == index ? Colors.white : Colors.black)),
              ),
            )),
          ),
        ],
      ),
    );
  }

  List<PackagingMaterial> _getPaginatedData() {
    final start = _currentPage * _itemsPerPage;
    final end = (start + _itemsPerPage > _filteredMaterials.length) ? _filteredMaterials.length : start + _itemsPerPage;
    return _filteredMaterials.sublist(start, end);
  }

  static List<PackagingMaterial> _generateMockData() {
    final names = ['PP Cover', 'Old Cove', 'Number Bag', 'Sticker Roll', 'Box'];
    return List.generate(84, (i) => PackagingMaterial(id: 'PM$i', name: '${(i % 50) + 10} Gram ${names[i % names.length]}', openingStock: 0.0, alertQuantity: 0.0, unit: 'kg'));
  }
}