import 'package:flutter/material.dart';
import 'subsidebar.dart'; // Import unified layout
import 'package:gowmari_mobile/screens/components/app_sidebar.dart'; 

class RawMaterial {
  final String name;
  final String tamilName;
  final String type;
  final String category;
  final double price;
  final int stock;
  final int alertQty;
  final String unit;
  final String secondaryUnit;
  final String purchaseType;
  final List<String> tags;

  RawMaterial({
    required this.name, this.tamilName = "", required this.type, required this.category, required this.price,
    required this.stock, this.alertQty = 0, required this.unit, this.secondaryUnit = "None",
    this.purchaseType = "Regular", required this.tags,
  });
}

class RMMasterPage extends StatefulWidget {
  const RMMasterPage({super.key});

  @override
  State<RMMasterPage> createState() => _RMMasterPageState();
}

class _RMMasterPageState extends State<RMMasterPage> {
  final List<RawMaterial> materials = [
    RawMaterial(name: "1 kg P.P Cover", tamilName: "", type: "PACKING MATERIAL", category: "Both", price: 377.60, stock: 499, unit: "kg", tags: ["KITCHEN", "PACKING", "DONATION"]),
    RawMaterial(name: "1 kg Birthday Cake Box", tamilName: "", type: "PACKING MATERIAL", category: "Both", price: 18.48, stock: 465, unit: "pcs", tags: ["PACKING", "DONATION"]),
    RawMaterial(name: "1 kg Cake Bag", tamilName: "", type: "PACKING MATERIAL", category: "Both", price: 8.62, stock: 344, unit: "pcs", tags: ["PACKING", "DONATION"]),
    RawMaterial(name: "1 kg Square Cake Bottom", tamilName: "", type: "PACKING MATERIAL", category: "Factory", price: 8.79, stock: 274, unit: "pcs", tags: ["BAKERY", "DONATION"]),
    RawMaterial(name: "1 kg Sweet Box", tamilName: "", type: "PACKING MATERIAL", category: "Both", price: 16.80, stock: 360, unit: "pcs", tags: ["PACKING", "DONATION"]),
    RawMaterial(name: "1 kg Sweet Container", tamilName: "", type: "PACKING MATERIAL", category: "Both", price: 17.50, stock: 465, unit: "pcs", tags: ["PACKING", "DONATION"]),
  ];

  int _currentPage = 1;
  int _itemsPerPage = 100;

  List<RawMaterial> get paginatedMaterials {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (startIndex >= materials.length) return [];
    if (endIndex > materials.length) endIndex = materials.length;
    return materials.sublist(startIndex, endIndex);
  }

  void _showImportDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white, surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              const Text("SELECT EXCEL FILE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
              const SizedBox(height: 8),
              Container(
                height: 44, decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10), color: Colors.grey.shade50),
                child: Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(color: Colors.grey.shade200, border: Border(right: BorderSide(color: Colors.grey.shade300)), borderRadius: const BorderRadius.horizontal(left: Radius.circular(10))), alignment: Alignment.center, child: const Text("Choose File", style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600))), const SizedBox(width: 12), Text("No file chosen", style: TextStyle(fontSize: 13, color: Colors.grey.shade500))]),
              ),
              const SizedBox(height: 32),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 2, shadowColor: const Color(0xFF2962FF).withOpacity(0.4)), child: const Text("Upload Data", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)))),
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
        backgroundColor: Colors.white, surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        child: Container(
          width: 400, padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle), child: const Center(child: Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 40))),
              const SizedBox(height: 24),
              const Text("Are you sure?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),
              const Text("This will also delete associated stock records! This action cannot be undone.", textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey, fontSize: 14, height: 1.5)),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600)))),
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

  void _showMaterialDialog({RawMaterial? material}) {
    bool isEdit = material != null;
    showDialog(
      context: context,
      builder: (context) {
        double screenWidth = MediaQuery.of(context).size.width;
        bool isDialogMobile = screenWidth < 750;

        return Dialog(
          backgroundColor: Colors.white, surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 10,
          child: SizedBox(
            width: isDialogMobile ? screenWidth * 0.95 : 780,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 20, 16),
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
                Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        _responsiveRow(isDialogMobile, [_buildInput("MATERIAL NAME", material?.name ?? ""), _buildInput("TAMIL NAME", material?.tamilName ?? "தமிழ் பெயர்")]), const SizedBox(height: 20),
                        _responsiveRow(isDialogMobile, [_buildInput("OPENING STOCK", material?.stock.toString() ?? "0"), _buildInput("ALERT QTY", material?.alertQty.toString() ?? "0"), _buildInput("PRICE / UNIT (₹)", material?.price.toString() ?? "0")]), const SizedBox(height: 20),
                        _responsiveRow(isDialogMobile, [_buildDropdown("CATEGORY", material?.category ?? "Factory", ["Factory", "Bakery", "Both"]), _buildCheckList("MATERIAL TYPE", ["BAKERY", "CHAT MATERIAL", "CLEANING MATERIAL", "PACKING MATERIAL"], material?.type)]), const SizedBox(height: 20),
                        _buildDropdown("PURCHASE TYPE", material?.purchaseType ?? "Regular", ["Regular", "Urgent"]), const SizedBox(height: 20),
                        _responsiveRow(isDialogMobile, [
                          _buildCheckList("ASSIGN SECTIONS", ["BAKERY", "SWEET", "MURUKKU", "KOLUKATTAI"], null),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text("ASSIGN SUB-SECTIONS", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)), const SizedBox(height: 8),
                            Container(height: 130, width: double.infinity, decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(10)), child: Center(child: Text(isEdit ? "No sub-sections available for selected sections" : "Select a section first", style: TextStyle(color: Colors.grey.shade500, fontSize: 13))))
                          ]),
                        ]), const SizedBox(height: 20),
                        _responsiveRow(isDialogMobile, [_buildDropdown("PRIMARY UNIT", material?.unit ?? "Select", ["Select", "kg", "pcs", "ltr", "pkt"]), _buildDropdown("SECONDARY UNIT (OPT)", material?.secondaryUnit ?? "None", ["None", "gram", "ml"])]),
                      ],
                    ),
                  ),
                ),
                Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () => Navigator.pop(context), style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text("Close", style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600))), const SizedBox(width: 12),
                      ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 2, shadowColor: const Color(0xFF2962FF).withOpacity(0.4)), child: const Text("Save Record", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14))),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _responsiveRow(bool isMobile, List<Widget> children) {
    if (isMobile) return Column(children: children.map((w) => Padding(padding: const EdgeInsets.only(bottom: 16), child: w)).toList());
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: children.map((w) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: w))).toList());
  }

  Widget _buildInput(String label, String hint) {
    bool isTamilHint = hint == "தமிழ் பெயர்";
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)), const SizedBox(height: 8),
      TextFormField(
        initialValue: isTamilHint ? "" : hint, 
        decoration: InputDecoration(
          hintText: isTamilHint ? hint : null, 
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
          filled: true, fillColor: Colors.grey.shade50, 
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), 
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none), 
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2962FF), width: 1.5))
        )
      ),
    ]);
  }

  Widget _buildDropdown(String label, String val, List<String> items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)), const SizedBox(height: 8),
      DropdownButtonFormField<String>(
        value: val, 
        icon: Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey.shade600),
        decoration: InputDecoration(
          filled: true, fillColor: Colors.grey.shade50, 
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), 
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none), 
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF2962FF), width: 1.5))
        ), 
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(), onChanged: (v) {}
      ),
    ]);
  }

  Widget _buildCheckList(String label, List<String> opts, String? active) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)), const SizedBox(height: 8),
      Container(
        height: 130, 
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade50), 
        child: ListView(
          padding: EdgeInsets.zero, 
          children: opts.map((e) => CheckboxListTile(
            title: Text(e, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)), 
            value: active == e, 
            onChanged: (v) {}, 
            controlAffinity: ListTileControlAffinity.leading, dense: true, visualDensity: const VisualDensity(vertical: -4),
            activeColor: const Color(0xFF2962FF),
            checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
          )).toList()
        )
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 950;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: AppSidebar(activeMenu: "Masters")) : null,
      appBar: isMobile ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Raw Materials", style: TextStyle(color: Colors.black, fontSize: 16))) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const AppSidebar(activeMenu: "Masters"),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) const MasterTopbar(breadcrumb: "Home / Purchase Section / Masters / Raw Materials"),
                Expanded(
                  child: Row(
                    children: [
                      if (!isMobile) const SizedBox(width: 260, child: SecondaryMastersSidebar(activePage: 'RM Master')),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(30), // Increased padding
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isMobile) const MobileSecondaryMenu(activePage: 'RM Master'),
                              const Text("Raw Material List", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1A237E))), // Modern Header
                              const SizedBox(height: 24),
                              _buildTopControls(isMobile),
                              const SizedBox(height: 24),
                              isMobile ? _buildMobileList() : _buildTableContainer(),
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

  Widget _buildTopControls(bool isMobile) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 44, 
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))]), 
                child: TextField(decoration: InputDecoration(hintText: "Search by name...", hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400), prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey.shade500), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 12)))
              )
            ),
            if (!isMobile) ...[
              const SizedBox(width: 16),
              _headerBtn("Import Excel", Icons.file_upload_outlined, Colors.green, _showImportDialog),
              const SizedBox(width: 12),
              _headerBtn("Export Excel", Icons.file_download_outlined, Colors.blueGrey, () {}),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _showMaterialDialog(), 
                icon: const Icon(Icons.add, size: 18, color: Colors.white), 
                label: const Text("Create New Material", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)), 
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), shadowColor: const Color(0xFF2962FF).withOpacity(0.4), elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12))
              ),
            ]
          ],
        ),
        if (isMobile) Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () => _showMaterialDialog(), icon: const Icon(Icons.add, size: 18, color: Colors.white), label: const Text("Create New", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2962FF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.symmetric(vertical: 12)))),
        ),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            const Text("Show: ", style: TextStyle(fontSize: 13, color: Colors.blueGrey, fontWeight: FontWeight.w500)),
            Container(
              height: 32, padding: const EdgeInsets.symmetric(horizontal: 10), 
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), 
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _itemsPerPage, icon: Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey.shade600), style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500),
                  onChanged: (int? newValue) { setState(() { _itemsPerPage = newValue!; _currentPage = 1; }); },
                  items: <int>[5, 10, 50, 100].map<DropdownMenuItem<int>>((int value) { return DropdownMenuItem<int>(value: value, child: Text(value.toString())); }).toList(),
                ),
              ),
            ),
          ]),
          Text("Showing ${paginatedMaterials.length} of ${materials.length}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade600)),
        ])
      ],
    );
  }

  Widget _buildTableContainer() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 5))]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 56, dataRowMaxHeight: 76,
                headingRowColor: MaterialStateColor.resolveWith((states) => const Color(0xFFF8FAFC)), // Modern Header Color
                dividerThickness: 1, // Divider thickness
                columns: const [
                  DataColumn(label: Text('S.NO', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))), 
                  DataColumn(label: Text('NAME & TAMIL NAME', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))),
                  DataColumn(label: Text('TYPE', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))),
                  DataColumn(label: Text('CATEGORY', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))),
                  DataColumn(label: Text('PRICE (₹)', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))),
                  DataColumn(label: Text('STOCK', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))),
                  DataColumn(label: Text('UNITS', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))),
                  DataColumn(label: Text('ACTIONS', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.blueGrey))),
                ],
                rows: paginatedMaterials.asMap().entries.map((entry) {
                  int index = entry.key + (_currentPage - 1) * _itemsPerPage;
                  RawMaterial m = entry.value;
                  return DataRow(cells: [
                    DataCell(Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))), 
                    DataCell(Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(m.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)), const SizedBox(height: 6),
                      Wrap(spacing: 6, children: m.tags.map((t) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(6)), child: Text(t, style: TextStyle(fontSize: 10, color: Colors.grey.shade700, fontWeight: FontWeight.w500)))).toList()),
                    ])),
                    DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(20)), child: Text(m.type, style: const TextStyle(color: Color(0xFF1976D2), fontSize: 10, fontWeight: FontWeight.bold)))),
                    DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(20)), child: Text(m.category, style: const TextStyle(color: Color(0xFF0097A7), fontSize: 10, fontWeight: FontWeight.bold)))),
                    DataCell(Text("₹${m.price}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                    DataCell(Text("${m.stock}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                    DataCell(Text(m.unit, style: const TextStyle(fontSize: 14))),
                    DataCell(Row(children: [_actionIcon(Icons.edit_rounded, Colors.blueAccent, () => _showMaterialDialog(material: m)), const SizedBox(width: 12), _actionIcon(Icons.delete_outline_rounded, Colors.redAccent, _showDeleteDialog)])),
                  ]);
                }).toList(),
              ),
            ),
            Container(decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))), child: _buildPagination()),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileList() {
    return Column(
      children: paginatedMaterials.asMap().entries.map((entry) {
        int index = entry.key + (_currentPage - 1) * _itemsPerPage;
        RawMaterial m = entry.value;
        return Card(
          color: Colors.white, elevation: 2, shadowColor: Colors.black.withOpacity(0.05), margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Expanded(child: Text("${index + 1}. ${m.name}", style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15))),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)), child: Text(m.type, style: const TextStyle(color: Color(0xFF1976D2), fontSize: 9, fontWeight: FontWeight.bold))),
                ]),
                const SizedBox(height: 12),
                Wrap(spacing: 6, runSpacing: 6, children: m.tags.map((t) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(6)), child: Text(t, style: TextStyle(fontSize: 10, color: Colors.grey.shade700, fontWeight: FontWeight.w500)))).toList()),
                const Divider(height: 30, color: Color(0xFFEEEEEE)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text("Price: ₹${m.price}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Row(children: [_actionIcon(Icons.edit_rounded, Colors.blueAccent, () => _showMaterialDialog(material: m)), const SizedBox(width: 12), _actionIcon(Icons.delete_outline_rounded, Colors.redAccent, _showDeleteDialog)])
                ])
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _headerBtn(String l, IconData i, Color c, VoidCallback t) => OutlinedButton.icon(onPressed: t, icon: Icon(i, size: 18, color: c), label: Text(l, style: TextStyle(color: c, fontSize: 13, fontWeight: FontWeight.w600)), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
  
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
    int totalPages = (materials.length / _itemsPerPage).ceil();
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

    return Padding(padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), child: Row(mainAxisAlignment: MainAxisAlignment.end, children: pageButtons));
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