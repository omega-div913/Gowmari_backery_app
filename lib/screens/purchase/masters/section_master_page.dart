import 'package:flutter/material.dart';
import 'subsidebar.dart'; // Import unified layout
import 'package:gowmari_mobile/screens/components/app_sidebar.dart'; 

class SectionMasterPage extends StatefulWidget {
  const SectionMasterPage({super.key});

  @override
  State<SectionMasterPage> createState() => _SectionMasterPageState();
}

class _SectionMasterPageState extends State<SectionMasterPage> {
  bool isSectionsTabActive = true; 

  int _currentPage = 1;
  int _itemsPerPage = 5;

  String? editSectionId;
  final TextEditingController _sectionNameCtrl = TextEditingController();
  String _selectedVisibility = "Both";
  final List<String> visibilityOptions = ["Both", "Purchase", "Sales"];

  String? editSubSectionId;
  String _selectedParentSection = "BAKERY";
  final TextEditingController _subSectionNameCtrl = TextEditingController();
  final List<String> parentOptions = ["Select a Section...", "BAKERY", "SWEET", "KITCHEN"];

  final List<Map<String, String>> sectionsData = [
    {"id": "1", "name": "BAKERY", "visibility": "Both"},
    {"id": "2", "name": "SWEET", "visibility": "Both"},
    {"id": "3", "name": "MURUKKU", "visibility": "Both"},
    {"id": "9", "name": "KOLUKATTAI", "visibility": "Both"},
    {"id": "10", "name": "KAARAM", "visibility": "Both"},
    {"id": "11", "name": "KADALAI MITTAI", "visibility": "Both"},
    {"id": "16", "name": "KAJU", "visibility": "Both"},
    {"id": "17", "name": "KITCHEN", "visibility": "Purchase"},
    {"id": "18", "name": "PACKING", "visibility": "Purchase"},
    {"id": "19", "name": "LAB", "visibility": "Purchase"},
  ];

  final List<Map<String, String>> subSectionsData = [
    {"id": "1", "parent": "BAKERY", "name": "PUFF'S"},
    {"id": "2", "parent": "", "name": "REGULAR KARAM"},
    {"id": "3", "parent": "", "name": "SPL.KARAM"},
    {"id": "5", "parent": "", "name": "C"},
    {"id": "6", "parent": "SWEET", "name": "REGULAR SWEET'S"},
    {"id": "7", "parent": "SWEET", "name": "MILK SWEET'S"},
    {"id": "8", "parent": "SWEET", "name": "KAJU & DRY FRUIIT & NUTS SWEET'S"},
    {"id": "9", "parent": "SWEET", "name": "GHEE SWEET'S"},
    {"id": "10", "parent": "SWEET", "name": "SPL SWEET'S"},
    {"id": "12", "parent": "SWEET", "name": "JAMUN SWEET'S"},
    {"id": "13", "parent": "SWEET", "name": "RASGULLA SWEET'S"},
  ];

  List<Map<String, String>> get paginatedSections {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (startIndex >= sectionsData.length) return [];
    if (endIndex > sectionsData.length) endIndex = sectionsData.length;
    return sectionsData.sublist(startIndex, endIndex);
  }

  List<Map<String, String>> get paginatedSubSections {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (startIndex >= subSectionsData.length) return [];
    if (endIndex > subSectionsData.length) endIndex = subSectionsData.length;
    return subSectionsData.sublist(startIndex, endIndex);
  }

  @override
  void dispose() {
    _sectionNameCtrl.dispose();
    _subSectionNameCtrl.dispose();
    super.dispose();
  }

  void _switchTab(bool toSections) {
    setState(() {
      isSectionsTabActive = toSections;
      _currentPage = 1;
      editSectionId = null;
      editSubSectionId = null;
      _sectionNameCtrl.clear();
      _subSectionNameCtrl.clear();
    });
  }

  void _startEditingSection(Map<String, String> data) {
    setState(() {
      editSectionId = data["id"];
      _sectionNameCtrl.text = data["name"]!;
      _selectedVisibility = data["visibility"]!;
    });
  }

  void _startEditingSubSection(Map<String, String> data) {
    setState(() {
      editSubSectionId = data["id"];
      _subSectionNameCtrl.text = data["name"]!;
      _selectedParentSection = data["parent"]!.isNotEmpty ? data["parent"]! : "BAKERY"; 
    });
  }

  void _cancelEditing() {
    setState(() {
      editSectionId = null;
      editSubSectionId = null;
      _sectionNameCtrl.clear();
      _subSectionNameCtrl.clear();
      _selectedVisibility = "Both";
      _selectedParentSection = "BAKERY";
    });
  }

  void _showDeleteDialog(BuildContext context, String warningText) {
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
                Text(warningText, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5), textAlign: TextAlign.center),
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
      appBar: isMobile ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Section Master", style: TextStyle(color: Colors.black, fontSize: 16))) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const AppSidebar(activeMenu: "Masters"),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) const MasterTopbar(breadcrumb: "Home / Purchase Section / Masters / Sections"),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isTablet) const SizedBox(width: 260, child: SecondaryMastersSidebar(activePage: 'Section Master')),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(30), // Increased padding for breathability
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isTablet) const MobileSecondaryMenu(activePage: 'Section Master'),
                                if (isTablet) const SizedBox(height: 20),
                                const Text("Section Master", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1A237E))), // Modern Header
                                const SizedBox(height: 24),
                                _buildTabs(),
                                const SizedBox(height: 24),
                                if (isSectionsTabActive) ...[
                                  _buildSectionsForm(), const SizedBox(height: 24), _buildSectionsTable(),
                                ] else ...[
                                  _buildSubSectionsForm(), const SizedBox(height: 24), _buildSubSectionsTable(),
                                ],
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

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 2.0))), // Softer border
      child: Row(
        children: [
          _tabItem("Sections", isSectionsTabActive, () => _switchTab(true)),
          _tabItem("Sub Sections", !isSectionsTabActive, () => _switchTab(false)),
        ],
      ),
    );
  }

  Widget _tabItem(String title, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(color: isActive ? const Color(0xFF2962FF) : Colors.transparent, width: 3.0) // Sleek active indicator
          ),
        ),
        child: Text(title, style: TextStyle(color: isActive ? const Color(0xFF2962FF) : Colors.grey.shade500, fontWeight: isActive ? FontWeight.bold : FontWeight.w600, fontSize: 14)),
      ),
    );
  }

  Widget _buildSectionsForm() {
    bool isEditing = editSectionId != null;
    return Container(
      width: double.infinity, 
      padding: const EdgeInsets.all(24), 
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16), // Modern card
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 4))]
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end, spacing: 20, runSpacing: 20,
        children: [
          _buildTextField(isEditing ? "Edit Section" : "Section Name", "e.g. Cold Storage, Factory A", _sectionNameCtrl, 300),
          _buildDropdown("Visibility", visibilityOptions, _selectedVisibility, (val) => setState(() => _selectedVisibility = val!), 220),
          if (!isEditing)
            SizedBox(
              height: 44, 
              child: ElevatedButton.icon(
                onPressed: () {}, icon: const Icon(Icons.add_circle_outline, size: 18, color: Colors.white), label: const Text("Add Section", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)), 
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), shadowColor: const Color(0xFF2962FF).withOpacity(0.4), elevation: 3, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
              )
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 44, child: OutlinedButton(onPressed: _cancelEditing, style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600)))),
                const SizedBox(width: 12),
                SizedBox(height: 44, child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.check_circle_outline, size: 18, color: Colors.white), label: const Text("Update Section", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00B0FF), shadowColor: const Color(0xFF00B0FF).withOpacity(0.4), elevation: 3, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))))),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSectionsTable() {
    return Container(
      width: double.infinity, 
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16), 
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 5))]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 850, 
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), 
                      color: const Color(0xFFF8FAFC), // Modern header
                      child: const Row(children: [SizedBox(width: 60, child: Text("S.NO", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), Expanded(child: Text("SECTION NAME", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), SizedBox(width: 150, child: Text("VISIBILITY", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), SizedBox(width: 120, child: Text("ACTIONS", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey)))]),
                    ),
                    ListView.separated(
                      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: paginatedSections.length,
                      separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade100),
                      itemBuilder: (context, index) {
                        final data = paginatedSections[index];
                        int sNo = index + 1 + (_currentPage - 1) * _itemsPerPage;
                        bool isRowEditing = data["id"] == editSectionId;
                        bool isBoth = data["visibility"] == "Both";

                        return Container(
                          color: isRowEditing ? Colors.blue.shade50.withOpacity(0.5) : Colors.transparent, // Modern edit highlight
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          child: Row(
                            children: [
                              SizedBox(width: 60, child: Text("$sNo", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87))),
                              Expanded(child: Text(data["name"]!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87))),
                              SizedBox(width: 150, child: Align(alignment: Alignment.centerLeft, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: isBoth ? const Color(0xFF00BFA5) : const Color(0xFF00B0FF), borderRadius: BorderRadius.circular(20)), child: Text(data["visibility"]!, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))))),
                              SizedBox(width: 120, child: Row(children: [_actionBtn(Icons.edit_rounded, Colors.blueAccent, () => _startEditingSection(data)), const SizedBox(width: 10), _actionBtn(Icons.delete_outline_rounded, Colors.redAccent, () => _showDeleteDialog(context, "Raw materials and Sub-Sections linked to this will be deleted/lose link."))])),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))), child: _buildPagination(isSection: true)),
          ],
        ),
      ),
    );
  }

  Widget _buildSubSectionsForm() {
    bool isEditing = editSubSectionId != null;
    return Container(
      width: double.infinity, 
      padding: const EdgeInsets.all(24), 
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16), 
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 4))]
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end, spacing: 20, runSpacing: 20,
        children: [
          _buildDropdown("Parent Section", parentOptions, _selectedParentSection, (val) => setState(() => _selectedParentSection = val!), 240),
          _buildTextField(isEditing ? "Edit Sub Section" : "Sub Section Name", "e.g. Freezer 1", _subSectionNameCtrl, 300),
          if (!isEditing)
            SizedBox(
              height: 44, 
              child: ElevatedButton.icon(
                onPressed: () {}, icon: const Icon(Icons.add_circle_outline, size: 18, color: Colors.white), label: const Text("Add Sub Section", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)), 
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00C853), shadowColor: const Color(0xFF00C853).withOpacity(0.4), elevation: 3, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
              )
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 44, child: OutlinedButton(onPressed: _cancelEditing, style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600)))),
                const SizedBox(width: 12),
                SizedBox(height: 44, child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.check_circle_outline, size: 18, color: Colors.white), label: const Text("Update Sub Section", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFAB00), shadowColor: const Color(0xFFFFAB00).withOpacity(0.4), elevation: 3, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))))),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSubSectionsTable() {
    return Container(
      width: double.infinity, 
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16), 
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 5))]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 850, 
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), 
                      color: const Color(0xFFF8FAFC), 
                      child: const Row(children: [SizedBox(width: 60, child: Text("S.NO", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), SizedBox(width: 200, child: Text("PARENT SECTION", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), Expanded(child: Text("SUB SECTION NAME", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), SizedBox(width: 120, child: Text("ACTIONS", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey)))]),
                    ),
                    ListView.separated(
                      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: paginatedSubSections.length,
                      separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade100),
                      itemBuilder: (context, index) {
                        final data = paginatedSubSections[index];
                        int sNo = index + 1 + (_currentPage - 1) * _itemsPerPage;
                        bool isRowEditing = data["id"] == editSubSectionId;

                        return Container(
                          color: isRowEditing ? Colors.blue.shade50.withOpacity(0.5) : Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          child: Row(
                            children: [
                              SizedBox(width: 60, child: Text("$sNo", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87))),
                              SizedBox(width: 200, child: data["parent"]!.isNotEmpty ? Align(alignment: Alignment.centerLeft, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.blueGrey.shade100, borderRadius: BorderRadius.circular(6)), child: Text(data["parent"]!, style: TextStyle(color: Colors.blueGrey.shade800, fontSize: 11, fontWeight: FontWeight.bold)))) : const SizedBox.shrink()),
                              Expanded(child: Text(data["name"]!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87))),
                              SizedBox(width: 120, child: Row(children: [_actionBtn(Icons.edit_rounded, Colors.blueAccent, () => _startEditingSubSection(data)), const SizedBox(width: 10), _actionBtn(Icons.delete_outline_rounded, Colors.redAccent, () => _showDeleteDialog(context, "This sub-section will be permanently deleted."))])),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))), child: _buildPagination(isSection: false)),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination({required bool isSection}) {
    int totalItems = isSection ? sectionsData.length : subSectionsData.length;
    int totalPages = (totalItems / _itemsPerPage).ceil();
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
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Showing ${isSection ? paginatedSections.length : paginatedSubSections.length} of $totalItems entries", style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
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
      decoration: BoxDecoration(
        color: active ? const Color(0xFF2962FF) : Colors.transparent, 
        border: Border.all(color: active ? const Color(0xFF2962FF) : Colors.grey.shade300), 
        borderRadius: BorderRadius.circular(8)
      ), 
      child: Text(t, style: TextStyle(color: active ? Colors.white : Colors.black87, fontSize: 13, fontWeight: active ? FontWeight.bold : FontWeight.w500))
    ),
  );

  Widget _buildTextField(String label, String hint, TextEditingController controller, double width) {
    return Container(
      constraints: BoxConstraints(maxWidth: width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)), const SizedBox(height: 8),
          TextFormField(
            controller: controller, 
            decoration: InputDecoration(
              hintText: hint, 
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400), 
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), 
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none), 
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2962FF), width: 1.5))
            )
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String currentValue, ValueChanged<String?> onChanged, double width) {
    return Container(
      constraints: BoxConstraints(maxWidth: width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)), const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: currentValue, 
            icon: Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey.shade600), 
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), 
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none), 
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2962FF), width: 1.5))
            ), 
            items: items.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontSize: 14)))).toList(), 
            onChanged: onChanged
          ),
        ],
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
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}