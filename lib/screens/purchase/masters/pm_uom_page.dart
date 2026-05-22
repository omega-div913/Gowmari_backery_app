import 'package:flutter/material.dart';
import 'subsidebar.dart'; // Import unified layout
import 'package:gowmari_mobile/screens/components/app_sidebar.dart'; 

class PMUOMPage extends StatefulWidget {
  const PMUOMPage({super.key});

  @override
  State<PMUOMPage> createState() => _PMUOMPageState();
}

class _PMUOMPageState extends State<PMUOMPage> {
  final List<String> units = ['Grams', 'gram', 'pkt', 'pcs', 'ltr', 'per roll', 'box', 'kg'];
  List<String> _filteredUnits = [];
  final TextEditingController _searchController = TextEditingController();

  int _currentPage = 1;
  final int _itemsPerPage = 10; // Updated to display all items on one page

  @override
  void initState() {
    super.initState();
    _filteredUnits = units;
    _searchController.addListener(_filterUnits);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterUnits() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUnits = units.where((u) => u.toLowerCase().contains(query)).toList();
      _currentPage = 1;
    });
  }

  List<String> get paginatedUnits {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (startIndex >= _filteredUnits.length) return [];
    if (endIndex > _filteredUnits.length) endIndex = _filteredUnits.length;
    return _filteredUnits.sublist(startIndex, endIndex);
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
              Container(height: 80, width: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 3)), child: const Center(child: Text("!", style: TextStyle(fontSize: 45, color: Color(0xFFF8BB86), fontWeight: FontWeight.bold)))),
              const SizedBox(height: 20),
              const Text("Are you sure?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)), const SizedBox(height: 8),
              const Text("You won't be able to revert this!", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14)), const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC3545), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), elevation: 0), child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white))), const SizedBox(width: 10),
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), elevation: 0), child: const Text("Cancel", style: TextStyle(color: Colors.white))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showUnitDialog({String? currentUnit}) {
    bool isEdit = currentUnit != null;
    final unitCtrl = TextEditingController(text: currentUnit ?? "");
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
                  Text(isEdit ? "Edit Unit" : "Create Unit", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 20)),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Unit Name (e.g., kg, pcs, ltr)", style: TextStyle(fontSize: 13, color: Colors.black54)), const SizedBox(height: 8),
              TextField(controller: unitCtrl, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)))), const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close")), const SizedBox(width: 10),
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1)), child: Text(isEdit ? "Update Unit" : "Save Unit", style: const TextStyle(color: Colors.white))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: AppSidebar(activeMenu: "Masters")) : null,

      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const AppSidebar(activeMenu: "Masters"),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) const MasterTopbar(breadcrumb: "Home / Purchase Section / Masters / Packaging Units"),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isMobile) const SizedBox(width: 260, child: SecondaryMastersSidebar(activePage: 'PM UOM')),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(), const SizedBox(height: 20), _buildTableContainer(),
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

  Widget _buildHeader() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 15, runSpacing: 15,
      children: [
        const Text("Packaging Unit Master", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 250, height: 38,
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: "Search units...", 
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey), 
                  prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey), 
                  border: InputBorder.none, 
                  contentPadding: EdgeInsets.symmetric(vertical: 10)
                )
              )
            ),
            const SizedBox(width: 15),
            ElevatedButton.icon(
              onPressed: () => _showUnitDialog(), 
              icon: const Icon(Icons.add, size: 16, color: Colors.white),
              label: const Text("Create New Unit", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D6EFD), 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), 
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 
                elevation: 0
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTableContainer() {
    return Container(
      width: double.infinity, 
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), 
            decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey.shade300)), borderRadius: const BorderRadius.vertical(top: Radius.circular(8))),
            child: const Row(children: [
              Expanded(child: Text("Unit Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87))), 
              Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87))
            ]),
          ),
          ListView.separated(
            shrinkWrap: true, 
            physics: const NeverScrollableScrollPhysics(), 
            itemCount: paginatedUnits.length, 
            separatorBuilder: (c, i) => Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              String currentUnit = paginatedUnits[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Expanded(child: Text(currentUnit, style: const TextStyle(fontSize: 13, color: Colors.black87))),
                    Row(
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        _actionIcon(Icons.edit_outlined, Colors.blue, () => _showUnitDialog(currentUnit: currentUnit)), 
                        const SizedBox(width: 8), 
                        _actionIcon(Icons.delete_outline, Colors.red, _showDeleteDialog)
                      ]
                    ),
                  ],
                ),
              );
            },
          ),
          if ((_filteredUnits.length / _itemsPerPage).ceil() > 1) ...[
            Divider(height: 1, color: Colors.grey.shade300),
            _buildPagination(), 
          ]
        ],
      ),
    );
  }

  Widget _actionIcon(IconData icon, Color color, VoidCallback onTap) {
    return Container(width: 32, height: 32, decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)), child: IconButton(padding: EdgeInsets.zero, icon: Icon(icon, size: 16, color: color), onPressed: onTap));
  }

  Widget _buildPagination() {
    int totalPages = (_filteredUnits.length / _itemsPerPage).ceil();
    if (totalPages <= 1) return const SizedBox.shrink();

    List<Widget> pageButtons = [];
    pageButtons.add(_pageBox("Prev", false, () { if (_currentPage > 1) setState(() => _currentPage--); }));
    pageButtons.add(const SizedBox(width: 5));

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(_pageBox("$i", _currentPage == i, () { setState(() => _currentPage = i); }));
      if (i < totalPages) pageButtons.add(const SizedBox(width: 5));
    }

    pageButtons.add(const SizedBox(width: 5));
    pageButtons.add(_pageBox("Next", false, () { if (_currentPage < totalPages) setState(() => _currentPage++); }));

    int startRecord = _filteredUnits.isEmpty ? 0 : ((_currentPage - 1) * _itemsPerPage) + 1;
    int endRecord = _currentPage * _itemsPerPage;
    if (endRecord > _filteredUnits.length) endRecord = _filteredUnits.length;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Showing $startRecord to $endRecord of ${_filteredUnits.length} entries", style: const TextStyle(fontSize: 13, color: Colors.grey)),
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
}