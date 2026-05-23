import 'package:flutter/material.dart';
import 'subsidebar.dart'; // Import unified layout
import 'package:gowmari_mobile/screens/components/app_sidebar.dart'; 

class MaterialTypeMasterPage extends StatefulWidget {
  const MaterialTypeMasterPage({super.key});

  @override
  State<MaterialTypeMasterPage> createState() => _MaterialTypeMasterPageState();
}

class _MaterialTypeMasterPageState extends State<MaterialTypeMasterPage> {
  final List<String> materialTypes = [
    'BAKERY', 'CHAT MATERIAL', 'CLEANING MATERIAL', 'PACKING MATERIAL',
    'RAW MATERIAL', 'SERVICE MATERIAL', 'TEA COFFE MATERIAL',
    'VADA MATERIAL', 'VEGETABLES'
  ];

  // --- PAGINATION STATE ---
  int _currentPage = 1;
  int _itemsPerPage = 5;

  List<String> get paginatedTypes {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (startIndex >= materialTypes.length) return [];
    if (endIndex > materialTypes.length) endIndex = materialTypes.length;
    return materialTypes.sublist(startIndex, endIndex);
  }

  bool isEditing = false;
  String? currentlyEditingType;
  final TextEditingController _typeController = TextEditingController();

  void _startEdit(String type) {
    setState(() {
      isEditing = true;
      currentlyEditingType = type;
      _typeController.text = type;
    });
  }

  void _cancelEdit() {
    setState(() {
      isEditing = false;
      currentlyEditingType = null;
      _typeController.clear();
    });
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Modern rounded corners
          backgroundColor: Colors.white,
          elevation: 10,
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container( // Modern icon container
                  width: 80, height: 80, 
                  decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle), 
                  child: const Center(child: Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 40))
                ),
                const SizedBox(height: 24),
                const Text("Are you sure?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87), textAlign: TextAlign.center),
                const SizedBox(height: 12),
                Text("This action cannot be undone. You won't be able to revert this!", style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5), textAlign: TextAlign.center),
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
                        child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
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
      appBar: isMobile ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Material Type Master", style: TextStyle(color: Colors.black, fontSize: 16))) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const AppSidebar(activeMenu: "Masters"),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) const MasterTopbar(breadcrumb: "Home / Purchase Section / Masters / Product Types"),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isTablet) const SizedBox(width: 260, child: SecondaryMastersSidebar(activePage: 'Material Type Master')),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(30), // Increased padding
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isTablet) const MobileSecondaryMenu(activePage: 'Material Type Master'),
                                if (isTablet) const SizedBox(height: 20),
                                const Text("Material Type Master", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1A237E))), // Modern Header
                                const SizedBox(height: 24),
                                if (isTablet)
                                  Column(children: [_buildActionForm(), const SizedBox(height: 24), _buildDataTable()])
                                else
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(flex: 3, child: _buildActionForm()),
                                      const SizedBox(width: 24),
                                      Expanded(flex: 6, child: _buildDataTable()),
                                    ],
                                  )
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

  Widget _buildActionForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16), 
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 4))]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isEditing ? "Edit Material Type" : "Add New Material Type", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 20),
          TextFormField(
            controller: _typeController,
            decoration: InputDecoration(
              hintText: isEditing ? "" : "e.g. Sweets", 
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400), 
              filled: true, 
              fillColor: Colors.grey.shade50, 
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), 
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2962FF), width: 1.5))
            ),
          ),
          const SizedBox(height: 24),
          if (!isEditing)
            SizedBox(
              width: double.infinity, 
              height: 44, 
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), shadowColor: const Color(0xFF2962FF).withOpacity(0.4), elevation: 3, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), 
                onPressed: () {}, 
                child: const Text("Save Type", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
              )
            )
          else
            Column(
              children: [
                SizedBox(width: double.infinity, height: 44, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), shadowColor: const Color(0xFF2962FF).withOpacity(0.4), elevation: 3, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), onPressed: () => _cancelEdit(), child: const Text("Update Type", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)))),
                const SizedBox(height: 12),
                SizedBox(width: double.infinity, height: 44, child: OutlinedButton(style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), onPressed: _cancelEdit, child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600)))),
              ],
            )
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16), 
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 5))]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Container(
                height: 44,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)),
                child: TextField(decoration: InputDecoration(hintText: "Search material types...", hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400), prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey.shade500), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), border: InputBorder.none)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              color: const Color(0xFFF8FAFC), // Modern header
              child: Row(children: const [SizedBox(width: 60, child: Text("S.NO", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), Expanded(child: Text("NAME", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), SizedBox(width: 100, child: Text("ACTIONS", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey), textAlign: TextAlign.center))]),
            ),
            ListView.separated(
              shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: paginatedTypes.length,
              separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade100),
              itemBuilder: (context, index) {
                int sNo = index + 1 + (_currentPage - 1) * _itemsPerPage;
                String currentType = paginatedTypes[index];
                bool isRowEditing = currentType == currentlyEditingType;

                return Container(
                  color: isRowEditing ? Colors.blue.shade50.withOpacity(0.5) : Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  child: Row(
                    children: [
                      SizedBox(width: 60, child: Text("$sNo", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87))),
                      Expanded(child: Text(currentType, style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500))),
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _actionBtn(Icons.edit_rounded, Colors.blueAccent, () => _startEdit(currentType)), 
                            const SizedBox(width: 12),
                            _actionBtn(Icons.delete_outline_rounded, Colors.redAccent, () => _showDeleteDialog(context)),
                          ],
                        ),
                      ),
                    ],
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
      ),
    );
  }

  Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) {
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
    int totalPages = (materialTypes.length / _itemsPerPage).ceil();
    if (totalPages <= 1) totalPages = 1;

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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Showing ${paginatedTypes.length} of ${materialTypes.length} entries", style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
          Row(children: pageButtons),
        ],
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