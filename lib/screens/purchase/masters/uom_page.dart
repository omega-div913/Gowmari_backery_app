import 'package:flutter/material.dart';
import 'subsidebar.dart'; // Keeping this for MasterTopbar and SecondaryMastersSidebar
// ADDED THE CORRECT IMPORT FOR OUR NEW SIDEBAR:
import 'package:gowmari_mobile/screens/components/app_sidebar.dart'; 

class UOMPage extends StatefulWidget {
  const UOMPage({super.key});

  @override
  State<UOMPage> createState() => _UOMPageState();
}

class _UOMPageState extends State<UOMPage> {
  final List<String> units = ['bag', 'box', 'gram', 'kg', 'ltr', 'ml', 'nos', 'pcs', 'per roll', 'pkt'];

  // ==========================================
  // PAGINATION STATE
  // ==========================================
  int _currentPage = 1;
  int _itemsPerPage = 5; 

  List<String> get paginatedUnits {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (startIndex >= units.length) return [];
    if (endIndex > units.length) endIndex = units.length;
    return units.sublist(startIndex, endIndex);
  }

  void _showCreateUnitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: SizedBox(
            width: 550, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Create Unit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, size: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey.shade300),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Unit Name (e.g., kg, pcs, ltr)", style: TextStyle(fontSize: 13, color: Colors.black87)),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Colors.blue)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          SizedBox(
                            height: 38,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Close", style: TextStyle(color: Colors.white, fontSize: 13)),
                            ),
                          ),
                          SizedBox(
                            height: 38,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Save Unit", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void _showEditUnitDialog(BuildContext context, String currentUnitName) {
    TextEditingController controller = TextEditingController(text: currentUnitName);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: SizedBox(
            width: 550, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Edit Unit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                      InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, size: 20, color: Colors.grey)),
                    ],
                  ),
                ),
                Divider(height: 1, color: Colors.grey.shade300),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Unit Name (e.g., kg, pcs, ltr)", style: TextStyle(fontSize: 13, color: Colors.black87)),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Colors.blue)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          SizedBox(height: 38, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), onPressed: () => Navigator.pop(context), child: const Text("Close", style: TextStyle(color: Colors.white, fontSize: 13)))),
                          SizedBox(height: 38, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), onPressed: () => Navigator.pop(context), child: const Text("Update Unit", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)))),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 4)), child: const Center(child: Text("!", style: TextStyle(fontSize: 50, color: Color(0xFFF8BB86), fontWeight: FontWeight.w300)))),
                const SizedBox(height: 25),
                const Text("Are you sure?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                const Text("You won't be able to revert this!", style: TextStyle(fontSize: 14, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 30),
                Wrap(
                  alignment: WrapAlignment.center, spacing: 10, runSpacing: 10, 
                  children: [
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC3545), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))), onPressed: () => Navigator.pop(context), child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white, fontSize: 14))),
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))), onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 14))),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;
    bool isTablet = screenWidth < 850;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      // CHANGED HERE: Using AppSidebar
      drawer: isMobile ? const Drawer(child: AppSidebar(activeMenu: "Masters")) : null,
      appBar: isMobile ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Unit of Measurement", style: TextStyle(color: Colors.black, fontSize: 16))) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CHANGED HERE: Using AppSidebar and explicitly telling it "Masters" is active!
          if (!isMobile) const AppSidebar(activeMenu: "Masters"),
          
          Expanded(
            child: Column(
              children: [
                if (!isMobile) const MasterTopbar(breadcrumb: "Home / Purchase Section / Masters / Units"),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isTablet) const SizedBox(width: 260, child: SecondaryMastersSidebar(activePage: 'UOM')),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isTablet) const MobileSecondaryMenu(activePage: 'UOM'),
                                if (isTablet) const SizedBox(height: 20),
                                _buildPageHeader(context, isTablet), 
                                const SizedBox(height: 20),
                                _buildDataTable(),
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

  Widget _buildPageHeader(BuildContext context, bool isTablet) {
    return Flex(
      direction: isTablet ? Axis.vertical : Axis.horizontal,
      crossAxisAlignment: isTablet ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        const Text("Unit of Measurement", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
        if (!isTablet) const Spacer(),
        if (isTablet) const SizedBox(height: 15),
        Container(
          width: isTablet ? double.infinity : 280, height: 40,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)),
          child: const TextField(decoration: InputDecoration(hintText: "Search units...", hintStyle: TextStyle(fontSize: 13, color: Colors.grey), prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 12))),
        ),
        SizedBox(width: isTablet ? 0 : 15, height: isTablet ? 15 : 0),
        SizedBox(
          width: isTablet ? double.infinity : null, height: 40,
          child: ElevatedButton.icon(onPressed: () => _showCreateUnitDialog(context), icon: const Icon(Icons.add, size: 18, color: Colors.white), label: const Text("Create New Unit", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), elevation: 0)),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
            child: const Row(children: [SizedBox(width: 60, child: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))), Expanded(child: Text("Unit Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))), Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))]),
          ),
          ListView.separated(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: paginatedUnits.length, separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              int sNo = index + 1 + (_currentPage - 1) * _itemsPerPage;
              String currentUnit = paginatedUnits[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: Row(children: [
                  SizedBox(width: 60, child: Text("$sNo", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87))),
                  Expanded(child: Text(currentUnit, style: const TextStyle(fontSize: 14, color: Colors.black87))),
                  Row(children: [_actionBtn(Icons.edit_outlined, Colors.blue, () => _showEditUnitDialog(context, currentUnit)), const SizedBox(width: 8), _actionBtn(Icons.delete_outline, Colors.red, () => _showDeleteDialog(context))]),
                ]),
              );
            },
          ),
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: 32, height: 32, decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)),
      child: IconButton(padding: EdgeInsets.zero, icon: Icon(icon, size: 16, color: color), onPressed: onTap),
    );
  }

  Widget _buildPagination() {
    int totalPages = (units.length / _itemsPerPage).ceil();
    if (totalPages <= 1) totalPages = 1;

    List<Widget> pageButtons = [];
    pageButtons.add(_pageBox("Prev", false, () { if (_currentPage > 1) setState(() => _currentPage--); }));
    pageButtons.add(const SizedBox(width: 5));

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(_pageBox("$i", _currentPage == i, () { setState(() => _currentPage = i); }));
      if (i < totalPages) pageButtons.add(const SizedBox(width: 5));
    }

    pageButtons.add(const SizedBox(width: 5));
    pageButtons.add(_pageBox("Next", false, () { if (_currentPage < totalPages) setState(() => _currentPage++); }));

    return Padding(
      padding: const EdgeInsets.all(16.0), 
      child: Wrap(alignment: WrapAlignment.center, spacing: 2, runSpacing: 8, children: pageButtons)
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