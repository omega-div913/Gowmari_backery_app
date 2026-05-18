import 'package:flutter/material.dart';
import 'subsidebar.dart'; // Import unified layout

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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: Container(
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 3)), child: const Center(child: Text("!", style: TextStyle(fontSize: 50, color: Color(0xFFF8BB86), fontWeight: FontWeight.w300)))),
                const SizedBox(height: 25),
                const Text("Are you sure?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                const Text("You won't be able to revert this!", style: TextStyle(fontSize: 14, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 25),
                Wrap(
                  alignment: WrapAlignment.center, spacing: 10, runSpacing: 10,
                  children: [
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7367F0), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), onPressed: () => Navigator.pop(context), child: const Text("OK", style: TextStyle(color: Colors.white, fontSize: 14))),
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF82868B), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 14))),
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
      drawer: isMobile ? const Drawer(child: MasterPrimarySidebar()) : null,
      appBar: isMobile ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Material Type Master", style: TextStyle(color: Colors.black, fontSize: 16))) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const SizedBox(width: 250, child: MasterPrimarySidebar()),
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
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isTablet) const MobileSecondaryMenu(activePage: 'Material Type Master'),
                                if (isTablet) const SizedBox(height: 20),
                                const Text("Material Type Master", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                                const SizedBox(height: 20),
                                if (isTablet)
                                  Column(children: [_buildActionForm(), const SizedBox(height: 20), _buildDataTable()])
                                else
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(flex: 2, child: _buildActionForm()),
                                      const SizedBox(width: 25),
                                      Expanded(flex: 5, child: _buildDataTable()),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isEditing ? "Edit Material Type" : "Add New Material Type", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 15),
          SizedBox(
            height: 40,
            child: TextField(
              controller: _typeController,
              decoration: InputDecoration(hintText: isEditing ? "" : "e.g. Sweets", hintStyle: const TextStyle(fontSize: 13, color: Colors.grey), filled: true, fillColor: const Color(0xFFF8F9FA), contentPadding: const EdgeInsets.symmetric(horizontal: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none)),
            ),
          ),
          const SizedBox(height: 20),
          if (!isEditing)
            SizedBox(width: double.infinity, height: 40, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), onPressed: () {}, child: const Text("Save Type", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold))))
          else
            Column(
              children: [
                SizedBox(width: double.infinity, height: 40, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), onPressed: () => _cancelEdit(), child: const Text("Update Type", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)))),
                const SizedBox(height: 10),
                SizedBox(width: double.infinity, height: 40, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF3F4F6), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), onPressed: _cancelEdit, child: const Text("Cancel", style: TextStyle(color: Colors.black87, fontSize: 13)))),
              ],
            )
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 40,
              decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(6)),
              child: const TextField(decoration: InputDecoration(hintText: "Search material types...", hintStyle: TextStyle(fontSize: 13, color: Colors.grey), contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12), border: InputBorder.none)),
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: Row(children: const [SizedBox(width: 50, child: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), Expanded(child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), SizedBox(width: 80, child: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center))]),
          ),
          ListView.separated(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: paginatedTypes.length,
            separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade200),
            itemBuilder: (context, index) {
              int sNo = index + 1 + (_currentPage - 1) * _itemsPerPage;
              String currentType = paginatedTypes[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    SizedBox(width: 50, child: Text("$sNo", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87))),
                    Expanded(child: Text(currentType, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600))),
                    SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _actionBtn(Icons.edit_outlined, Colors.blue, () => _startEdit(currentType)), 
                          const SizedBox(width: 8),
                          _actionBtn(Icons.delete_outline, Colors.red, () => _showDeleteDialog(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          _buildPagination(), 
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: 30, height: 30,
      decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)),
      child: IconButton(padding: EdgeInsets.zero, icon: Icon(icon, size: 16, color: color), onPressed: onTap),
    );
  }

  Widget _buildPagination() {
    int totalPages = (materialTypes.length / _itemsPerPage).ceil();
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
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Showing ${paginatedTypes.length} of ${materialTypes.length} entries", style: const TextStyle(fontSize: 13, color: Colors.grey)),
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




