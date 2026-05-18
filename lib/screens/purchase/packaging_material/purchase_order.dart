import 'package:flutter/material.dart';

// --- DATA MODEL ---
class PurchaseOrderData {
  final String orderDate, requestDate, vendor, materials, status;
  PurchaseOrderData(this.orderDate, this.requestDate, this.vendor, this.materials, this.status);
}

class PurchaseOrderView extends StatefulWidget {
  final Function(bool isCreating, bool isEditing) onModeChange;
  const PurchaseOrderView({super.key, required this.onModeChange});

  @override
  State<PurchaseOrderView> createState() => _PurchaseOrderViewState();
}

class _PurchaseOrderViewState extends State<PurchaseOrderView> {
  bool _isCreatingNew = false;
  bool _isEditingOrder = false;

  void _updateMode(bool creating, bool editing) {
    setState(() {
      _isCreatingNew = creating;
      _isEditingOrder = editing;
    });
    widget.onModeChange(creating, editing);
  }

  @override
  Widget build(BuildContext context) {
    if (_isCreatingNew || _isEditingOrder) {
      return _buildOrderForm(isEdit: _isEditingOrder);
    }
    return _buildPurchaseOrderList();
  }

  Widget _buildPurchaseOrderList() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(25),
      child: PurchaseOrderDataTable(
        onCreateNew: () => _updateMode(true, false),
        onEdit: () => _updateMode(false, true),
      ),
    );
  }

  Widget _buildOrderForm({required bool isEdit}) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(25), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(isEdit ? "Edit Purchase Order" : "New Purchase Order", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                OutlinedButton.icon(
                  icon: const Icon(Icons.arrow_back, size: 16), label: const Text("Back to List"),
                  onPressed: () => _updateMode(false, false),
                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ],
            ),
            const Divider(height: 30),
            _buildSectionTitle("Order Details"), const SizedBox(height: 10),
            Wrap( spacing: 20, runSpacing: 20, children: [
                _buildFormDropdown("Vendor", isEdit ? "test" : "Select a vendor"), 
                _buildFormTextField("Order Date", isEdit ? "16-03-2026" : "15-05-2026", hasIcon: true),
                _buildFormTextField("Request Date", isEdit ? "16-03-2026" : "15-05-2026", hasIcon: true), 
                _buildFormTextField("Estimation Days", "0"),
                if (isEdit) _buildFormDropdown("Status", "Pending", isStatus: true), 
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, 
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("Notes", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 5), 
                TextFormField(initialValue: "Optional notes...", maxLines: 3, decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400))))
              ])
            ),
            const SizedBox(height: 20), 
            _buildSectionTitle("Items"), const SizedBox(height: 10),
            
            SizedBox(
              width: double.infinity, 
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(3), 1: FlexColumnWidth(1.5), 2: FlexColumnWidth(1.5), 3: FlexColumnWidth(1.5), 4: IntrinsicColumnWidth()
                }, 
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey.shade100), 
                    children: [_tableHeader("Packaging Material"), _tableHeader("Available Qty"), _tableHeader("Quantity"), _tableHeader("Unit"), _tableHeader("")]
                  ), 
                  TableRow(
                    children: [
                      _tableCell(DropdownButtonFormField<String>(
                        value: isEdit ? "Tissue Paper" : "Select...", isDense: true, 
                        decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero), 
                        items: const [DropdownMenuItem(value: "Select...", child: Text("Select...")), DropdownMenuItem(value: "Tissue Paper", child: Text("Tissue Paper"))], 
                        onChanged: (v){}
                      )), 
                      _tableCell(const Text("0.00")), 
                      _tableCell(TextFormField(initialValue: isEdit ? "100" : "1", decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero))), 
                      _tableCell(TextFormField(initialValue: isEdit ? "Pkts" : "N/A", decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero))), 
                      _tableCell(IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () {}))
                    ]
                  )
                ]
              ),
            ),
            
            const SizedBox(height: 10),
            Align(alignment: Alignment.centerRight, child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 16), label: const Text("Add Item"), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))))),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: () => _updateMode(false, false), child: const Text("Cancel")), const SizedBox(width: 10),
                ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white), child: Text(isEdit ? "Update Order" : "Save Order"))
              ],
            )
          ],
        ),
      ),
    );
  }

  // Helpers
  Widget _buildSectionTitle(String title) => Padding(padding: const EdgeInsets.only(bottom: 15.0), child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),);
  Widget _buildFormTextField(String label, String hint, {bool hasIcon = false}) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 5), TextFormField(initialValue: hint, style: const TextStyle(fontSize: 14), decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(12), suffixIcon: hasIcon ? const Icon(Icons.calendar_today_outlined, size: 16) : null, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400))),), ]));
  Widget _buildFormDropdown(String label, String hint, {bool isStatus = false}) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 5), DropdownButtonFormField<String>(value: isStatus ? hint : null, hint: !isStatus ? Text(hint, style: const TextStyle(fontSize: 14)) : null, isDense: true, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400))), items: [DropdownMenuItem(value: hint, child: Text(hint, style: const TextStyle(fontSize: 14)))], onChanged: (value) {},), ]));
  Widget _tableHeader(String text) => Padding(padding: const EdgeInsets.all(12.0), child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)));
  Widget _tableCell(Widget child) => Padding(padding: const EdgeInsets.all(10.0), child: child);
}

class PurchaseOrderDataTable extends StatefulWidget {
  final VoidCallback onCreateNew;
  final VoidCallback onEdit;
  const PurchaseOrderDataTable({super.key, required this.onCreateNew, required this.onEdit});

  @override
  State<PurchaseOrderDataTable> createState() => _PurchaseOrderDataTableState();
}

class _PurchaseOrderDataTableState extends State<PurchaseOrderDataTable> {
  late _PurchaseOrderDataSource _dataSource;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    _dataSource = _PurchaseOrderDataSource(
      onEdit: widget.onEdit,
      onDelete: () => _showDeleteDialog(context)
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(30.0),
          content: SizedBox(
            width: 350, 
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: [
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 3)),
                  child: const Center(child: Text("!", style: TextStyle(color: Color(0xFFF8BB86), fontSize: 50, fontWeight: FontWeight.w400))),
                ),
                const SizedBox(height: 25),
                const Text("Are you sure?", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                const Text("You won't be able to revert this!", style: TextStyle(color: Color(0xFF545454), fontSize: 16), textAlign: TextAlign.center),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC3545), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), elevation: 0),
                      child: const Text("Yes, delete it!", style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), elevation: 0),
                      child: const Text("Cancel", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              const Text("Packaging Purchase Orders", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), 
              ElevatedButton.icon(
                icon: const Icon(Icons.add, size: 16), label: const Text("Create New Order"), 
                onPressed: widget.onCreateNew, 
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))
              )
            ]
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 15, runSpacing: 15, crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [const Text("Vendor: ", style: TextStyle(fontWeight: FontWeight.w600)), const SizedBox(width: 8), SizedBox(width: 150, child: DropdownButtonFormField<String>(value: "All Vendors", isDense: true, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))), items: const [DropdownMenuItem(value: "All Vendors", child: Text("All Vendors"))], onChanged: (val) {}))]),
              Row(mainAxisSize: MainAxisSize.min, children: [const Text("From: ", style: TextStyle(fontWeight: FontWeight.w600)), const SizedBox(width: 8), SizedBox(width: 140, child: TextFormField(initialValue: "dd-mm-yyyy", decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), suffixIcon: const Icon(Icons.calendar_today, size: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)))))]),
              Row(mainAxisSize: MainAxisSize.min, children: [const Text("To: ", style: TextStyle(fontWeight: FontWeight.w600)), const SizedBox(width: 8), SizedBox(width: 140, child: TextFormField(initialValue: "dd-mm-yyyy", decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), suffixIcon: const Icon(Icons.calendar_today, size: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)))))]),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.close, size: 16, color: Colors.grey), label: const Text("Reset", style: TextStyle(color: Colors.grey)), style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))))
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Theme(
              data: Theme.of(context).copyWith(
                cardColor: Colors.white, dividerColor: Colors.transparent, cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero, color: Colors.white),
              ),
              child: PaginatedDataTable(
                columns: const [
                  DataColumn(label: Text('S.No', style: TextStyle(fontWeight: FontWeight.bold))), 
                  DataColumn(label: Text('Order Date', style: TextStyle(fontWeight: FontWeight.bold))), 
                  DataColumn(label: Text('Request Date', style: TextStyle(fontWeight: FontWeight.bold))), 
                  DataColumn(label: Text('Vendor', style: TextStyle(fontWeight: FontWeight.bold))), 
                  DataColumn(label: Text('Material(s)', style: TextStyle(fontWeight: FontWeight.bold))), 
                  DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))), 
                  DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)))
                ],
                source: _dataSource, 
                rowsPerPage: _rowsPerPage, 
                showCheckboxColumn: false, 
                columnSpacing: 20,
                onRowsPerPageChanged: (int? value) => setState(() => _rowsPerPage = value!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PurchaseOrderDataSource extends DataTableSource {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  _PurchaseOrderDataSource({required this.onEdit, required this.onDelete});

  final List<PurchaseOrderData> _orders = [
    PurchaseOrderData('3/16/2026', '3/16/2026', 'test', 'Tissue Paper (100 Pkts)', 'Pending'), 
    PurchaseOrderData('3/11/2026', '3/21/2026', 'Testvendors', 'Premium Athirasam (50 Pcs), Flexo (S) (120 Pcs)', 'Pending'), 
    PurchaseOrderData('2/17/2026', '3/14/2026', 'vendor1', 'pouch (1 box)', 'Purchased'), 
    PurchaseOrderData('2/16/2026', '3/13/2026', 'vendor1', 'pouch (1 box)', 'Pending'), 
    PurchaseOrderData('1/2/2026', '1/7/2026', 'test', 'Cardbox (2 box)', 'Purchased'), 
    PurchaseOrderData('1/1/2026', '1/6/2026', 'vendor1', 'pouch (2 box)', 'Purchased'), 
    PurchaseOrderData('1/1/2026', '1/5/2026', 'test', 'Cardbox (10 box)', 'Pending'),
    PurchaseOrderData('1/23/2026', '1/25/2026', 'vendor1', 'Cardbox (2 box)', 'Pending'),
    PurchaseOrderData('12/2/2025', '-', 'test', 'Cardbox (10 box)', 'Purchased'),
    PurchaseOrderData('11/28/2025', '-', 'test', 'pouch (1 box)', 'Purchased'),
    PurchaseOrderData('11/28/2025', '-', 'test', 'Cardbox (1 box)', 'Purchased'),
  ];
  
  @override
  DataRow? getRow(int index) {
    if (index >= _orders.length) return null;
    final order = _orders[index];
    
    Color statusColor = order.status == 'Pending' ? Colors.grey.shade600 : Colors.green.shade600;

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(order.orderDate)), 
      DataCell(Text(order.requestDate)), 
      DataCell(Text(order.vendor)), 
      DataCell(SizedBox(width: 250, child: Text(order.materials, overflow: TextOverflow.ellipsis, maxLines: 2))), 
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(4)),
        child: Text(order.status, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      )), 
      DataCell(Row(children: [
        InkWell(
          onTap: onEdit,
          child: Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.all(4), decoration: BoxDecoration(border: Border.all(color: Colors.blue.shade200), borderRadius: BorderRadius.circular(4)), child: Icon(Icons.edit_outlined, color: Colors.blue.shade600, size: 16)),
        ),
        InkWell(
          onTap: onDelete,
          child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(border: Border.all(color: Colors.red.shade200), borderRadius: BorderRadius.circular(4)), child: Icon(Icons.delete_outline, color: Colors.red.shade600, size: 16)),
        )
      ]))
    ]);
  }

  @override bool get isRowCountApproximate => false;
  @override int get rowCount => _orders.length;
  @override int get selectedRowCount => 0;
}