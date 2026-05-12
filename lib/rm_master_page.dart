import 'package:flutter/material.dart';
import 'masters_page.dart';

class RawMaterial {
  final String name;
  final String type;
  final String category;
  final double price;
  final int stock;
  final String unit;
  final List<String> tags;

  RawMaterial({
    required this.name,
    required this.type,
    required this.category,
    required this.price,
    required this.stock,
    required this.unit,
    required this.tags,
  });
}

class RMMasterPage extends StatefulWidget {
  const RMMasterPage({super.key});

  @override
  State<RMMasterPage> createState() => _RMMasterPageState();
}

class _RMMasterPageState extends State<RMMasterPage> {
  final List<RawMaterial> materials = [
    RawMaterial(name: "1 kg P.P Cover", type: "PACKING MATERIAL", category: "Both", price: 377.60, stock: 499, unit: "kg", tags: ["KITCHEN", "PACKING", "DONATION"]),
    RawMaterial(name: "1 kg Birthday Cake Box", type: "PACKING MATERIAL", category: "Both", price: 18.48, stock: 465, unit: "pcs", tags: ["PACKING", "DONATION"]),
    RawMaterial(name: "1 kg Cake Bag", type: "PACKING MATERIAL", category: "Both", price: 8.62, stock: 344, unit: "pcs", tags: ["PACKING", "DONATION"]),
    RawMaterial(name: "1 kg Square Cake Bottom", type: "PACKING MATERIAL", category: "Factory", price: 8.79, stock: 274, unit: "pcs", tags: ["BAKERY", "DONATION"]),
    RawMaterial(name: "1 kg Sweet Box", type: "PACKING MATERIAL", category: "Both", price: 16.80, stock: 360, unit: "pcs", tags: ["PACKING", "DONATION"]),
    RawMaterial(name: "1 kg Sweet Container", type: "PACKING MATERIAL", category: "Both", price: 17.50, stock: 465, unit: "pcs", tags: ["PACKING", "DONATION"]),
    RawMaterial(name: "1.5 kg Square Cake Bottom", type: "PACKING MATERIAL", category: "Factory", price: 9.79, stock: 449, unit: "pcs", tags: ["BAKERY"]),
  ];

  // ==========================================
  // CREATE MATERIAL DIALOG (EXACT 2nd IMAGE)
  // ==========================================
  void _showCreateMaterialDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 850, // wide dialog as per image
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Create Material", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, size: 20)),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 20),
                
                // Material Name and Tamil Name
                Row(
                  children: [
                    Expanded(child: _buildInput("MATERIAL NAME", "Enter material name")),
                    const SizedBox(width: 20),
                    Expanded(child: _buildInput("TAMIL NAME", "தமிழ் பெயர்")),
                  ],
                ),
                const SizedBox(height: 20),

                // Opening Stock, Alert Qty, Price
                Row(
                  children: [
                    Expanded(child: _buildInput("OPENING STOCK", "0")),
                    const SizedBox(width: 15),
                    Expanded(child: _buildInput("ALERT QTY", "0")),
                    const SizedBox(width: 15),
                    Expanded(child: _buildInput("PRICE / UNIT (₹)", "0")),
                  ],
                ),
                const SizedBox(height: 20),

                // Category and Material Type
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildDropdown("CATEGORY", "Factory", ["Factory", "Bakery", "Both"])),
                    const SizedBox(width: 20),
                    Expanded(child: _buildScrollableCheckboxes("MATERIAL TYPE", ["BAKERY", "CHAT MATERIAL", "CLEANING MATERIAL"])),
                  ],
                ),
                const SizedBox(height: 20),

                // Purchase Type
                _buildDropdown("PURCHASE TYPE", "Regular", ["Regular", "Urgent"]),
                const SizedBox(height: 20),

                // Sections and Sub-sections
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildScrollableCheckboxes("ASSIGN SECTIONS", ["BAKERY", "SWEET", "MURUKKU"])),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("ASSIGN SUB-SECTIONS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
                          const SizedBox(height: 8),
                          Container(
                            height: 130, width: double.infinity,
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6), color: Colors.white),
                            child: const Center(child: Text("Select a section first", style: TextStyle(color: Colors.grey, fontSize: 13))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Units
                Row(
                  children: [
                    Expanded(child: _buildDropdown("PRIMARY UNIT", "Select", ["Select", "kg", "pcs", "ltr"])),
                    const SizedBox(width: 20),
                    Expanded(child: _buildDropdown("SECONDARY UNIT (OPT)", "None", ["None", "gram", "ml"])),
                  ],
                ),

                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context), 
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18)),
                      child: const Text("Close", style: TextStyle(color: Colors.black87)),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18), elevation: 0),
                      child: const Text("Save Record", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Methods ---

  Widget _buildInput(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint, 
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            border: const OutlineInputBorder(), 
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String val, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          value: val,
          decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 12)),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
          onChanged: (v) {},
        ),
      ],
    );
  }

  Widget _buildScrollableCheckboxes(String label, List<String> opts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
        const SizedBox(height: 8),
        Container(
          height: 130,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
          child: ListView(
            padding: EdgeInsets.zero,
            children: opts.map((e) => CheckboxListTile(
              title: Text(e, style: const TextStyle(fontSize: 13)), 
              value: false, onChanged: (v) {}, 
              controlAffinity: ListTileControlAffinity.leading, 
              dense: true, 
              visualDensity: const VisualDensity(vertical: -4),
            )).toList(),
          ),
        )
      ],
    );
  }

  // --- No changes to the rest of your original code ---

  void _showImportDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 400, padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Bulk Import (.xlsx)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 15),
              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), padding: const EdgeInsets.symmetric(vertical: 12)), child: const Text("Download Template", style: TextStyle(color: Colors.black87)))),
              const SizedBox(height: 15),
              const Text("SELECT EXCEL FILE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
              const SizedBox(height: 5),
              Container(height: 40, decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)), child: Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: Colors.grey.shade100, border: Border(right: BorderSide(color: Colors.grey.shade300))), alignment: Alignment.center, child: const Text("Choose File", style: TextStyle(fontSize: 12))), const SizedBox(width: 10), const Text("No file chosen", style: TextStyle(fontSize: 12, color: Colors.grey))])),
              const SizedBox(height: 20),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), elevation: 0, padding: const EdgeInsets.symmetric(vertical: 12)), child: const Text("Upload Data", style: TextStyle(color: Colors.white)))),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 400, padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 80, width: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 3)), child: const Center(child: Text("!", style: TextStyle(fontSize: 45, color: Color(0xFFF8BB86), fontWeight: FontWeight.bold)))),
              const SizedBox(height: 20),
              const Text("Are you sure?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 8),
              const Text("This will also delete associated stock records!", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC3545), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)), child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white))),
                  const SizedBox(width: 10),
                  ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)), child: const Text("Cancel", style: TextStyle(color: Colors.white))),
                ],
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
    bool isTablet = screenWidth < 850;

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
                if (!isMobile) const MasterTopbar(breadcrumb: "Home / Purchase Section / Masters / Raw Materials"),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isTablet) const SizedBox(width: 260, child: SecondaryMastersSidebar(activePage: 'RM Master')),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Raw Material List", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                              const SizedBox(height: 20),
                              _buildTopControls(isTablet),
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

  Widget _buildTopControls(bool isTablet) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: isTablet ? 200 : 350, height: 40, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)), child: const TextField(decoration: InputDecoration(hintText: "Search by name...", prefixIcon: Icon(Icons.search, size: 18), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 10)))),
            if (!isTablet) Row(
              children: [
                _headerBtn("Import Excel", Icons.file_upload_outlined, Colors.green, _showImportDialog),
                const SizedBox(width: 10),
                _headerBtn("Export Excel", Icons.file_download_outlined, Colors.black54, () {}),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _showCreateMaterialDialog, 
                  icon: const Icon(Icons.add, size: 16, color: Colors.white),
                  label: const Text("Create New Material", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1)),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("Show: ", style: TextStyle(fontSize: 12, color: Colors.grey)),
            Container(height: 30, padding: const EdgeInsets.symmetric(horizontal: 8), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: const Center(child: Text("100", style: TextStyle(fontSize: 12)))),
            const SizedBox(width: 15),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), child: const Text("Showing 100 of 665", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
          ],
        )
      ],
    );
  }

  Widget _headerBtn(String label, IconData icon, Color color, VoidCallback onTap) {
    return OutlinedButton.icon(onPressed: onTap, icon: Icon(icon, size: 16, color: color), label: Text(label, style: TextStyle(color: color, fontSize: 12)), style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300)));
  }

  Widget _buildTableContainer() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
              dataRowMinHeight: 65, dataRowMaxHeight: 75,
              columns: const [
                DataColumn(label: Text('Name & Tamil Name')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Price (₹)')),
                DataColumn(label: Text('Stock')),
                DataColumn(label: Text('Units')),
                DataColumn(label: Text('Actions')),
              ],
              rows: materials.map((m) => DataRow(cells: [
                DataCell(Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), const SizedBox(height: 4), Wrap(children: m.tags.map((t) => Container(margin: const EdgeInsets.only(right: 5), padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Text(t, style: const TextStyle(fontSize: 9, color: Colors.grey)))).toList())])),
                DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)), child: Text(m.type, style: const TextStyle(color: Colors.blue, fontSize: 9, fontWeight: FontWeight.bold)))),
                DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: m.category == "Factory" ? Colors.cyan.shade50 : Colors.blue.shade50, borderRadius: BorderRadius.circular(12)), child: Text(m.category, style: TextStyle(color: m.category == "Factory" ? Colors.cyan : Colors.blue, fontSize: 9, fontWeight: FontWeight.bold)))),
                DataCell(Text("₹${m.price.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text("${m.stock}", style: const TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(m.unit)),
                DataCell(Row(children: [_actionIcon(Icons.edit_outlined, Colors.blue, () {}), const SizedBox(width: 8), _actionIcon(Icons.delete_outline, Colors.red, _showDeleteDialog)])),
              ])).toList(),
            ),
          ),
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return Padding(padding: const EdgeInsets.all(16.0), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [_pageBtn("Prev", false), const SizedBox(width: 5), _pageBtn("1", true), _pageBtn("2", false), _pageBtn("3", false), _pageBtn("4", false), _pageBtn("5", false), _pageBtn("6", false), _pageBtn("7", false), const SizedBox(width: 5), _pageBtn("Next", false)]));
  }

  Widget _pageBtn(String text, bool isActive) {
    return Container(margin: const EdgeInsets.symmetric(horizontal: 2), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: isActive ? Colors.blue : Colors.white, border: Border.all(color: isActive ? Colors.blue : Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Text(text, style: TextStyle(color: isActive ? Colors.white : Colors.blue, fontSize: 12, fontWeight: FontWeight.bold)));
  }

  Widget _actionIcon(IconData icon, Color color, VoidCallback onTap) {
    return Container(width: 30, height: 30, decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)), child: IconButton(padding: EdgeInsets.zero, icon: Icon(icon, size: 16, color: color), onPressed: onTap));
  }
}