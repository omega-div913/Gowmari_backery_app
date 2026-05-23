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
              Text("This action cannot be undone. You won't be able to revert this!", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600, fontSize: 14, height: 1.5)), const SizedBox(height: 32),
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

  void _showUnitDialog({String? currentUnit}) {
    bool isEdit = currentUnit != null;
    final unitCtrl = TextEditingController(text: currentUnit ?? "");
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
        backgroundColor: Colors.white,
        child: Container(
          width: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 20, top: 20, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(isEdit ? "Edit Unit" : "Create Unit", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
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
                    const Text("Unit Name (e.g., kg, pcs, ltr)", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)), const SizedBox(height: 10),
                    TextFormField(
                      controller: unitCtrl, 
                      decoration: InputDecoration(filled: true, fillColor: Colors.grey.shade50, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2962FF), width: 1.5)))
                    ), 
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () => Navigator.pop(context), style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600))), const SizedBox(width: 12),
                        ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), elevation: 2, shadowColor: const Color(0xFF2962FF).withOpacity(0.4), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text(isEdit ? "Update Unit" : "Save Unit", style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))),
                      ],
                    )
                  ]
                ),
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
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(30), // Increased padding
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeader(), const SizedBox(height: 24), _buildTableContainer(),
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

  Widget _buildHeader() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 15, runSpacing: 15,
      children: [
        const Text("Packaging Unit Master", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1A237E))), // Modern Header
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 280, height: 44,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))]),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search units...", 
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400), 
                  prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey.shade500), 
                  border: InputBorder.none, 
                  contentPadding: const EdgeInsets.symmetric(vertical: 12)
                )
              )
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: () => _showUnitDialog(), 
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: const Text("Create New Unit", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2962FF), 
                shadowColor: const Color(0xFF2962FF).withOpacity(0.4), elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 5))]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18), 
              color: const Color(0xFFF8FAFC), // Modern header
              child: const Row(children: [
                Expanded(child: Text("UNIT NAME", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), 
                Text("ACTIONS", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))
              ]),
            ),
            ListView.separated(
              shrinkWrap: true, 
              physics: const NeverScrollableScrollPhysics(), 
              itemCount: paginatedUnits.length, 
              separatorBuilder: (c, i) => Divider(height: 1, color: Colors.grey.shade100),
              itemBuilder: (context, index) {
                String currentUnit = paginatedUnits[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  child: Row(
                    children: [
                      Expanded(child: Text(currentUnit, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87))),
                      Row(
                        mainAxisSize: MainAxisSize.min, 
                        children: [
                          _actionIcon(Icons.edit_rounded, Colors.blueAccent, () => _showUnitDialog(currentUnit: currentUnit)), 
                          const SizedBox(width: 12), 
                          _actionIcon(Icons.delete_outline_rounded, Colors.redAccent, _showDeleteDialog)
                        ]
                      ),
                    ],
                  ),
                );
              },
            ),
            if ((_filteredUnits.length / _itemsPerPage).ceil() > 1) ...[
              Container(decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))), child: _buildPagination()) 
            ]
          ],
        ),
      ),
    );
  }

  Widget _actionIcon(IconData icon, Color color, VoidCallback onTap) {
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

  Widget _buildPagination() {
    int totalPages = (_filteredUnits.length / _itemsPerPage).ceil();
    if (totalPages <= 1) return const SizedBox.shrink();

    List<Widget> pageButtons = [];
    pageButtons.add(_pageBox("Prev", false, () { if (_currentPage > 1) setState(() => _currentPage--); }));
    pageButtons.add(const SizedBox(width: 8));

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(_pageBox("$i", _currentPage == i, () { setState(() => _currentPage = i); }));
      if (i < totalPages) pageButtons.add(const SizedBox(width: 8));
    }

    pageButtons.add(const SizedBox(width: 8));
    pageButtons.add(_pageBox("Next", false, () { if (_currentPage < totalPages) setState(() => _currentPage++); }));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: pageButtons,
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
}