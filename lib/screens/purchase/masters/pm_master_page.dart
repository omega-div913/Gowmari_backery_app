import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'subsidebar.dart'; // Import unified layout
import 'package:gowmari_mobile/screens/components/app_sidebar.dart'; 

class PackagingMaterial {
  final String id;
  String name;
  double openingStock;
  double alertQuantity;
  String unit;

  PackagingMaterial({required this.id, required this.name, required this.openingStock, required this.alertQuantity, required this.unit});
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
          width: 450, padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(isEdit ? "Edit Material" : "Create Material", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 20)),
                ],
              ),
              const SizedBox(height: 20),
              _dialogFieldLabel("MATERIAL NAME"), _dialogTextField(nameController), const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_dialogFieldLabel("OPENING STOCK QUANTITY"), _dialogTextField(openingStockController, isNumeric: true)])), const SizedBox(width: 15),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_dialogFieldLabel("ALERT QUANTITY"), _dialogTextField(alertQuantityController, isNumeric: true)])),
                ],
              ),
              const SizedBox(height: 15),
              _dialogFieldLabel("UNIT"), _dialogDropdown(selectedUnit, (val) => selectedUnit = val), const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12), side: BorderSide(color: Colors.grey.shade300)), child: const Text("Close", style: TextStyle(color: Colors.black87))), const SizedBox(width: 10),
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12), elevation: 0), child: const Text("Save Record", style: TextStyle(color: Colors.white))),
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
              const Text("Are you sure?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)), const SizedBox(height: 8),
              const Text("You won't be able to revert this!", style: TextStyle(color: Colors.grey, fontSize: 14)), const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC3545), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)), child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white))), const SizedBox(width: 10),
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF5A95E0), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)), child: const Text("Cancel", style: TextStyle(color: Colors.white))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showImportDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 400, padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Bulk Import (.xlsx)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 15),
              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), padding: const EdgeInsets.symmetric(vertical: 12)), child: const Text("Download Template", style: TextStyle(color: Colors.black87)))), const SizedBox(height: 15),
              const Text("SELECT EXCEL FILE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)), const SizedBox(height: 5),
              Container(height: 40, decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)), child: Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: Colors.grey.shade100, border: Border(right: BorderSide(color: Colors.grey.shade300))), alignment: Alignment.center, child: const Text("Choose File", style: TextStyle(fontSize: 12))), const SizedBox(width: 10), const Text("No file chosen", style: TextStyle(fontSize: 12, color: Colors.grey))])), const SizedBox(height: 20),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), elevation: 0, padding: const EdgeInsets.symmetric(vertical: 12)), child: const Text("Upload Data", style: TextStyle(color: Colors.white))))
            ],
          ),
        ),
      ),
    );
  }

  Widget _dialogFieldLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)));
  Widget _dialogTextField(TextEditingController ctrl, {bool isNumeric = false}) => Container(height: 40, decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)), child: TextField(controller: ctrl, keyboardType: isNumeric ? TextInputType.number : TextInputType.text, decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)), style: const TextStyle(fontSize: 13)));
  Widget _dialogDropdown(String? value, Function(String?) onChange) => Container(height: 40, padding: const EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)), child: DropdownButtonHideUnderline(child: DropdownButton<String>(value: value, isExpanded: true, hint: const Text("Please select one", style: TextStyle(fontSize: 13)), items: _availableUnits.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 13)))).toList(), onChanged: (v) => setState(() => onChange(v)))));

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;
    bool isTablet = screenWidth < 850;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: AppSidebar(activeMenu: "Masters")) : null,
      appBar: isMobile ? AppBar(title: const Text("Packaging Materials", style: TextStyle(color: Colors.black, fontSize: 16)), backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black)) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const AppSidebar(activeMenu: "Masters"),
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
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isTablet) const MobileSecondaryMenu(activePage: 'PM Master'),
                              const SizedBox(height: 10),
                              _buildPageHeader(isTablet),
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

  Widget _buildPageHeader(bool isTablet) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween, crossAxisAlignment: WrapCrossAlignment.center, spacing: 15, runSpacing: 15,
      children: [
        const Text("Packaging Raw Material List", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
        if (isTablet) SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () => _showMaterialDialog(), icon: const Icon(Icons.add, size: 16, color: Colors.white), label: const Text("Create New Material", style: TextStyle(color: Colors.white)), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), elevation: 0, padding: const EdgeInsets.symmetric(vertical: 12)))),
      ],
    );
  }

  Widget _buildTopActionRow(bool isTablet) {
    if (isTablet) {
      return Column(
        children: [
          TextField(controller: _searchController, decoration: InputDecoration(hintText: "Search by name...", prefixIcon: const Icon(Icons.search, size: 18), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)), contentPadding: const EdgeInsets.symmetric(vertical: 0))),
          const SizedBox(height: 10),
          Row(children: [Expanded(child: _headerActionBtn("Import", Icons.file_upload_outlined, Colors.green, _showImportDialog)), const SizedBox(width: 10), Expanded(child: _headerActionBtn("Export", Icons.file_download_outlined, Colors.black54, () {}))])
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(width: 300, height: 40, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)), child: TextField(controller: _searchController, decoration: const InputDecoration(hintText: "Search by name...", prefixIcon: Icon(Icons.search, size: 18), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 10)))),
        Row(children: [_headerActionBtn("Import Excel", Icons.file_upload_outlined, Colors.green, _showImportDialog), const SizedBox(width: 10), _headerActionBtn("Export Excel", Icons.file_download_outlined, Colors.black54, () {}), const SizedBox(width: 10), ElevatedButton.icon(onPressed: () => _showMaterialDialog(), icon: const Icon(Icons.add, size: 16, color: Colors.white), label: const Text("Create New Material", style: TextStyle(color: Colors.white)), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), elevation: 0))])
      ],
    );
  }

  Widget _headerActionBtn(String label, IconData icon, Color color, VoidCallback onTap) {
    return OutlinedButton.icon(onPressed: onTap, icon: Icon(icon, size: 16, color: color), label: Text(label, style: TextStyle(color: color, fontSize: 13)), style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))));
  }

  Widget _buildDataTableContainer() {
    final paginatedData = _getPaginatedData();
    return Container(
      width: double.infinity, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87), dataRowMinHeight: 50, dataRowMaxHeight: 50,
              columns: const [DataColumn(label: Text('S.No')), DataColumn(label: Text('Name')), DataColumn(label: Text('Opening Stock')), DataColumn(label: Text('Unit')), DataColumn(label: Text('Actions'))],
              rows: paginatedData.asMap().entries.map((entry) {
                int index = entry.key; PackagingMaterial m = entry.value; int sNo = (_currentPage * _itemsPerPage) + index + 1;
                return DataRow(cells: [
                  DataCell(Text('$sNo', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), 
                  DataCell(Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                  DataCell(Text(m.openingStock.toStringAsFixed(2), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                  DataCell(Text(m.unit, style: const TextStyle(fontSize: 13))),
                  DataCell(Row(children: [_actionIconBtn(Icons.edit_outlined, Colors.blue, () => _showMaterialDialog(material: m)), const SizedBox(width: 8), _actionIconBtn(Icons.delete_outline, Colors.red, _showDeleteDialog)])),
                ]);
              }).toList(),
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          _buildPaginationControls(),
        ],
      ),
    );
  }

  Widget _actionIconBtn(IconData icon, Color color, VoidCallback onTap) {
    return Container(width: 30, height: 30, decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)), child: IconButton(padding: EdgeInsets.zero, icon: Icon(icon, size: 16, color: color), onPressed: onTap));
  }

  Widget _buildPaginationControls() {
    int total = _filteredMaterials.length;
    int totalPages = (total / _itemsPerPage).ceil();
    if (totalPages <= 1) totalPages = 1;

    List<Widget> pageButtons = [];
    pageButtons.add(_pageBox("Prev", false, () { if (_currentPage > 0) setState(() => _currentPage--); }));
    pageButtons.add(const SizedBox(width: 5));

    for (int i = 0; i < totalPages; i++) {
      pageButtons.add(_pageBox("${i + 1}", _currentPage == i, () { setState(() => _currentPage = i); }));
      if (i < totalPages - 1) pageButtons.add(const SizedBox(width: 5));
    }

    pageButtons.add(const SizedBox(width: 5));
    pageButtons.add(_pageBox("Next", false, () { if (_currentPage < totalPages - 1) setState(() => _currentPage++); }));

    int startItem = total == 0 ? 0 : (_currentPage * _itemsPerPage) + 1;
    int endItem = (_currentPage + 1) * _itemsPerPage;
    if (endItem > total) endItem = total;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Showing $startItem to $endItem of $total entries", style: const TextStyle(fontSize: 13, color: Colors.grey)),
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