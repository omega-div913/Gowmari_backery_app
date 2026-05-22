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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 420, padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Bulk Import (.xlsx)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 16),
              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), child: const Text("Download Template", style: TextStyle(color: Colors.black87, fontSize: 13)))),
              const SizedBox(height: 16),
              const Text("SELECT EXCEL FILE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF6C757D))),
              const SizedBox(height: 6),
              Container(
                height: 40, decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
                child: Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: const Color(0xFFF8F9FA), border: Border(right: BorderSide(color: Colors.grey.shade300))), alignment: Alignment.center, child: const Text("Choose File", style: TextStyle(fontSize: 12, color: Colors.black87))), const SizedBox(width: 10), const Text("No file chosen", style: TextStyle(fontSize: 12, color: Colors.grey))]),
              ),
              const SizedBox(height: 20),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), elevation: 0), child: const Text("Upload Data", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)))),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 400, padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 75, width: 75, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 3)), child: const Center(child: Text("!", style: TextStyle(fontSize: 45, color: Color(0xFFF8BB86), fontWeight: FontWeight.w300)))),
              const SizedBox(height: 20),
              const Text("Are you sure?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 8),
              const Text("This will also delete associated stock records!", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF6C757D), fontSize: 13)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC3545), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white, fontSize: 13))),
                  const SizedBox(width: 10),
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), child: const Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 13))),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: SizedBox(
            width: isDialogMobile ? screenWidth * 0.95 : 780,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(isEdit ? "Edit Material" : "Create Material", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.grey, size: 20)),
                    ],
                  ),
                ),
                const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
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
                            const Text("ASSIGN SUB-SECTIONS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF6C757D))), const SizedBox(height: 8),
                            Container(height: 130, width: double.infinity, decoration: BoxDecoration(border: Border.all(color: const Color(0xFFDEE2E6)), borderRadius: BorderRadius.circular(4)), child: Center(child: Text(isEdit ? "No sub-sections available for selected sections" : "Select a section first", style: const TextStyle(color: Colors.grey, fontSize: 12))))
                          ]),
                        ]), const SizedBox(height: 20),
                        _responsiveRow(isDialogMobile, [_buildDropdown("PRIMARY UNIT", material?.unit ?? "Select", ["Select", "kg", "pcs", "ltr", "pkt"]), _buildDropdown("SECONDARY UNIT (OPT)", material?.secondaryUnit ?? "None", ["None", "gram", "ml"])]),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () => Navigator.pop(context), style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), shape: RoundedRectangleBorder(side: const BorderSide(color: Color(0xFFDEE2E6)), borderRadius: BorderRadius.circular(4))), child: const Text("Close", style: TextStyle(color: Colors.black87, fontSize: 13))), const SizedBox(width: 12),
                      ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), elevation: 0), child: const Text("Save Record", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))),
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
    if (isMobile) return Column(children: children.map((w) => Padding(padding: const EdgeInsets.only(bottom: 15), child: w)).toList());
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: children.map((w) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: w))).toList());
  }

  Widget _buildInput(String label, String hint) {
    bool isTamilHint = hint == "தமிழ் பெயர்";
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF6C757D))), const SizedBox(height: 8),
      SizedBox(height: 42, child: TextFormField(initialValue: isTamilHint ? "" : hint, decoration: InputDecoration(hintText: isTamilHint ? hint : null, filled: true, fillColor: const Color(0xFFF8F9FA), contentPadding: const EdgeInsets.symmetric(horizontal: 12), border: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFDEE2E6)), borderRadius: BorderRadius.circular(4)), enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFDEE2E6)), borderRadius: BorderRadius.circular(4))))),
    ]);
  }

  Widget _buildDropdown(String label, String val, List<String> items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF6C757D))), const SizedBox(height: 8),
      SizedBox(height: 42, child: DropdownButtonFormField<String>(value: val, decoration: InputDecoration(filled: true, fillColor: const Color(0xFFF8F9FA), contentPadding: const EdgeInsets.symmetric(horizontal: 12), border: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFDEE2E6)), borderRadius: BorderRadius.circular(4))), items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(), onChanged: (v) {})),
    ]);
  }

  Widget _buildCheckList(String label, List<String> opts, String? active) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF6C757D))), const SizedBox(height: 8),
      Container(height: 130, decoration: BoxDecoration(border: Border.all(color: const Color(0xFFDEE2E6)), borderRadius: BorderRadius.circular(4), color: const Color(0xFFF8F9FA)), child: ListView(padding: EdgeInsets.zero, children: opts.map((e) => CheckboxListTile(title: Text(e, style: const TextStyle(fontSize: 12)), value: active == e, onChanged: (v) {}, controlAffinity: ListTileControlAffinity.leading, dense: true, visualDensity: const VisualDensity(vertical: -4))).toList())),
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
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isMobile) const MobileSecondaryMenu(activePage: 'RM Master'),
                              const Text("Raw Material List", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                              const SizedBox(height: 20),
                              _buildTopControls(isMobile),
                              const SizedBox(height: 20),
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
            Expanded(child: Container(height: 40, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)), child: const TextField(decoration: InputDecoration(hintText: "Search by name...", prefixIcon: Icon(Icons.search, size: 18), border: InputBorder.none, contentPadding: EdgeInsets.only(top: 8))))),
            if (!isMobile) ...[
              const SizedBox(width: 10),
              _headerBtn("Import Excel", Icons.file_upload_outlined, Colors.green, _showImportDialog),
              const SizedBox(width: 10),
              _headerBtn("Export Excel", Icons.file_download_outlined, Colors.black54, () {}),
              const SizedBox(width: 10),
              ElevatedButton.icon(onPressed: () => _showMaterialDialog(), icon: const Icon(Icons.add, size: 16, color: Colors.white), label: const Text("Create New Material", style: TextStyle(color: Colors.white)), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)))),
            ]
          ],
        ),
        if (isMobile) Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () => _showMaterialDialog(), icon: const Icon(Icons.add, size: 16, color: Colors.white), label: const Text("Create New", style: TextStyle(color: Colors.white)), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1)))),
        ),
        const SizedBox(height: 15),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            const Text("Show: ", style: TextStyle(fontSize: 12, color: Colors.grey)),
            Container(
              height: 28, padding: const EdgeInsets.symmetric(horizontal: 8), 
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), 
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _itemsPerPage, icon: const Icon(Icons.arrow_drop_down, size: 16), style: const TextStyle(fontSize: 12, color: Colors.black87),
                  onChanged: (int? newValue) { setState(() { _itemsPerPage = newValue!; _currentPage = 1; }); },
                  items: <int>[5, 10, 50, 100].map<DropdownMenuItem<int>>((int value) { return DropdownMenuItem<int>(value: value, child: Text(value.toString())); }).toList(),
                ),
              ),
            ),
          ]),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), 
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), 
            child: Text("Showing ${paginatedMaterials.length} of ${materials.length}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
          ),
        ])
      ],
    );
  }

  Widget _buildTableContainer() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFDEE2E6)), borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 50, dataRowMaxHeight: 70,
              columns: const [
                DataColumn(label: Text('S.No', style: TextStyle(fontWeight: FontWeight.bold))), 
                DataColumn(label: Text('Name & Tamil Name', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Type', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Category', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Price (₹)', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Stock', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Units', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: paginatedMaterials.asMap().entries.map((entry) {
                int index = entry.key + (_currentPage - 1) * _itemsPerPage;
                RawMaterial m = entry.value;
                return DataRow(cells: [
                  DataCell(Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold))), 
                  DataCell(Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), const SizedBox(height: 4),
                    Wrap(spacing: 5, children: m.tags.map((t) => Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Text(t, style: const TextStyle(fontSize: 9, color: Colors.grey)))).toList()),
                  ])),
                  DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)), child: Text(m.type, style: const TextStyle(color: Color(0xFF1E88E5), fontSize: 9, fontWeight: FontWeight.bold)))),
                  DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFE0F7FA), borderRadius: BorderRadius.circular(12)), child: Text(m.category, style: const TextStyle(color: Color(0xFF00ACC1), fontSize: 9, fontWeight: FontWeight.bold)))),
                  DataCell(Text("₹${m.price}", style: const TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text("${m.stock}", style: const TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text(m.unit)),
                  DataCell(Row(children: [_actionIcon(Icons.edit_outlined, Colors.blue, () => _showMaterialDialog(material: m)), const SizedBox(width: 8), _actionIcon(Icons.delete_outline, Colors.red, _showDeleteDialog)])),
                ]);
              }).toList(),
            ),
          ),
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildMobileList() {
    return Column(
      children: paginatedMaterials.asMap().entries.map((entry) {
        int index = entry.key + (_currentPage - 1) * _itemsPerPage;
        RawMaterial m = entry.value;
        return Card(
          color: Colors.white, elevation: 0, margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey.shade200)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Expanded(child: Text("${index + 1}. ${m.name}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)), child: Text(m.type, style: const TextStyle(color: Colors.blue, fontSize: 8, fontWeight: FontWeight.bold))),
                ]),
                const SizedBox(height: 10),
                Wrap(spacing: 5, children: m.tags.map((t) => Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Text(t, style: const TextStyle(fontSize: 9, color: Colors.grey)))).toList()),
                const Divider(height: 25),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text("Price: ₹${m.price}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Row(children: [_actionIcon(Icons.edit_outlined, Colors.blue, () => _showMaterialDialog(material: m)), const SizedBox(width: 10), _actionIcon(Icons.delete_outline, Colors.red, _showDeleteDialog)])
                ])
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _headerBtn(String l, IconData i, Color c, VoidCallback t) => OutlinedButton.icon(onPressed: t, icon: Icon(i, size: 16, color: c), label: Text(l, style: TextStyle(color: c, fontSize: 12)), style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))));
  Widget _actionIcon(IconData i, Color c, VoidCallback t) => Container(width: 30, height: 30, decoration: BoxDecoration(border: Border.all(color: c.withOpacity(0.3)), borderRadius: BorderRadius.circular(4)), child: IconButton(padding: EdgeInsets.zero, icon: Icon(i, size: 16, color: c), onPressed: t));
  
  Widget _buildPagination() {
    int totalPages = (materials.length / _itemsPerPage).ceil();
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

    return Padding(padding: const EdgeInsets.all(16.0), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: pageButtons));
  }

  Widget _pageBox(String t, bool active, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), 
      decoration: BoxDecoration(color: active ? Colors.blue : Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), 
      child: Text(t, style: TextStyle(color: active ? Colors.white : Colors.blue, fontSize: 11, fontWeight: FontWeight.bold))
    ),
  );
}