import 'package:flutter/material.dart';
import '../../../../models/product_model.dart'; // Adjust path based on your exact root

// --- DUMMY MODEL FOR PRODUCT HISTORY ---
class ProductHistoryRecord {
  final String date;
  final String activity;
  final String partyLocation;
  final String qty;
  final String price;
  final String reference;

  ProductHistoryRecord(this.date, this.activity, this.partyLocation, this.qty, this.price, this.reference);
}

class AvailableStock extends StatefulWidget {
  final bool isMobile;
  final VoidCallback onNavigateToPurchase;

  const AvailableStock({Key? key, required this.isMobile, required this.onNavigateToPurchase}) : super(key: key);

  @override
  State<AvailableStock> createState() => _AvailableStockState();
}

class _AvailableStockState extends State<AvailableStock> {
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  
  final int _rowsPerPage = 8;
  int _currentStockPage = 0; 

  @override
  void initState() {
    super.initState();
    _fetchData();
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));

    _allProducts = [
      Product(id: '#11', name: '50 - 50 BUSCUT', unit: 'PCS', availableStock: 0.00, price: 10.00),
      Product(id: '#49', name: '50-50 Sweet & Salt', unit: 'PCS', availableStock: 499.01, price: 10.00),
      Product(id: '#79', name: '7- up Fizz', unit: 'NOS', availableStock: 1067.00, price: 20.00),
      Product(id: '#77', name: '7- up Nimbooz', unit: 'NOS', availableStock: 720.00, price: 10.00),
      Product(id: '#24', name: 'Aachi Jam', unit: 'PCS', availableStock: 5000.00, price: 20.00),
      Product(id: '#32', name: 'Aqu 1 lit', unit: 'PCS', availableStock: 1076.00, price: 20.00),
      Product(id: '#33', name: 'Aqu 2 lit', unit: 'PCS', availableStock: 653.00, price: 35.00),
      Product(id: '#34', name: 'Aqu 500 lit', unit: 'PCS', availableStock: 0.00, price: 10.00),
      Product(id: '#20', name: 'Balloon 10 Pcs', unit: 'PCS', availableStock: 495.00, price: 230.00),
      ...List.generate(30, (index) => Product(id: '#${100 + index}', name: 'Extra Item ${index + 1}', unit: 'PCS', availableStock: 150.0 + (index * 5), price: 25.0 + index, isActive: true)),
    ];
    
    _filteredProducts = _allProducts;
    setState(() => _isLoading = false);
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _currentStockPage = 0; 
      _filteredProducts = _allProducts.where((p) => p.name.toLowerCase().contains(query)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStockHeader(),
        const SizedBox(height: 20),
        _isLoading ? const Center(child: CircularProgressIndicator()) : _buildStockWebView(),
      ],
    );
  }

  Widget _buildStockHeader() {
    return Container(
      padding: const EdgeInsets.all(20), 
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), 
      child: Wrap(
        alignment: WrapAlignment.spaceBetween, 
        crossAxisAlignment: WrapCrossAlignment.center, 
        spacing: 20, 
        runSpacing: 15, 
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text('Available Master Stock', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))), 
              SizedBox(height: 4), 
              Text('Consolidated inventory across all locations.', style: TextStyle(fontSize: 13, color: Colors.grey))
            ]
          ), 
          Row(
            mainAxisSize: MainAxisSize.min, 
            children: [
              SizedBox(
                width: widget.isMobile ? 180 : 250, 
                height: 42, 
                child: TextField(
                  controller: _searchController, 
                  decoration: InputDecoration(hintText: 'Search by product name...', hintStyle: const TextStyle(fontSize: 13), prefixIcon: const Icon(Icons.search, size: 18, color: Colors.grey), filled: true, fillColor: const Color(0xFFF8FAFC), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16))
                )
              ), 
              const SizedBox(width: 15), 
              ElevatedButton.icon(
                onPressed: () => _showCreateProductDialog(context), 
                icon: const Icon(Icons.add, size: 18), 
                label: Text(widget.isMobile ? 'New' : 'Create New Product'), 
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B59F8), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), elevation: 0)
              )
            ]
          )
        ]
      )
    );
  }

  Widget _buildStockWebView() {
    int start = _currentStockPage * _rowsPerPage;
    int end = start + _rowsPerPage;
    if (end > _filteredProducts.length) end = _filteredProducts.length;
    List<Product> pageItems = _filteredProducts.isEmpty ? [] : _filteredProducts.sublist(start, end);

    return _buildCustomTableCard(
      columns: const ['S.NO', 'ID', 'PRODUCT INFO', 'AVAILABLE STOCK', 'PRICING (PUR/SELL)', 'STATUS', 'QUICK ACTIONS'],
      rows: pageItems.asMap().entries.map((entry) {
        int idx = entry.key; Product p = entry.value; bool outStock = p.availableStock <= 0;
        return DataRow(cells: [
          DataCell(Text((start + idx + 1).toString(), style: const TextStyle(color: Colors.grey, fontSize: 13))),
          DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)), child: Text(p.id, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)))),
          DataCell(Row(children: [Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFFF8FAFC), border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.inventory_2_outlined, size: 18, color: Colors.grey)), const SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)), Text(p.unit, style: const TextStyle(color: Colors.grey, fontSize: 11))])])),
          DataCell(Container(padding: outStock ? const EdgeInsets.symmetric(horizontal: 10, vertical: 4) : EdgeInsets.zero, decoration: outStock ? BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(20)) : null, child: Text('${p.availableStock.toStringAsFixed(2)} ${p.unit.toLowerCase()}', style: TextStyle(color: outStock ? const Color(0xFFDC2626) : const Color(0xFF10B981), fontWeight: FontWeight.bold, fontSize: 13)))),
          DataCell(Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text('₹${p.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text('Sell: ₹${p.price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.grey, fontSize: 10))])),
          DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFE0F2FE), borderRadius: BorderRadius.circular(20)), child: const Text('Active', style: TextStyle(color: Color(0xFF0284C7), fontWeight: FontWeight.bold, fontSize: 11)))),
          DataCell(Row(children: [
            _actionBtn(Icons.shopping_cart_outlined, 'Purchase', Colors.blue, widget.onNavigateToPurchase),
            const SizedBox(width: 8),
            _smallIconBtn(Icons.history, Colors.grey.shade700, () => _showHistoryDialog(context, p)),
            const SizedBox(width: 4),
            PopupMenuButton<String>(
              tooltip: 'More options',
              onSelected: (value) {
                if (value == 'edit') { _showCreateProductDialog(context); } 
                else if (value == 'delete') { _showDeleteProductDialog(context, p); }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(value: 'edit', child: ListTile(leading: Icon(Icons.edit_outlined, size: 20), title: Text('Edit Product'), contentPadding: EdgeInsets.zero, dense: true)),
                const PopupMenuItem<String>(value: 'delete', child: ListTile(leading: Icon(Icons.delete_outline, size: 20, color: Colors.red), title: Text('Delete', style: TextStyle(color: Colors.red)), contentPadding: EdgeInsets.zero, dense: true)),
              ],
              child: const Padding(padding: EdgeInsets.symmetric(horizontal: 4.0), child: Icon(Icons.more_vert, size: 18, color: Colors.grey)),
            ),
          ])),
        ]);
      }).toList(),
      currentPage: _currentStockPage,
      totalItems: _filteredProducts.length,
      onPageChanged: (newPage) => setState(() => _currentStockPage = newPage),
    );
  }

  // --- Helpers & UI Blocks ---
  Widget _actionBtn(IconData icon, String text, MaterialColor color, VoidCallback onTap) { return OutlinedButton.icon(onPressed: onTap, icon: Icon(icon, size: 14, color: color), label: Text(text, style: TextStyle(color: color, fontSize: 11)), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0), side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))); }
  Widget _smallIconBtn(IconData icon, Color color, VoidCallback onTap) { return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(4), child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Icon(icon, size: 14, color: color))); }
  Widget _buildPopupLabel(String text) { return Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(text, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey.shade600, letterSpacing: 0.5))); }
  
  Widget _buildPopupTextField({String? initialValue}) { return TextFormField(initialValue: initialValue, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), filled: true, fillColor: const Color(0xFFFCFDFE), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF1B59F8))))); }
  Widget _buildPopupDropdown(List<String> items) { return DropdownButtonFormField<String>(value: items.first, icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey), decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), filled: true, fillColor: const Color(0xFFFCFDFE), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200))), items: items.map((String value) { return DropdownMenuItem<String>(value: value, child: Text(value, style: const TextStyle(fontSize: 14))); }).toList(), onChanged: (_) {}); }

  Widget _buildCustomTableCard({required List<String> columns, required List<DataRow> rows, required int currentPage, required int totalItems, required Function(int) onPageChanged}) {
    int totalPages = (totalItems / _rowsPerPage).ceil();
    if (totalPages == 0) totalPages = 1;
    int startIdx = currentPage * _rowsPerPage + 1;
    int endIdx = (startIdx - 1) + _rowsPerPage;
    if (endIdx > totalItems) endIdx = totalItems;
    if (totalItems == 0) { startIdx = 0; endIdx = 0; }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth), 
                  child: DataTable(
                    columnSpacing: 16, horizontalMargin: 20, headingRowHeight: 50, dataRowMaxHeight: 70, 
                    headingRowColor: MaterialStateProperty.all(const Color(0xFFF8FAFC)),
                    columns: columns.map((c) => DataColumn(label: Text(c, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87)))).toList(),
                    rows: rows,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Showing $startIdx to $endIdx of $totalItems entries', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(width: 20),
                    IconButton(icon: const Icon(Icons.chevron_left, size: 20), onPressed: currentPage > 0 ? () => onPageChanged(currentPage - 1) : null, color: currentPage > 0 ? Colors.black87 : Colors.grey.shade300),
                    Text('Page ${currentPage + 1} of $totalPages', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    IconButton(icon: const Icon(Icons.chevron_right, size: 20), onPressed: currentPage < totalPages - 1 ? () => onPageChanged(currentPage + 1) : null, color: currentPage < totalPages - 1 ? Colors.black87 : Colors.grey.shade300),
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }

  // --- DIALOGS ---
  void _showCreateProductDialog(BuildContext context) { showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) { return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), backgroundColor: Colors.white, surfaceTintColor: Colors.transparent, child: Container(width: 450, padding: const EdgeInsets.all(24), child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Create Vendor Product', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)), IconButton(icon: const Icon(Icons.close, color: Colors.grey, size: 20), onPressed: () => Navigator.of(context).pop(), padding: EdgeInsets.zero, constraints: const BoxConstraints())]), const SizedBox(height: 25), Center(child: Stack(clipBehavior: Clip.none, children: [Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade300, width: 1.5)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.cloud_upload_outlined, color: Colors.grey.shade500, size: 30), const SizedBox(height: 5), Text('Upload', style: TextStyle(color: Colors.grey.shade600, fontSize: 12))])), Positioned(bottom: -5, right: -5, child: Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle), child: const Icon(Icons.camera_alt, color: Colors.white, size: 12)))]),), const SizedBox(height: 30), _buildPopupLabel('PRODUCT NAME'), _buildPopupTextField(), const SizedBox(height: 16), Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildPopupLabel('BASE UNIT'), _buildPopupDropdown(['Pcs', 'Nos', 'Box'])])), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildPopupLabel('STATUS'), _buildPopupDropdown(['Active', 'Inactive'])]))]), const SizedBox(height: 16), Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildPopupLabel('DEFAULT PURCHASE PRICE'), _buildPopupTextField(initialValue: '0')])), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildPopupLabel('DEFAULT SELLING PRICE'), _buildPopupTextField(initialValue: '0')]))]), const SizedBox(height: 30), Row(mainAxisAlignment: MainAxisAlignment.center, children: [TextButton(onPressed: () => Navigator.of(context).pop(), style: TextButton.styleFrom(foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)), child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold))), const SizedBox(width: 10), ElevatedButton(onPressed: () => Navigator.of(context).pop(), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B59F8), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), elevation: 0), child: const Text('Save Product', style: TextStyle(fontWeight: FontWeight.bold)))])])))); }); }
  
  void _showHistoryDialog(BuildContext context, Product product) { final List<ProductHistoryRecord> historyData = [ProductHistoryRecord('13-05-2026', 'Purchase', 'MURUGAN AGENCIES', '+450.00 PCS', '11.60', 'bP260513-01'), ProductHistoryRecord('10-05-2026', 'Transfer Out', 'Main Kitchen', '-10.00 PCS', '11.60', 'TR/26/54'), ProductHistoryRecord('08-05-2026', 'Sale', 'Counter Sale', '-5.00 PCS', '20.00', 'INV-3456'), ProductHistoryRecord('05-05-2026', 'Purchase', 'SRI MASANI AMMAN...', '+200.00 PCS', '11.50', 'bP260505-02')]; showDialog(context: context, builder: (BuildContext context) { return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), backgroundColor: Colors.white, child: Container(width: 800, padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('History: - ${product.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop(), padding: EdgeInsets.zero, constraints: const BoxConstraints())]), const SizedBox(height: 20), SizedBox(width: double.infinity, child: DataTable(headingRowColor: MaterialStateProperty.all(Colors.grey.shade100), columns: const [DataColumn(label: Text('DATE')), DataColumn(label: Text('ACTIVITY')), DataColumn(label: Text('PARTY/LOCATION')), DataColumn(label: Text('QTY')), DataColumn(label: Text('PRICE')), DataColumn(label: Text('REFERENCE'))], rows: historyData.map((record) => DataRow(cells: [DataCell(Text(record.date)), DataCell(Text(record.activity)), DataCell(Text(record.partyLocation)), DataCell(Text(record.qty, style: TextStyle(color: record.qty.startsWith('+') ? Colors.green : Colors.red, fontWeight: FontWeight.bold))), DataCell(Text('₹${record.price}')), DataCell(Text(record.reference))])).toList()))]))); }); }
  
  void _showDeleteProductDialog(BuildContext context, Product product) { showDialog(context: context, builder: (BuildContext context) { return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: Colors.white, child: Container(width: 400, padding: const EdgeInsets.all(30), child: Column(mainAxisSize: MainAxisSize.min, children: [Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF9C4A6), width: 4)), child: const Center(child: Text('!', style: TextStyle(fontSize: 45, color: Color(0xFFF2A365), fontWeight: FontWeight.w400)))), const SizedBox(height: 25), const Text('Are you sure?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)), const SizedBox(height: 10), const Text("You won't be able to revert this!", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14)), const SizedBox(height: 30), Row(mainAxisAlignment: MainAxisAlignment.center, children: [ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), child: const Text('Yes, delete it!', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))), const SizedBox(width: 15), ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6B7280), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), child: const Text('Cancel', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)))])]))); }); }
}