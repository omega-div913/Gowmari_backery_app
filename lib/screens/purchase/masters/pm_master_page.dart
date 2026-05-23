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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Container(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 20, top: 20, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(isEdit ? "Edit Material" : "Create Material", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                    InkWell(
                      onTap: () => Navigator.pop(context), 
                      borderRadius: BorderRadius.circular(20),
                      child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle), child: Icon(Icons.close, size: 18, color: Colors.grey.shade700))
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: Colors.grey.shade200),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _dialogFieldLabel("MATERIAL NAME"), _dialogTextField(nameController), const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_dialogFieldLabel("OPENING STOCK QUANTITY"), _dialogTextField(openingStockController, isNumeric: true)])), const SizedBox(width: 16),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_dialogFieldLabel("ALERT QUANTITY"), _dialogTextField(alertQuantityController, isNumeric: true)])),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _dialogFieldLabel("UNIT"), 
                    StatefulBuilder(
                      builder: (context, setDialogState) => _dialogDropdown(selectedUnit, (val) => setDialogState(() => selectedUnit = val))
                    ), 
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context), 
                          style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), 
                          child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600))
                        ), 
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context), 
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), elevation: 2, shadowColor: const Color(0xFF2962FF).withOpacity(0.4), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), 
                          child: const Text("Save Record", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
                        ),
                      ],
                    )
                  ],
                ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        elevation: 10,
        child: Container(
          width: 400, padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle), child: const Center(child: Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 40))),
              const SizedBox(height: 24),
              const Text("Are you sure?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)), const SizedBox(height: 12),
              Text("This action cannot be undone. You won't be able to revert this!", style: TextStyle(color: Colors.grey.shade600, fontSize: 14, height: 1.5), textAlign: TextAlign.center), const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600)))),
                  const SizedBox(width: 16),
                  Expanded(child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, elevation: 2, shadowColor: Colors.redAccent.withOpacity(0.4), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Delete", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        elevation: 10,
        child: Container(
          width: 450, padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Bulk Import (.xlsx)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                  InkWell(
                    onTap: () => Navigator.pop(context), 
                    borderRadius: BorderRadius.circular(20),
                    child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle), child: Icon(Icons.close, size: 18, color: Colors.grey.shade700))
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Download Template", style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600)))),
              const SizedBox(height: 24),
              const Text("SELECT EXCEL FILE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)), const SizedBox(height: 8),
              Container(height: 44, decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10), color: Colors.grey.shade50), child: Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(color: Colors.grey.shade200, border: Border(right: BorderSide(color: Colors.grey.shade300)), borderRadius: const BorderRadius.horizontal(left: Radius.circular(10))), alignment: Alignment.center, child: const Text("Choose File", style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600))), const SizedBox(width: 12), Text("No file chosen", style: TextStyle(fontSize: 13, color: Colors.grey.shade500))])), const SizedBox(height: 32),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), elevation: 2, shadowColor: const Color(0xFF2962FF).withOpacity(0.4), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Upload Data", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))))
            ],
          ),
        ),
      ),
    );
  }

  Widget _dialogFieldLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)));
  
  Widget _dialogTextField(TextEditingController ctrl, {bool isNumeric = false}) => TextFormField(
    controller: ctrl, keyboardType: isNumeric ? TextInputType.number : TextInputType.text, 
    decoration: InputDecoration(filled: true, fillColor: Colors.grey.shade50, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2962FF), width: 1.5))), 
    style: const TextStyle(fontSize: 14)
  );

  Widget _dialogDropdown(String? value, Function(String?) onChange) => DropdownButtonFormField<String>(
    value: value, icon: Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey.shade600),
    decoration: InputDecoration(filled: true, fillColor: Colors.grey.shade50, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2962FF), width: 1.5))), 
    hint: const Text("Please select one", style: TextStyle(fontSize: 14)), 
    items: _availableUnits.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(), 
    onChanged: onChange
  );

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
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(30), // Increased padding
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isTablet) const MobileSecondaryMenu(activePage: 'PM Master'),
                                if (isTablet) const SizedBox(height: 20),
                                _buildPageHeader(isTablet),
                                const SizedBox(height: 24),
                                _buildDataTableContainer(),
                              ],
                            ),
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
      alignment: WrapAlignment.spaceBetween, 
      crossAxisAlignment: WrapCrossAlignment.center, 
      spacing: 15, runSpacing: 15,
      children: [
        const Text("Packaging Raw Material List", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1A237E))), // Modern Header
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _headerActionBtn("Import Excel", Icons.file_upload_outlined, Colors.green, _showImportDialog), const SizedBox(width: 12), 
            _headerActionBtn("Export Excel", Icons.file_download_outlined, Colors.blueGrey, () {}), const SizedBox(width: 12), 
            ElevatedButton.icon(
              onPressed: () => _showMaterialDialog(), 
              icon: const Icon(Icons.add, size: 18, color: Colors.white), 
              label: const Text("Create New Material", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)), 
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), shadowColor: const Color(0xFF2962FF).withOpacity(0.4), elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12))
            )
          ],
        )
      ],
    );
  }

  Widget _headerActionBtn(String label, IconData icon, Color color, VoidCallback onTap) {
    return OutlinedButton.icon(
      onPressed: onTap, icon: Icon(icon, size: 18, color: color), label: Text(label, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w600)), 
      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
    );
  }

  Widget _buildDataTableContainer() {
    final paginatedData = _getPaginatedData();
    int total = _filteredMaterials.length;

    return Container(
      width: double.infinity, 
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 5))]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 350, height: 44, 
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)), 
                    child: TextField(
                      controller: _searchController, 
                      decoration: InputDecoration(hintText: "Search by name...", hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400), prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey.shade500), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 12))
                    )
                  ),
                  Text("Showing ${paginatedData.length} of $total records", style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              color: const Color(0xFFF8FAFC), // Modern header
              child: const Row(
                children: [
                  Expanded(flex: 4, child: Text("NAME", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))),
                  Expanded(flex: 2, child: Text("OPENING STOCK", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))),
                  Expanded(flex: 2, child: Text("UNIT", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))),
                  Expanded(flex: 2, child: Text("ACTIONS", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey), textAlign: TextAlign.center)),
                ],
              ),
            ),
            
            ...paginatedData.map((m) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
                child: Row(
                  children: [
                    Expanded(flex: 4, child: Text(m.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87))),
                    Expanded(flex: 2, child: Text(m.openingStock.toStringAsFixed(2), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87))),
                    Expanded(flex: 2, child: Text(m.unit, style: const TextStyle(fontSize: 14, color: Colors.black87))),
                    Expanded(flex: 2, child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _actionIconBtn(Icons.edit_rounded, Colors.blueAccent, () => _showMaterialDialog(material: m)), 
                        const SizedBox(width: 12), 
                        _actionIconBtn(Icons.delete_outline_rounded, Colors.redAccent, _showDeleteDialog)
                      ]
                    )),
                  ],
                ),
              );
            }).toList(),

            Container(
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))),
              child: _buildPaginationControls()
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionIconBtn(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36, height: 36, 
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  Widget _buildPaginationControls() {
    int total = _filteredMaterials.length;
    int totalPages = (total / _itemsPerPage).ceil();
    if (totalPages <= 1) return const SizedBox.shrink();

    List<Widget> pageButtons = [];
    pageButtons.add(_pageBox("Prev", false, () { if (_currentPage > 0) setState(() => _currentPage--); }));
    pageButtons.add(const SizedBox(width: 8));

    for (int i = 0; i < totalPages; i++) {
      pageButtons.add(_pageBox("${i + 1}", _currentPage == i, () { setState(() => _currentPage = i); }));
      if (i < totalPages - 1) pageButtons.add(const SizedBox(width: 8));
    }

    pageButtons.add(const SizedBox(width: 8));
    pageButtons.add(_pageBox("Next", false, () { if (_currentPage < totalPages - 1) setState(() => _currentPage++); }));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: pageButtons
      ),
    );
  }

  Widget _pageBox(String t, bool active, VoidCallback onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), 
      decoration: BoxDecoration(color: active ? const Color(0xFF2962FF) : Colors.transparent, border: Border.all(color: active ? const Color(0xFF2962FF) : Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), 
      child: Text(t, style: TextStyle(color: active ? Colors.white : Colors.black87, fontSize: 13, fontWeight: active ? FontWeight.bold : FontWeight.w500))
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