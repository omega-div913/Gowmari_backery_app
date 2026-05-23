import 'package:flutter/material.dart';
import 'subsidebar.dart'; // Keeping this for MasterTopbar and SecondaryMastersSidebar
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Modern rounded corners
          backgroundColor: Colors.white,
          elevation: 10,
          child: SizedBox(
            width: 450, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 20, top: 20, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Create Unit", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                          child: Icon(Icons.close, size: 18, color: Colors.grey.shade700),
                        ),
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
                      const Text("Unit Name (e.g., kg, pcs, ltr)", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
                      const SizedBox(height: 10),
                      TextFormField( // Modern filled text field
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2962FF), width: 1.5)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2962FF), 
                              elevation: 2, 
                              shadowColor: const Color(0xFF2962FF).withOpacity(0.4),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Save Unit", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          elevation: 10,
          child: SizedBox(
            width: 450, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 20, top: 20, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Edit Unit", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                      InkWell(
                        onTap: () => Navigator.pop(context), 
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                          child: Icon(Icons.close, size: 18, color: Colors.grey.shade700),
                        )
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
                      const Text("Unit Name (e.g., kg, pcs, ltr)", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2962FF), width: 1.5)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), 
                            onPressed: () => Navigator.pop(context), 
                            child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600))
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), elevation: 2, shadowColor: const Color(0xFF2962FF).withOpacity(0.4), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), 
                            onPressed: () => Navigator.pop(context), 
                            child: const Text("Update Unit", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
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

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          elevation: 10,
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80, height: 80, 
                  decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle), 
                  child: const Center(child: Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 40))
                ),
                const SizedBox(height: 24),
                const Text("Delete Unit?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87), textAlign: TextAlign.center),
                const SizedBox(height: 12),
                Text("This action cannot be undone. Are you sure you want to permanently delete this unit?", style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5), textAlign: TextAlign.center),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), 
                        onPressed: () => Navigator.pop(context), 
                        child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600))
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, elevation: 2, shadowColor: Colors.redAccent.withOpacity(0.4), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), 
                        onPressed: () => Navigator.pop(context), 
                        child: const Text("Delete", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
                      ),
                    ),
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
      drawer: isMobile ? const Drawer(child: AppSidebar(activeMenu: "Masters")) : null,
      appBar: isMobile ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Unit of Measurement", style: TextStyle(color: Colors.black, fontSize: 16))) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isTablet) const MobileSecondaryMenu(activePage: 'UOM'),
                                if (isTablet) const SizedBox(height: 20),
                                _buildPageHeader(context, isTablet), 
                                const SizedBox(height: 24),
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
        const Text("Unit of Measurement", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
        if (!isTablet) const Spacer(),
        if (isTablet) const SizedBox(height: 20),
        Container(
          width: isTablet ? double.infinity : 250, 
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9), 
            borderRadius: BorderRadius.circular(8), 
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search units...", 
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500), 
              prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey.shade500), 
              border: InputBorder.none, 
              contentPadding: const EdgeInsets.symmetric(vertical: 12)
            )
          ),
        ),
        SizedBox(width: isTablet ? 0 : 15, height: isTablet ? 16 : 0),
        SizedBox(
          width: isTablet ? double.infinity : null, 
          height: 40,
          child: ElevatedButton.icon(
            onPressed: () => _showCreateUnitDialog(context), 
            icon: const Icon(Icons.add, size: 16, color: Colors.white), 
            label: const Text("Create New Unit", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)), 
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2962FF), 
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)) // Pill shape like Image 1
            )
          ),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(8), 
        border: Border.all(color: Colors.grey.shade200)
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), 
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: Row(
              children: [
                SizedBox(width: 60, child: Text("S.NO", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.black87))), 
                Expanded(child: Text("UNIT NAME", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.black87))), 
                Text("ACTIONS", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.black87))
              ]
            ),
          ),
          ListView.separated(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: paginatedUnits.length, 
            separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade100), 
            itemBuilder: (context, index) {
              int sNo = index + 1 + (_currentPage - 1) * _itemsPerPage;
              String currentUnit = paginatedUnits[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    SizedBox(width: 60, child: Text("$sNo", style: const TextStyle(fontSize: 13, color: Colors.black87))),
                    Expanded(child: Text(currentUnit, style: const TextStyle(fontSize: 13, color: Colors.black87))),
                    Row(
                      children: [
                        _actionBtn(Icons.edit_outlined, Colors.blue, () => _showEditUnitDialog(context, currentUnit)), 
                        const SizedBox(width: 8), 
                        _actionBtn(Icons.delete_outline, Colors.red, () => _showDeleteDialog(context))
                      ]
                    ),
                  ]
                ),
              );
            },
          ),
          Container( 
            decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))),
            child: _buildPagination()
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: 32, height: 32, 
        decoration: BoxDecoration(
          color: Colors.white, 
          border: Border.all(color: color.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(4)
        ),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }

  Widget _buildPagination() {
    int totalPages = (units.length / _itemsPerPage).ceil();
    if (totalPages <= 1) totalPages = 1;

    List<Widget> pageButtons = [];
    pageButtons.add(_pageBox("Prev", false, () { if (_currentPage > 1) setState(() => _currentPage--); }));

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(_pageBox("$i", _currentPage == i, () { setState(() => _currentPage = i); }));
    }

    pageButtons.add(_pageBox("Next", false, () { if (_currentPage < totalPages) setState(() => _currentPage++); }));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: pageButtons
      )
    );
  }

  Widget _pageBox(String t, bool active, VoidCallback onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(4),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), 
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF2962FF) : Colors.white, 
        border: Border.all(color: active ? const Color(0xFF2962FF) : Colors.grey.shade300), 
        borderRadius: BorderRadius.circular(4)
      ), 
      child: Text(t, style: TextStyle(color: active ? Colors.white : Colors.black87, fontSize: 13))
    ),
  );
}