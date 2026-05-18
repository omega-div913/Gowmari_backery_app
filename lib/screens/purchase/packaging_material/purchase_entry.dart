import 'package:flutter/material.dart';

// --- DATA MODEL ---
class PurchaseEntryData {
  final String date, invoiceNo, vendor, materials, totalAmount, images, balance, status;
  PurchaseEntryData(this.date, this.invoiceNo, this.vendor, this.materials, this.totalAmount, this.images, this.balance, this.status);
}

class PurchaseEntryView extends StatefulWidget {
  final Function(bool isCreating, bool isEditing) onModeChange;
  const PurchaseEntryView({super.key, required this.onModeChange});

  @override
  State<PurchaseEntryView> createState() => _PurchaseEntryViewState();
}

class _PurchaseEntryViewState extends State<PurchaseEntryView> {
  bool _isCreatingNew = false;
  bool _isEditingPurchase = false;

  void _updateMode(bool creating, bool editing) {
    setState(() {
      _isCreatingNew = creating;
      _isEditingPurchase = editing;
    });
    widget.onModeChange(creating, editing);
  }

  @override
  Widget build(BuildContext context) {
    if (_isCreatingNew || _isEditingPurchase) {
      return _buildPurchaseEntryForm(isEdit: _isEditingPurchase);
    }
    return _buildPurchaseHistoryList();
  }

  Widget _buildPurchaseHistoryList() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: PurchaseHistoryDataTable(
        onCreateNew: () => _updateMode(true, false),
        onEdit: () => _updateMode(false, true),
      ),
    );
  }

  Widget _buildPurchaseEntryForm({required bool isEdit}) {
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
                Text(isEdit ? "Edit Purchase Entry" : "New Purchase Entry", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                OutlinedButton.icon(
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text("Back to List"),
                  onPressed: () => _updateMode(false, false),
                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ],
            ),
            const Divider(height: 30),
            _buildSectionTitle("Invoice Details"),
            Wrap(
              spacing: 20, runSpacing: 20,
              children: [
                _buildFormDropdown("Vendor", isEdit ? "Testvendors" : "Select a vendor"),
                _buildFormDropdown("Link Purchase Order", "Manual Entry"),
                _buildFormTextField("Invoice Number", isEdit ? "2" : "No."),
                _buildFormTextField("Purchase Date", "15-05-2026", hasIcon: true),
                _buildFormTextField("Batch Code", isEdit ? "PK-2026-05-1" : ""),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle("Purchase Items"),
                ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 16),
                  label: const Text("Add Item"), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ]
            ),
            _buildItemsTable(isEdit: isEdit),
            const SizedBox(height: 20),
            
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 450,
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text("Invoice Summary", style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      const Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            _buildSummaryRowCustom("Sub Total", const Text("₹10.00", style: TextStyle(fontSize: 14))),
                            _buildSummaryRowCustom("Total CGST", const Text("₹0.25", style: TextStyle(fontSize: 14))),
                            _buildSummaryRowCustom("Total SGST", const Text("₹0.25", style: TextStyle(fontSize: 14))),
                            _buildSummaryRowCustom("Total (Before Round Off)", const Text("₹10.50", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                            _buildSummaryRowCustom("Round Off", SizedBox(width: 80, child: TextFormField(initialValue: "0", textAlign: TextAlign.center, decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.symmetric(vertical: 8), border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey.shade300)))))),
                            _buildSummaryRowCustom("Grand Total", const Text("₹10.50", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey.shade200, padding: const EdgeInsets.all(15),
                        child: _buildSummaryRowCustom("Balance Due", const Text("₹10.50", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)), isBold: true, isLarge: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Icon(Icons.camera_alt_outlined, color: Colors.blue, size: 20),
                const SizedBox(width: 8),
                _buildSectionTitle("Image Attachments"),
              ],
            ),
            const Divider(height: 1),
            const SizedBox(height: 15),
            const Text("Purchase Images", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 10),
            Container(
              height: 120, width: 120,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
              child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.add_circle_outline, color: Colors.grey), SizedBox(height: 8), Text("Add Images", style: TextStyle(color: Colors.grey)),
                ],),
            ),
            const SizedBox(height: 10),
            const Row(children: [Icon(Icons.info_outline, size: 14, color: Colors.grey), SizedBox(width: 5), Text("Images are stored on the server only when the purchase is saved.", style: TextStyle(fontSize: 12, color: Colors.grey))]),
            const Row(children: [Icon(Icons.info_outline, size: 14, color: Colors.grey), SizedBox(width: 5), Text("Attachments are saved only when you click 'Save' or 'Update'.", style: TextStyle(fontSize: 12, color: Colors.grey))]),
            const Divider(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                OutlinedButton(
                  onPressed: () => _updateMode(false, false), 
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.grey.shade600, foregroundColor: Colors.white, side: BorderSide.none),
                  child: const Text("Cancel")), 
                const SizedBox(width: 10),
                ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white,),
                  child: Text(isEdit ? "Save Purchase" : "Save Purchase"),)
              ],)
          ],
        ),
      ),
    );
  }

  // Helpers
  Widget _buildSectionTitle(String title) => Padding(padding: const EdgeInsets.only(bottom: 15.0), child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),);
  Widget _buildFormTextField(String label, String hint, {bool hasIcon = false}) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 5), TextFormField(initialValue: hint, style: const TextStyle(fontSize: 14), decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(12), suffixIcon: hasIcon ? const Icon(Icons.calendar_today_outlined, size: 16) : null, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400))),), ]));
  Widget _buildFormDropdown(String label, String hint, {bool isStatus = false}) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 5), DropdownButtonFormField<String>(value: isStatus ? hint : null, hint: !isStatus ? Text(hint, style: const TextStyle(fontSize: 14)) : null, isDense: true, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400))), items: [DropdownMenuItem(value: hint, child: Text(hint, style: const TextStyle(fontSize: 14)))], onChanged: (value) {},), ]));
  
  Widget _buildItemsTable({bool isEdit = false}) => Container(
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
    child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Table(border: TableBorder.all(color: Colors.grey.shade300), columnWidths: const { 0: IntrinsicColumnWidth(), 1: IntrinsicColumnWidth(), 2: IntrinsicColumnWidth(), 3: IntrinsicColumnWidth(), 4: IntrinsicColumnWidth(), 5: IntrinsicColumnWidth(), 6: IntrinsicColumnWidth(), 7: IntrinsicColumnWidth(), 8: IntrinsicColumnWidth() }, children: [TableRow(decoration: BoxDecoration(color: Colors.grey.shade100), children: [ _tableHeader("Raw Material"), _tableHeader("Qty (Kg)"), _tableHeader("Unit/Kg"), _tableHeader("Total Units"), _tableHeader("Sub Total"), _tableHeader("Price/Unit"), _tableHeader("GST Type & %"), _tableHeader("GST Amount"), _tableHeader("Item Total"), _tableHeader("")]), 
    TableRow(children: [
      _tableCell(DropdownButtonFormField<String>(value: isEdit ? "test" : null, hint: const Text("Select..."), isDense: true, decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero), items: const [DropdownMenuItem(value: "test", child: Text("test", style: TextStyle(fontSize: 13)))], onChanged: (v){})), 
      _tableCell(TextFormField(initialValue: "1", textAlign: TextAlign.center, decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 8)))), 
      _tableCell(TextFormField(initialValue: "1", textAlign: TextAlign.center, decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 8)))), 
      _tableCell(TextFormField(initialValue: "1", textAlign: TextAlign.center, decoration: InputDecoration(border: const OutlineInputBorder(), isDense: true, contentPadding: const EdgeInsets.symmetric(vertical: 8), fillColor: Colors.grey.shade100, filled: true), readOnly: true)), 
      _tableCell(TextFormField(initialValue: "10", textAlign: TextAlign.center, decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 8)))), 
      _tableCell(TextFormField(initialValue: "₹10.00", textAlign: TextAlign.center, decoration: InputDecoration(border: const OutlineInputBorder(), isDense: true, contentPadding: const EdgeInsets.symmetric(vertical: 8), fillColor: Colors.grey.shade100, filled: true), readOnly: true)), 
      _tableCell(Row(children: [DropdownButton<String>(value: "SGST", underline: const SizedBox(), items: const [DropdownMenuItem(value: "SGST", child: Text("SGST", style: TextStyle(fontSize: 12)))], onChanged: (v){}), const SizedBox(width: 5), SizedBox(width: 40, child: TextFormField(initialValue: "2.5", textAlign: TextAlign.center, decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 8)))), const Text(" % ", style: TextStyle(fontSize: 12, color: Colors.grey)), const Text("CGST", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(width: 5), SizedBox(width: 40, child: TextFormField(initialValue: "2.5", textAlign: TextAlign.center, decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 8)))), const Text(" % ", style: TextStyle(fontSize: 12, color: Colors.grey))])), 
      _tableCell(TextFormField(initialValue: "₹0.50", textAlign: TextAlign.center, decoration: InputDecoration(border: const OutlineInputBorder(), isDense: true, contentPadding: const EdgeInsets.symmetric(vertical: 8), fillColor: Colors.grey.shade100, filled: true), readOnly: true)), 
      _tableCell(const Text("₹10.50", style: TextStyle(fontWeight: FontWeight.bold))),
      _tableCell(IconButton(icon: Icon(Icons.delete_outline, color: Colors.red.shade300, size: 20), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints(),))
    ]),],),),
  );
  Widget _tableHeader(String text) => Padding(padding: const EdgeInsets.all(12.0), child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)));
  Widget _tableCell(Widget child) => Padding(padding: const EdgeInsets.all(10.0), child: child);
  
  Widget _buildSummaryRowCustom(String title, Widget valueWidget, {bool isBold = false, bool isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: isLarge ? 15 : 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: Colors.black87)),
          valueWidget,
        ],
      ),
    );
  }
}

class PurchaseHistoryDataTable extends StatefulWidget {
  final VoidCallback onCreateNew;
  final VoidCallback onEdit;
  const PurchaseHistoryDataTable({super.key, required this.onCreateNew, required this.onEdit});

  @override
  State<PurchaseHistoryDataTable> createState() => _PurchaseHistoryDataTableState();
}

class _PurchaseHistoryDataTableState extends State<PurchaseHistoryDataTable> {
  late _PurchaseHistoryDataSource _dataSource;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    _dataSource = _PurchaseHistoryDataSource(
      onEdit: widget.onEdit,
      onReverse: () => _showReverseDialog(context),
      onView: () {}
    );
  }

  void _showReverseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: Container(
            width: 700,
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Reverse Purchase: 2", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero, constraints: const BoxConstraints(),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("Vendor: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text("Testvendors", style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text("Date: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text("15 May, 2026", style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text("Reversal Reason", style: TextStyle(fontSize: 13, color: Colors.black87)),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300)), isDense: true),
                        hint: const Text("Select Reason", style: TextStyle(fontSize: 14)),
                        items: const [], onChanged: (val) {}
                      ),
                      const SizedBox(height: 15),
                      const Text("Additional Notes", style: TextStyle(fontSize: 13, color: Colors.black87)),
                      const SizedBox(height: 5),
                      TextFormField(
                        maxLines: 2,
                        decoration: InputDecoration(hintText: "Explain the reason for reversal...", hintStyle: const TextStyle(fontSize: 14), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300)), isDense: true),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(width: 3, height: 16, color: Colors.red),
                          const SizedBox(width: 8),
                          const Text("Select Items to Reverse", style: TextStyle(fontSize: 13, color: Colors.black54)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Table(
                        columnWidths: const { 0: FlexColumnWidth(2), 1: FlexColumnWidth(1), 2: FlexColumnWidth(1), 3: FlexColumnWidth(1.2), 4: FlexColumnWidth(1) },
                        children: [
                          TableRow(children: [ _reverseHeader("MATERIAL"), _reverseHeader("PURCHASED", alignRight: true), _reverseHeader("PRICE", alignRight: true), _reverseHeader("REVERSE QTY", alignRight: true), _reverseHeader("CREDIT AMT", alignRight: true) ]),
                          TableRow(
                            children: [
                              _reverseCell("test"), _reverseCell("1.00", alignRight: true), _reverseCell("₹10.00", alignRight: true), 
                              Padding(
                                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10),
                                child: TextFormField(
                                  initialValue: "0", textAlign: TextAlign.center,
                                  decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.symmetric(vertical: 6), border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey.shade300))),
                                ),
                              ), 
                              _reverseCell("₹0.00", alignRight: true),
                            ]
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                        decoration: BoxDecoration(color: Colors.grey.shade100, border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total Reversal Amount:", style: TextStyle(fontSize: 13, color: Colors.black87)),
                            Text("₹0.00", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red.shade400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Financial Impact Preview:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(height: 15),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Reversal Total:", style: TextStyle(fontSize: 13, color: Colors.black87)), Text("₹0.00", style: TextStyle(fontSize: 13, color: Colors.grey.shade700))]),
                            const SizedBox(height: 8),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Offset Outstanding Balance:", style: TextStyle(fontSize: 13, color: Colors.black87)), Text("-₹0.00", style: TextStyle(fontSize: 13, color: Colors.green.shade600))]),
                            const Divider(height: 20),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Net Vendor Credit:", style: TextStyle(fontSize: 13, color: Colors.black87)), Text("+₹0.00", style: TextStyle(fontSize: 13, color: Colors.blue.shade600))]),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade600, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE35D6A), foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                        child: const Text("Confirm Reversal"),
                      ),
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

  Widget _reverseHeader(String text, {bool alignRight = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8), child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black54), textAlign: alignRight ? TextAlign.right : TextAlign.left));
  Widget _reverseCell(String text, {bool alignRight = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8), child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87), textAlign: alignRight ? TextAlign.right : TextAlign.left));
  Widget _buildHistoryFilterField(String label, String hint, {bool hasIcon = false}) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)), const SizedBox(height: 5), TextFormField(initialValue: hint, decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(10), suffixIcon: hasIcon ? const Icon(Icons.calendar_today_outlined, size: 16) : null, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300))),), ],),);
  Widget _buildHistoryFilterDropdown(String label, String value) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)), const SizedBox(height: 5), DropdownButtonFormField<String>(value: value, isDense: true, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300))), items: [DropdownMenuItem(value: value, child: Text(value, style: const TextStyle(fontSize: 14)))], onChanged: (newValue) {},), ],),);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(child: Text("Purchase History", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              Wrap( spacing: 10, runSpacing: 10,
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.file_download_outlined, size: 16),
                    label: const Text("Export to Excel"),
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.green.shade700, side: BorderSide(color: Colors.green.shade700), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text("Create New Purchase"),
                    onPressed: widget.onCreateNew,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          Wrap(
            spacing: 20, runSpacing: 20,
            children: [
              _buildHistoryFilterField("From Date", "30-04-2026", hasIcon: true),
              _buildHistoryFilterField("To Date", "30-05-2026", hasIcon: true),
              _buildHistoryFilterDropdown("Filter by Vendor", "All Vendors"),
              _buildHistoryFilterDropdown("Filter by Product", "All Products"),
            ],
          ),
          const SizedBox(height: 25),
          
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Theme(
              data: Theme.of(context).copyWith(
                cardColor: Colors.white, dividerColor: Colors.transparent, cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero, color: Colors.white),
              ),
              child: PaginatedDataTable(
                columns: const [
                  DataColumn(label: Text('S.No', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))), 
                  DataColumn(label: Text('Invoice No.', style: TextStyle(fontWeight: FontWeight.bold))), 
                  DataColumn(label: Text('Vendor', style: TextStyle(fontWeight: FontWeight.bold))), 
                  DataColumn(label: Text('Material(s)', style: TextStyle(fontWeight: FontWeight.bold))), 
                  DataColumn(label: Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold))), 
                  DataColumn(label: Text('Images', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Balance', style: TextStyle(fontWeight: FontWeight.bold))),
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

class _PurchaseHistoryDataSource extends DataTableSource {
  final VoidCallback onEdit;
  final VoidCallback onReverse;
  final VoidCallback onView;

  _PurchaseHistoryDataSource({required this.onEdit, required this.onReverse, required this.onView});

  final List<PurchaseEntryData> _entries = [
    PurchaseEntryData('5/15/2026', '2', 'Testvendors', 'test (1.00 Kg)', '₹10.50', '—', '₹10.50', 'Unpaid'), 
  ];
  
  @override
  DataRow? getRow(int index) {
    if (index >= _entries.length) return null;
    final entry = _entries[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(entry.date)), 
      DataCell(Text(entry.invoiceNo)), 
      DataCell(Text(entry.vendor)), 
      DataCell(Text(entry.materials)), 
      DataCell(Text(entry.totalAmount, style: const TextStyle(fontWeight: FontWeight.bold))), 
      DataCell(Text(entry.images, style: const TextStyle(color: Colors.grey))), 
      DataCell(Text(entry.balance, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red))), 
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: const Color(0xFFDC3545), borderRadius: BorderRadius.circular(4)),
        child: Text(entry.status, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      )), 
      DataCell(Row(children: [
        InkWell(
          onTap: onEdit,
          child: Container(margin: const EdgeInsets.only(right: 6), padding: const EdgeInsets.all(4), decoration: BoxDecoration(border: Border.all(color: Colors.blue.shade200), borderRadius: BorderRadius.circular(4)), child: Icon(Icons.edit_outlined, color: Colors.blue.shade600, size: 16)),
        ),
        InkWell(
          onTap: onReverse,
          child: Container(margin: const EdgeInsets.only(right: 6), padding: const EdgeInsets.all(4), decoration: BoxDecoration(border: Border.all(color: Colors.red.shade200), borderRadius: BorderRadius.circular(4)), child: Icon(Icons.refresh_outlined, color: Colors.red.shade600, size: 16)),
        ),
        InkWell(
          onTap: onView,
          child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(border: Border.all(color: Colors.cyan.shade200), borderRadius: BorderRadius.circular(4)), child: Icon(Icons.visibility_outlined, color: Colors.cyan.shade600, size: 16)),
        )
      ]))
    ]);
  }

  @override bool get isRowCountApproximate => false;
  @override int get rowCount => _entries.length;
  @override int get selectedRowCount => 0;
}