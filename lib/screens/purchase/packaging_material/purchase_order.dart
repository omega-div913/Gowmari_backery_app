import 'package:flutter/material.dart';
import 'dart:math';

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
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isEdit ? "Edit Purchase Order" : "New Purchase Order",
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                    const SizedBox(height: 4),
                    Text("Fill in the details below to proceed.",
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
                  ],
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text("Back to List"),
                  onPressed: () => _updateMode(false, false),
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
                ),
              ],
            ),
            const Divider(height: 30),
            _buildSectionTitle("Order Details"),
            const SizedBox(height: 10),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
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
                  const Text("Notes", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 5),
                  TextFormField(
                      initialValue: "Optional notes...",
                      maxLines: 3,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.all(12),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey.shade400))))
                ])),
            const SizedBox(height: 20),
            _buildSectionTitle("Items"),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(1.5),
                    2: FlexColumnWidth(1.5),
                    3: FlexColumnWidth(1.5),
                    4: IntrinsicColumnWidth()
                  },
                  children: [
                    TableRow(
                        decoration: BoxDecoration(color: Colors.grey.shade100),
                        children: [
                          _tableHeader("Packaging Material"),
                          _tableHeader("Available Qty"),
                          _tableHeader("Quantity"),
                          _tableHeader("Unit"),
                          _tableHeader("")
                        ]),
                    TableRow(children: [
                      _tableCell(DropdownButtonFormField<String>(
                          value: isEdit ? "Tissue Paper" : "Select...",
                          isDense: true,
                          decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
                          items: const [
                            DropdownMenuItem(value: "Select...", child: Text("Select...")),
                            DropdownMenuItem(value: "Tissue Paper", child: Text("Tissue Paper"))
                          ],
                          onChanged: (v) {})),
                      _tableCell(const Text("0.00")),
                      _tableCell(TextFormField(
                          initialValue: isEdit ? "100" : "1",
                          decoration:
                              const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero))),
                      _tableCell(TextFormField(
                          initialValue: isEdit ? "Pkts" : "N/A",
                          decoration:
                              const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero))),
                      _tableCell(IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red), onPressed: () {}))
                    ])
                  ]),
            ),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text("Add Item"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)))),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                    onPressed: () => _updateMode(false, false),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                    child: const Text("Cancel")),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                    child: Text(isEdit ? "Update Order" : "Save Order"))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2563EB))),
      );

  Widget _buildFormTextField(String label, String hint, {bool hasIcon = false}) => SizedBox(
      width: 200,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: hint,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(12),
              suffixIcon: hasIcon ? const Icon(Icons.calendar_today_outlined, size: 16) : null,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400))),
        ),
      ]));

  Widget _buildFormDropdown(String label, String hint, {bool isStatus = false}) => SizedBox(
      width: 200,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        DropdownButtonFormField(
          value: isStatus ? hint : null,
          hint: !isStatus ? Text(hint, style: const TextStyle(fontSize: 14)) : null,
          isDense: true,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400))),
          items: [DropdownMenuItem(value: hint, child: Text(hint, style: const TextStyle(fontSize: 14)))],
          onChanged: (value) {},
        ),
      ]));

  Widget _tableHeader(String text) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)));

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
  // Pagination State Variables
  int _currentPage = 1;
  int _rowsPerPage = 10;

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
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 3)),
                  child: const Center(
                      child: Text("!",
                          style: TextStyle(color: Color(0xFFF8BB86), fontSize: 50, fontWeight: FontWeight.w400))),
                ),
                const SizedBox(height: 25),
                const Text("Are you sure?",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Color(0xFF545454)),
                    textAlign: TextAlign.center),
                const SizedBox(height: 10),
                const Text("You won't be able to revert this!",
                    style: TextStyle(color: Color(0xFF545454), fontSize: 16), textAlign: TextAlign.center),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDC3545),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          elevation: 0),
                      child: const Text("Yes, delete it!", style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D6EFD),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          elevation: 0),
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
    // Pagination Calculations
    int totalItems = _orders.length;
    int totalPages = (totalItems / _rowsPerPage).ceil();
    int startIndex = (_currentPage - 1) * _rowsPerPage;
    int endIndex = min(startIndex + _rowsPerPage, totalItems);
    List<PurchaseOrderData> paginatedEntries = _orders.sublist(startIndex, endIndex);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Packaging Purchase Orders",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  const SizedBox(height: 4),
                  Text("Manage and track all packaging orders.",
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
                ],
              ),
              Container(
                width: 280,
                height: 40,
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search by vendor, material...",
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade500, size: 20),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              ElevatedButton.icon(
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text("Create New Order"),
                  onPressed: widget.onCreateNew,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)))
            ],
          ),
          const SizedBox(height: 25),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Text("Vendor: ", style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                SizedBox(
                    width: 150,
                    child: DropdownButtonFormField(
                        value: "All Vendors",
                        isDense: true,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                        items: const [DropdownMenuItem(value: "All Vendors", child: Text("All Vendors"))],
                        onChanged: (val) {}))
              ]),
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Text("From: ", style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                SizedBox(
                    width: 140,
                    child: TextFormField(
                        initialValue: "dd-mm-yyyy",
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            suffixIcon: const Icon(Icons.calendar_today, size: 14),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)))))
              ]),
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Text("To: ", style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                SizedBox(
                    width: 140,
                    child: TextFormField(
                        initialValue: "dd-mm-yyyy",
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            suffixIcon: const Icon(Icons.calendar_today, size: 14),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)))))
              ]),
              OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.close, size: 16, color: Colors.grey),
                  label: const Text("Reset", style: TextStyle(color: Colors.grey)),
                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))))
            ],
          ),
          const SizedBox(height: 20),
          
          // Custom Modern Grid (Table)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(60),
                    1: FlexColumnWidth(1.2),
                    2: FlexColumnWidth(1.2),
                    3: FlexColumnWidth(1.5),
                    4: FlexColumnWidth(3.0),
                    5: FlexColumnWidth(1.2),
                    6: FixedColumnWidth(110), // Correct width for 2 action icons without overflow
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    // Header Row
                    TableRow(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
                      ),
                      children: [
                        _buildCustomHeaderCell('S.NO'),
                        _buildCustomHeaderCell('ORDER DATE'),
                        _buildCustomHeaderCell('REQUEST DATE'),
                        _buildCustomHeaderCell('VENDOR'),
                        _buildCustomHeaderCell('MATERIAL(S)'),
                        _buildCustomHeaderCell('STATUS'),
                        _buildCustomHeaderCell('ACTIONS'),
                      ]
                    ),
                    // Data Rows
                    ...paginatedEntries.asMap().entries.map((mapEntry) {
                      int index = mapEntry.key;
                      PurchaseOrderData order = mapEntry.value;
                      
                      Color statusBg = order.status == 'Pending' ? const Color(0xFFF1F5F9) : const Color(0xFFF0FDF4);
                      Color statusText = order.status == 'Pending' ? const Color(0xFF64748B) : const Color(0xFF16A34A);

                      return TableRow(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: index == paginatedEntries.length - 1 ? Colors.transparent : const Color(0xFFF1F5F9))),
                        ),
                        children: [
                          _buildCustomDataCell((startIndex + index + 1).toString()),
                          _buildCustomDataCell(order.orderDate),
                          _buildCustomDataCell(order.requestDate),
                          _buildCustomDataCell(order.vendor),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            child: Text(
                              order.materials, 
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)),
                                child: Text(order.status, style: TextStyle(color: statusText, fontSize: 11, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                _buildActionIcon(Icons.edit_outlined, const Color(0xFF2563EB), widget.onEdit),
                                const SizedBox(width: 8),
                                _buildActionIcon(Icons.delete_outline, const Color(0xFFDC2626), () => _showDeleteDialog(context)),
                              ]
                            ),
                          )
                        ]
                      );
                    }),
                  ],
                ),
                // Custom Modern Pagination Footer
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                    border: Border(top: BorderSide(color: Color(0xFFE2E8F0)))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Showing ${totalItems == 0 ? 0 : startIndex + 1} to $endIndex of $totalItems entries",
                        style: const TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500)
                      ),
                      Row(
                        children: [
                          const Text("Rows per page: ", style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                          const SizedBox(width: 8),
                          Container(
                            height: 32,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                              borderRadius: BorderRadius.circular(6)
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: _rowsPerPage,
                                icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
                                style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B), fontWeight: FontWeight.w500),
                                items: [5, 10, 20, 50].map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    _rowsPerPage = newValue!;
                                    _currentPage = 1; // Reset to first page
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Prev Page Button
                          InkWell(
                            onTap: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: _currentPage > 1 ? Colors.white : const Color(0xFFF1F5F9),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Icon(Icons.chevron_left, size: 18, color: _currentPage > 1 ? const Color(0xFF1E293B) : const Color(0xFF94A3B8)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text("Page $_currentPage of ${totalPages == 0 ? 1 : totalPages}", style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B), fontWeight: FontWeight.w500)),
                          const SizedBox(width: 12),
                          // Next Page Button
                          InkWell(
                            onTap: _currentPage < totalPages ? () => setState(() => _currentPage++) : null,
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: _currentPage < totalPages ? Colors.white : const Color(0xFFF1F5F9),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Icon(Icons.chevron_right, size: 18, color: _currentPage < totalPages ? const Color(0xFF1E293B) : const Color(0xFF94A3B8)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF64748B), letterSpacing: 0.5)),
    );
  }

  Widget _buildCustomDataCell(String text, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        text, 
        style: TextStyle(
          fontSize: 13, 
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500, 
          color: color ?? const Color(0xFF1E293B)
        )
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, Color iconColor, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.circular(6)
        ),
        child: Icon(icon, color: iconColor, size: 16)
      ),
    );
  }
}