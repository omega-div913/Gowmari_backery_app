// lib/pm_uom_page.dart

import 'package:flutter/material.dart';
import 'masters_page.dart';

class PMUOMPage extends StatefulWidget {
  const PMUOMPage({super.key});

  @override
  State<PMUOMPage> createState() => _PMUOMPageState();
}

class _PMUOMPageState extends State<PMUOMPage> {
  final List<String> units = ['Grams', 'gram', 'pkt', 'pcs', 'ltr', 'per roll', 'box', 'kg'];

  // ==========================================
  // PAGINATION STATE
  // ==========================================
  int _currentPage = 1;
  final int _itemsPerPage = 5; // Set to 5 so you can see the pagination work with 8 items

  List<String> get paginatedUnits {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (startIndex >= units.length) return [];
    if (endIndex > units.length) endIndex = units.length;
    return units.sublist(startIndex, endIndex);
  }

  // ==========================================
  // 1. DELETE DIALOG (EXACT 2nd IMAGE DESIGN)
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
              // Orange Exclamation Mark Icon
              Container(
                height: 80, width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, 
                  border: Border.all(color: const Color(0xFFF8BB86), width: 3)
                ),
                child: const Center(
                  child: Text("!", style: TextStyle(fontSize: 45, color: Color(0xFFF8BB86), fontWeight: FontWeight.bold))
                ),
              ),
              const SizedBox(height: 20),
              const Text("Are you sure?", 
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)
              ),
              const SizedBox(height: 8),
              const Text("You won't be able to revert this!", 
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14)
              ),
              const SizedBox(height: 25),
              // Action Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), // Logic to delete here
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC3545), // RED BUTTON
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      elevation: 0,
                    ),
                    child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007BFF), // BLUE BUTTON
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      elevation: 0,
                    ),
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
  // 2. CREATE/EDIT DIALOG
  // ==========================================
  void _showUnitDialog({String? currentUnit}) {
    bool isEdit = currentUnit != null;
    final unitCtrl = TextEditingController(text: currentUnit ?? "");
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
                  Text(isEdit ? "Edit Unit" : "Create Unit", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 20)),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Unit Name (e.g., kg, pcs, ltr)", style: TextStyle(fontSize: 13, color: Colors.black54)),
              const SizedBox(height: 8),
              TextField(
                controller: unitCtrl,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close")),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1)),
                    child: Text(isEdit ? "Update Unit" : "Save Unit", style: const TextStyle(color: Colors.white)),
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
  // 3. MAIN UI
  // ==========================================
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;

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
                              _buildHeader(),
                              const SizedBox(height: 20),
                              _buildTableContainer(),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Packaging Unit Master", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
        ElevatedButton.icon(
          onPressed: () => _showUnitDialog(),
          icon: const Icon(Icons.add, size: 18, color: Colors.white),
          label: const Text("Create New Unit", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
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
          // Header Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(color: Colors.grey.shade50, border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
            child: const Row(
              children: [
                SizedBox(width: 50, child: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold))), // <-- Added S.No
                Expanded(child: Text("Unit Name", style: TextStyle(fontWeight: FontWeight.bold))),
                Text("Actions", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Data List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: paginatedUnits.length, // <-- Changed to paginated list
            separatorBuilder: (c, i) => const Divider(height: 1),
            itemBuilder: (context, index) {
              int sNo = (_currentPage - 1) * _itemsPerPage + index + 1; // <-- Calculated S.No
              String currentUnit = paginatedUnits[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    SizedBox(width: 50, child: Text("$sNo", style: const TextStyle(fontWeight: FontWeight.bold))), // <-- Added S.No
                    Expanded(child: Text(currentUnit)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _actionIcon(Icons.edit_outlined, Colors.blue, () => _showUnitDialog(currentUnit: currentUnit)),
                        const SizedBox(width: 8),
                        _actionIcon(Icons.delete_outline, Colors.red, _showDeleteDialog),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(height: 1),
          _buildPagination(), // <-- Added Pagination controls
        ],
      ),
    );
  }

  Widget _actionIcon(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: 32, height: 32,
      decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)),
      child: IconButton(padding: EdgeInsets.zero, icon: Icon(icon, size: 16, color: color), onPressed: onTap),
    );
  }

  // ==========================================
  // PAGINATION CONTROLS
  // ==========================================
  Widget _buildPagination() {
    int totalPages = (units.length / _itemsPerPage).ceil();
    if (totalPages <= 1) totalPages = 1;

    List<Widget> pageButtons = [];
    
    pageButtons.add(_pageBox("Prev", false, () {
      if (_currentPage > 1) setState(() => _currentPage--);
    }));
    pageButtons.add(const SizedBox(width: 5));

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(_pageBox("$i", _currentPage == i, () {
        setState(() => _currentPage = i);
      }));
      if (i < totalPages) pageButtons.add(const SizedBox(width: 5));
    }

    pageButtons.add(const SizedBox(width: 5));
    pageButtons.add(_pageBox("Next", false, () {
      if (_currentPage < totalPages) setState(() => _currentPage++);
    }));

    int startRecord = units.isEmpty ? 0 : ((_currentPage - 1) * _itemsPerPage) + 1;
    int endRecord = _currentPage * _itemsPerPage;
    if (endRecord > units.length) endRecord = units.length;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Showing $startRecord to $endRecord of ${units.length} entries", style: const TextStyle(fontSize: 13, color: Colors.grey)),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 2, 
            runSpacing: 8,
            children: pageButtons
          ),
        ],
      ),
    );
  }

  Widget _pageBox(String t, bool active, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), 
      decoration: BoxDecoration(
        color: active ? Colors.blue : Colors.white, 
        border: Border.all(color: active ? Colors.blue : Colors.grey.shade300), 
        borderRadius: BorderRadius.circular(4)
      ), 
      child: Text(t, style: TextStyle(color: active ? Colors.white : Colors.blue, fontSize: 12, fontWeight: FontWeight.bold))
    ),
  );
}