import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/dashboard/dashboard_screen.dart';
import 'package:gowmari_mobile/screens/masters/vendor_master_page.dart';
import 'package:gowmari_mobile/screens/masters/material_type_master_page.dart';
import 'package:gowmari_mobile/screens/masters/masters_page.dart';

class SectionMasterPage extends StatefulWidget {
  const SectionMasterPage({super.key});

  @override
  State<SectionMasterPage> createState() => _SectionMasterPageState();
}

class _SectionMasterPageState extends State<SectionMasterPage> {
  // --- TAB STATE ---
  bool isSectionsTabActive = true; 

  // --- PAGINATION STATE ---
  int _currentPage = 1;
  int _itemsPerPage = 5;

  // --- 1. STATE VARIABLES FOR SECTIONS ---
  String? editSectionId;
  final TextEditingController _sectionNameCtrl = TextEditingController();
  String _selectedVisibility = "Both";
  final List<String> visibilityOptions = ["Both", "Purchase", "Sales"];

  // --- 2. STATE VARIABLES FOR SUB SECTIONS ---
  String? editSubSectionId;
  String _selectedParentSection = "BAKERY";
  final TextEditingController _subSectionNameCtrl = TextEditingController();
  final List<String> parentOptions = ["Select a Section...", "BAKERY", "SWEET", "KITCHEN"];

  // --- DUMMY DATA ---
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

  // --- PAGINATION GETTERS ---
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

  // --- ACTION METHODS ---
  void _switchTab(bool toSections) {
    setState(() {
      isSectionsTabActive = toSections;
      _currentPage = 1; // Reset pagination to page 1 on tab switch
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 4)),
                  child: const Center(child: Text("!", style: TextStyle(fontSize: 50, color: Color(0xFFF8BB86), fontWeight: FontWeight.w300))),
                ),
                const SizedBox(height: 25),
                const Text("Are you sure?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 15),
                Text(warningText, style: const TextStyle(fontSize: 14, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 30),
                Wrap(
                  alignment: WrapAlignment.center, spacing: 10, runSpacing: 10,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC3545), padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), elevation: 0,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D6EFD), padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), elevation: 0,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 14)),
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

  // --- BUILD UI ---
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;
    bool isTablet = screenWidth < 850;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: MasterPrimarySidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black),
              title: const Text("Section Master", style: TextStyle(color: Colors.black, fontSize: 16)),
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const SizedBox(width: 250, child: MasterPrimarySidebar()),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) const MasterTopbar(),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isTablet) const SizedBox(width: 260, child: SecondaryMastersSidebar()),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isTablet) const MobileSecondaryMenu(),
                                if (isTablet) const SizedBox(height: 20),
                                const Text("Section Master", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                                const SizedBox(height: 20),
                                
                                // TABS
                                _buildTabs(),
                                const SizedBox(height: 20),
                                
                                // DYNAMIC CONTENT BASED ON TAB
                                if (isSectionsTabActive) ...[
                                  _buildSectionsForm(),
                                  const SizedBox(height: 20),
                                  _buildSectionsTable(),
                                ] else ...[
                                  _buildSubSectionsForm(),
                                  const SizedBox(height: 20),
                                  _buildSubSectionsTable(),
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

  // ==========================================
  // PERFECTED TABS UI
  // ==========================================
  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1.0)),
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          border: Border(
            top: BorderSide(color: isActive ? Colors.grey.shade300 : Colors.transparent),
            left: BorderSide(color: isActive ? Colors.grey.shade300 : Colors.transparent),
            right: BorderSide(color: isActive ? Colors.grey.shade300 : Colors.transparent),
            bottom: BorderSide(color: isActive ? Colors.white : Colors.transparent, width: 2.0),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? const Color(0xFF0D47A1) : Colors.grey.shade600,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // ==========================================
  // VIEW 1: SECTIONS 
  // ==========================================
  Widget _buildSectionsForm() {
    bool isEditing = editSectionId != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end, spacing: 20, runSpacing: 15,
        children: [
          _buildTextField(isEditing ? "Edit Section" : "Section Name", "e.g. Cold Storage, Factory A", _sectionNameCtrl, 280),
          _buildDropdown("Visibility", visibilityOptions, _selectedVisibility, (val) => setState(() => _selectedVisibility = val!), 200),
          
          if (!isEditing)
            SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () {}, icon: const Icon(Icons.add_circle_outline, size: 18, color: Colors.white),
                label: const Text("Add Section", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), elevation: 0),
              ),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {}, icon: const Icon(Icons.check_circle_outline, size: 18, color: Colors.black87),
                    label: const Text("Update Section", style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC107), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), elevation: 0),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: _cancelEditing,
                    style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade400), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                    child: const Text("Cancel", style: TextStyle(color: Colors.black87, fontSize: 13)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSectionsTable() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 850, 
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                    child: const Row(
                      children: [
                        SizedBox(width: 50, child: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), // S.No Added
                        Expanded(child: Text("Section Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                        SizedBox(width: 150, child: Text("Visibility", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                        SizedBox(width: 120, child: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: paginatedSections.length,
                    itemBuilder: (context, index) {
                      final data = paginatedSections[index];
                      int sNo = index + 1 + (_currentPage - 1) * _itemsPerPage; // Calculated S.No
                      bool isRowEditing = data["id"] == editSectionId;
                      bool isBoth = data["visibility"] == "Both";

                      return Container(
                        color: isRowEditing ? const Color(0xFFFFF3CD) : Colors.transparent,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(width: 50, child: Text("$sNo", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87))), // S.No Added
                                  Expanded(child: Text(data["name"]!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87))),
                                  SizedBox(
                                    width: 150,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(color: isBoth ? const Color(0xFF20C997) : const Color(0xFF0DCAF0), borderRadius: BorderRadius.circular(12)),
                                        child: Text(data["visibility"]!, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Row(
                                      children: [
                                        _actionBtn(Icons.edit_outlined, Colors.blue, () => _startEditingSection(data)),
                                        const SizedBox(width: 8),
                                        _actionBtn(Icons.delete_outline, Colors.red, () => _showDeleteDialog(context, "Raw materials and Sub-Sections linked to this will be deleted/lose link.")),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index < paginatedSections.length - 1) Divider(height: 1, color: Colors.grey.shade200),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          _buildPagination(isSection: true),
        ],
      ),
    );
  }

  // ==========================================
  // VIEW 2: SUB SECTIONS
  // ==========================================
  Widget _buildSubSectionsForm() {
    bool isEditing = editSubSectionId != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.grey.shade300)),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end, spacing: 20, runSpacing: 15,
        children: [
          _buildDropdown("Parent Section", parentOptions, _selectedParentSection, (val) => setState(() => _selectedParentSection = val!), 220),
          _buildTextField(isEditing ? "Edit Sub Section" : "Sub Section Name", "e.g. Freezer 1, Assembly Line A", _subSectionNameCtrl, 280),
          
          if (!isEditing)
            SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () {}, icon: const Icon(Icons.add_circle_outline, size: 18, color: Colors.white),
                label: const Text("Add Sub Section", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF198754), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), elevation: 0),
              ),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {}, icon: const Icon(Icons.check_circle_outline, size: 18, color: Colors.black87),
                    label: const Text("Update Sub Section", style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC107), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), elevation: 0), 
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: _cancelEditing,
                    style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade400), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                    child: const Text("Cancel", style: TextStyle(color: Colors.black87, fontSize: 13)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSubSectionsTable() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 850, 
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                    child: const Row(
                      children: [
                        SizedBox(width: 50, child: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), // S.No Added
                        SizedBox(width: 200, child: Text("Parent Section", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                        Expanded(child: Text("Sub Section Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                        SizedBox(width: 120, child: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: paginatedSubSections.length,
                    itemBuilder: (context, index) {
                      final data = paginatedSubSections[index];
                      int sNo = index + 1 + (_currentPage - 1) * _itemsPerPage; // Calculated S.No
                      bool isRowEditing = data["id"] == editSubSectionId;

                      return Container(
                        color: isRowEditing ? const Color(0xFFFFF3CD) : Colors.transparent,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              child: Row(
                                children: [
                                  SizedBox(width: 50, child: Text("$sNo", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87))), // S.No Added
                                  SizedBox(
                                    width: 200, 
                                    child: data["parent"]!.isNotEmpty 
                                      ? Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(color: Colors.grey.shade500, borderRadius: BorderRadius.circular(4)),
                                            child: Text(data["parent"]!, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                          ),
                                        ) 
                                      : const SizedBox.shrink()
                                  ),
                                  Expanded(child: Text(data["name"]!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87))),
                                  SizedBox(
                                    width: 120,
                                    child: Row(
                                      children: [
                                        _actionBtn(Icons.edit_outlined, Colors.blue, () => _startEditingSubSection(data)),
                                        const SizedBox(width: 8),
                                        _actionBtn(Icons.delete_outline, Colors.red, () => _showDeleteDialog(context, "This sub-section will be permanently deleted.")),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index < paginatedSubSections.length - 1) Divider(height: 1, color: Colors.grey.shade200),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          _buildPagination(isSection: false),
        ],
      ),
    );
  }

  // --- PAGINATION WIDGET ---
  Widget _buildPagination({required bool isSection}) {
    int totalItems = isSection ? sectionsData.length : subSectionsData.length;
    int totalPages = (totalItems / _itemsPerPage).ceil();
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

    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Showing ${isSection ? paginatedSections.length : paginatedSubSections.length} of $totalItems entries", 
            style: const TextStyle(fontSize: 13, color: Colors.grey)
          ),
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

  // --- HELPER WIDGETS ---
  Widget _buildTextField(String label, String hint, TextEditingController controller, double width) {
    return Container(
      constraints: BoxConstraints(maxWidth: width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint, hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
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
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: DropdownButtonFormField<String>(
              value: currentValue,
              icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
              ),
              items: items.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontSize: 13)))).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: 32, height: 32,
      decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)),
      child: IconButton(padding: EdgeInsets.zero, icon: Icon(icon, size: 16, color: color), onPressed: onTap),
    );
  }
}

// ==========================================
// SECONDARY SIDEBAR (SECTION MASTER ACTIVE)
// ==========================================
class SecondaryMastersSidebar extends StatelessWidget {
  const SecondaryMastersSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("All Masters", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: Text("RAW MATERIAL", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blue)),
          ),
          _secMenuItem(context, Icons.inventory_2_outlined, "RM Master"),
          _secMenuItem(context, Icons.sell_outlined, "Material Type Master", destination: const MaterialTypeMasterPage()),
          _secMenuItem(context, Icons.group_outlined, "Vendor Master", destination: const VendorMasterPage()), 
          
          _secMenuItem(context, Icons.domain_outlined, "Section Master", isActive: true),
          _secMenuItem(context, Icons.straighten, "UOM", destination: const MastersPage()), 
          
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: Text("PACKAGING MATERIAL", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blue)),
          ),
          _secMenuItem(context, Icons.inventory_2_outlined, "PM Master"),
          _secMenuItem(context, Icons.group_outlined, "PM Vendor Master"),
          _secMenuItem(context, Icons.straighten, "PM UOM"),
        ],
      ),
    );
  }

  Widget _secMenuItem(BuildContext context, IconData icon, String label, {bool isActive = false, Widget? destination}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(color: isActive ? const Color(0xFF0D47A1) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -2),
        leading: Icon(icon, size: 20, color: isActive ? Colors.white : Colors.blueGrey),
        title: Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.blueGrey.shade700, fontSize: 13, fontWeight: isActive ? FontWeight.bold : FontWeight.w600)),
        onTap: () {
          if (destination != null) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination));
        },
      ),
    );
  }
}

// ==========================================
// PRIMARY SIDEBAR
// ==========================================
class MasterPrimarySidebar extends StatelessWidget {
  const MasterPrimarySidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE1F5FE),
      child: Column(
        children: [
          const SizedBox(height: 35),
          Container(
            height: 90, width: 90,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: ClipOval(child: Padding(padding: const EdgeInsets.all(4.0), child: Image.asset('assets/images/rts_logo.png', fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image)))),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _navItem(context, Icons.speed, "Overall Dashboard", const DashboardScreen()),
                const SizedBox(height: 15),
                _headerItem(Icons.shopping_cart_outlined, "Purchase Section"),
                const SizedBox(height: 10),
                
                _subItem(Icons.inventory_2_outlined, "Raw Material", badge: "192"),
                _subItem(Icons.assignment_turned_in_outlined, "RM Request Management"),
                _subItem(Icons.event_available_outlined, "Daily Usage Management"),
                _subItem(Icons.inventory_2_outlined, "Packaging Material"),
                
                Container(
                  color: const Color(0xFF0D47A1),
                  child: ListTile(
                    visualDensity: const VisualDensity(vertical: -4),
                    leading: const Icon(Icons.storage_outlined, size: 22, color: Colors.white),
                    title: const Text("Masters", style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                
                _subItem(Icons.account_balance_wallet_outlined, "Stock Cost"),
                _subItem(Icons.assignment_outlined, "Inventory Audit Entry"),
                _subItem(Icons.delete_outline, "Wastage Management"),
                _subItem(Icons.history, "Reversal History"),
                _subItem(Icons.shopping_cart_checkout, "Bakery Products"),
                _subItem(Icons.update, "Purchase Transfer History"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, IconData icon, String label, Widget destination) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -2),
        leading: Icon(icon, color: const Color(0xFF1A237E), size: 22),
        title: Text(label, style: const TextStyle(color: Color(0xFF1A237E), fontSize: 13, fontWeight: FontWeight.bold)),
        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination)),
      ),
    );
  }

  Widget _headerItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -2),
        leading: Icon(icon, color: const Color(0xFF1A237E), size: 22),
        title: Text(label, style: const TextStyle(color: Color(0xFF1A237E), fontSize: 13, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _subItem(IconData icon, String text, {String? badge}) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 25, right: 15),
      visualDensity: const VisualDensity(vertical: -4),
      leading: Icon(icon, size: 20, color: const Color(0xFF1A237E)),
      title: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF1A237E), fontWeight: FontWeight.w600)),
      trailing: badge != null ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10)),
        child: Text(badge, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ) : null,
    );
  }
}

// ==========================================
// TOPBAR
// ==========================================
class MasterTopbar extends StatelessWidget {
  const MasterTopbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey),
          const SizedBox(width: 15),
          RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.grey, fontSize: 13),
              children: [
                TextSpan(text: "Home / Purchase Section / Masters / "),
                TextSpan(text: "Sections", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: 300, height: 40, decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
            child: const TextField(decoration: InputDecoration(hintText: "Search menus...", prefixIcon: Icon(Icons.search, size: 20), border: InputBorder.none)),
          ),
          const SizedBox(width: 25),
          const CircleAvatar(radius: 18, backgroundColor: Colors.blue, child: Text("R", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}

// ==========================================
// MOBILE SECONDARY MENU
// ==========================================
class MobileSecondaryMenu extends StatelessWidget {
  const MobileSecondaryMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _mobChip(context, "RM Master"), 
          _mobChip(context, "Material Type Master", destination: const MaterialTypeMasterPage()), 
          _mobChip(context, "Vendor Master", destination: const VendorMasterPage()), 
          _mobChip(context, "Section Master", isActive: true), 
          _mobChip(context, "UOM", destination: const MastersPage()), 
          _mobChip(context, "PM Master"), 
          _mobChip(context, "PM Vendor Master"), 
          _mobChip(context, "PM UOM"),
        ],
      ),
    );
  }

  Widget _mobChip(BuildContext context, String label, {bool isActive = false, Widget? destination}) {
    return GestureDetector(
      onTap: () {
        if (destination != null) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destination));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(color: isActive ? const Color(0xFF0D47A1) : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: isActive ? const Color(0xFF0D47A1) : Colors.grey.shade300)),
        child: Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.blueGrey, fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }
}