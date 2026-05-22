import 'package:flutter/material.dart';

// --- DUMMY MODEL FOR PURCHASE ENTRIES ---
class PurchaseRecord {
  final String date;
  final String invoiceNo;
  final String vendor;
  final String items;
  final String batch;
  final String grandTotal;
  final String status;

  PurchaseRecord(this.date, this.invoiceNo, this.vendor, this.items, this.batch, this.grandTotal, this.status);
}

class PurchaseEntry extends StatefulWidget {
  final bool startInCreateMode;
  final VoidCallback onResetCreateMode;

  const PurchaseEntry({Key? key, required this.startInCreateMode, required this.onResetCreateMode}) : super(key: key);

  @override
  State<PurchaseEntry> createState() => _PurchaseEntryState();
}

class _PurchaseEntryState extends State<PurchaseEntry> {
  List<PurchaseRecord> _allPurchases = [];
  bool _isLoading = true;
  
  final int _rowsPerPage = 8;
  int _currentPurchasePage = 0;

  bool _isCreatingPurchase = false;
  bool _isEditingPurchase = false;
  
  int _itemCount = 1; // Variable to control item row count

  @override
  void initState() {
    super.initState();
    _isCreatingPurchase = widget.startInCreateMode;
    _itemCount = 1;
    _fetchData();
  }

  @override
  void didUpdateWidget(covariant PurchaseEntry oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startInCreateMode && !oldWidget.startInCreateMode) {
      setState(() {
        _isCreatingPurchase = true;
        _isEditingPurchase = false;
        _itemCount = 1;
      });
      widget.onResetCreateMode();
    }
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    _allPurchases = [
      PurchaseRecord('13 May 2026', '2322', 'MURUGAN AGENCIES', '1 Items', 'bP260513-01', '₹5,219.99', 'unpaid'),
      PurchaseRecord('12 May 2026', '100', 'SRI MASANI AMMAN AGENCIES', '5 Items', 'bP260512-01', '₹26,700.60', 'unpaid'),
      PurchaseRecord('11 May 2026', '26001950', 'BEYONDEX COOLS', '7 Items', 'bP260511-02', '₹37,007.60', 'unpaid'),
      PurchaseRecord('11 May 2026', '', 'VAIRAM ENTERPRISES', '1 Items', 'bP260511-01', '₹2,640.00', 'unpaid'),
      PurchaseRecord('10 May 2026', '26001950', 'BEYONDEX COOLS', '8 Items', 'bP260511-02', '₹43,119.58', 'unpaid'),
      PurchaseRecord('06 May 2026', '860', 'VAIRAM ENTERPRISES', '3 Items', 'bP260506-02', '₹7,776.00', 'unpaid'),
      PurchaseRecord('06 May 2026', '2243', 'MURUGAN AGENCIES', '1 Items', 'bP260506-01', '₹5,220.00', 'unpaid'),
      ...List.generate(20, (index) => PurchaseRecord('01 May 2026', '001${index}', 'SM ENTERPRISES', '5 Items', 'bP260505-01', '₹51,683.44', 'unpaid')),
    ];
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_isCreatingPurchase) {
      return Column(
        children: [
          _buildCreatePurchaseHeader(),
          const SizedBox(height: 20),
          _buildCreatePurchaseForm(),
        ],
      );
    }

    return Column(
      children: [
        _buildPurchaseHeader(),
        const SizedBox(height: 20),
        _buildPurchaseFilters(),
        const SizedBox(height: 20),
        _buildPurchaseWebView(),
      ],
    );
  }

  // =========================================================================
  // VIEW: LIST
  // =========================================================================
  Widget _buildPurchaseHeader() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween, 
      crossAxisAlignment: WrapCrossAlignment.center, 
      spacing: 20, 
      runSpacing: 15, 
      children: [
        const Text('Bakery Product Purchase', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)), 
        Row(
          mainAxisSize: MainAxisSize.min, 
          children: [
            OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.description_outlined, size: 16, color: Color(0xFF10B981)), label: const Text('Export Excel', style: TextStyle(color: Color(0xFF10B981))), style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF10B981)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))), 
            const SizedBox(width: 15), 
            ElevatedButton.icon(onPressed: () => setState(() { _isCreatingPurchase = true; _isEditingPurchase = false; _itemCount = 1; }), icon: const Icon(Icons.add, size: 18), label: const Text('Create New Purchase'), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B59F8), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0))
          ]
        )
      ]
    );
  }

  Widget _buildPurchaseFilters() {
    return Container(
      padding: const EdgeInsets.all(20), 
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), 
      child: Row(
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('From Date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(height: 8), _buildFilterInput('01-05-2026', Icons.calendar_today_outlined)])), 
          const SizedBox(width: 20), 
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('To Date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(height: 8), _buildFilterInput('14-05-2026', Icons.calendar_today_outlined)])), 
          const SizedBox(width: 20), 
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Vendor', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(height: 8), _buildFilterInput('Search vendor...', null)]))
        ]
      )
    );
  }

  Widget _buildFilterInput(String hint, IconData? icon) { return Container(height: 40, decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)), child: TextField(decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(fontSize: 13), suffixIcon: icon != null ? Icon(icon, size: 16, color: Colors.grey) : null, border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12)))); }

  Widget _buildPurchaseWebView() {
    int start = _currentPurchasePage * _rowsPerPage;
    int end = start + _rowsPerPage;
    if (end > _allPurchases.length) end = _allPurchases.length;
    List<PurchaseRecord> pageItems = _allPurchases.isEmpty ? [] : _allPurchases.sublist(start, end);

    return _buildCustomTableCard(
      columns: const ['S.NO', 'Date', 'Invoice No.', 'Vendor', 'Items', 'Batch', 'Grand Total', 'Images', 'Status', 'Actions'],
      rows: pageItems.asMap().entries.map((entry) {
        int idx = entry.key; PurchaseRecord r = entry.value;
        return DataRow(cells: [
          DataCell(Text((start + idx + 1).toString(), style: const TextStyle(color: Colors.grey, fontSize: 13))),
          DataCell(Text(r.date, style: const TextStyle(fontSize: 12, color: Colors.black87))),
          DataCell(Text(r.invoiceNo, style: const TextStyle(fontSize: 12))),
          DataCell(Text(r.vendor, style: const TextStyle(fontSize: 12, color: Colors.black87))),
          DataCell(Text(r.items, style: const TextStyle(fontSize: 12))),
          DataCell(Text(r.batch, style: const TextStyle(fontSize: 12))),
          DataCell(Text(r.grandTotal, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
          const DataCell(Text('—', style: TextStyle(color: Colors.grey))),
          DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFDC2626), borderRadius: BorderRadius.circular(4)), child: Text(r.status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)))),
          DataCell(Row(mainAxisSize: MainAxisSize.min, children: [
            _smallIconBtn(Icons.edit_outlined, Colors.blue, () => setState(() { _isCreatingPurchase = true; _isEditingPurchase = true; _itemCount = 1; })), 
            const SizedBox(width: 4),
            _smallIconBtn(Icons.delete_outline, Colors.red, () => _showDeletePurchaseDialog(context)), 
            const SizedBox(width: 4),
            _smallIconBtn(Icons.print_outlined, Colors.grey.shade700, () => _showPrintOptionsDialog(context)), 
          ])),
        ]);
      }).toList(),
      currentPage: _currentPurchasePage,
      totalItems: _allPurchases.length,
      onPageChanged: (newPage) => setState(() => _currentPurchasePage = newPage),
    );
  }

  // =========================================================================
  // VIEW: CREATE / EDIT FORM
  // =========================================================================
  Widget _buildCreatePurchaseHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        Text(_isEditingPurchase ? 'Edit Purchase' : 'New Purchase Entry', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)), 
        OutlinedButton.icon(onPressed: () => setState(() => _isCreatingPurchase = false), icon: const Icon(Icons.chevron_left, size: 16, color: Colors.grey), label: const Text('Back to List', style: TextStyle(color: Colors.grey)), style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))))
      ]
    );
  }

  Widget _buildCreatePurchaseForm() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormSectionHeader('Invoice Details'), 
            const SizedBox(height: 15),
            Row(children: [Expanded(child: _buildFormInput('Vendor *', _isEditingPurchase ? 'MURUGAN AGENCIES' : 'Select a vendor...')), const SizedBox(width: 15), Expanded(child: _buildFormInput('Invoice Number', _isEditingPurchase ? '2322' : 'Enter or generate...', suffixIcon: Icons.settings, suffixColor: Colors.blue)), const SizedBox(width: 15), Expanded(child: _buildFormInput('Purchase Date *', _isEditingPurchase ? '12-05-2026' : '14-05-2026', suffixIcon: Icons.calendar_today_outlined)), const SizedBox(width: 15), Expanded(child: _buildFormInput('Batch Code', _isEditingPurchase ? 'bP260513-01' : 'BP260514-01', suffixIcon: Icons.refresh))]), 
            const Divider(height: 40, color: Color(0xFFF1F5F9)),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
                _buildFormSectionHeader('Purchase Items'), 
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _itemCount++; // Add item logic
                    });
                  }, 
                  icon: const Icon(Icons.add, size: 14), 
                  label: const Text('Add Item (Alt+N)', style: TextStyle(fontSize: 12)), 
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B59F8), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)))
                )
              ]
            ), 
            const SizedBox(height: 15),
            
            ...List.generate(_itemCount, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(children: [
                  Expanded(flex: 3, child: _buildFormInput(index == 0 ? 'Bakery Product *' : '', _isEditingPurchase && index == 0 ? 'Kinley Water' : 'Select product...')), 
                  const SizedBox(width: 8), 
                  Expanded(flex: 2, child: _buildFormInput(index == 0 ? 'Expiry Date' : '', 'dd-mm-yyyy', suffixIcon: Icons.calendar_today_outlined)), 
                  const SizedBox(width: 8), 
                  Expanded(flex: 1, child: _buildFormTextCol(index == 0 ? 'Unit' : '', _isEditingPurchase && index == 0 ? 'pcs' : '-')), 
                  const SizedBox(width: 8), 
                  Expanded(flex: 1, child: _buildFormTextCol(index == 0 ? 'Prev. Price' : '', '₹0.00')), 
                  const SizedBox(width: 8), 
                  Expanded(flex: 1, child: _buildFormInput(index == 0 ? 'Purchasing Price *' : '', _isEditingPurchase && index == 0 ? '11.6' : '0')), 
                  const SizedBox(width: 8), 
                  Expanded(flex: 1, child: _buildFormInput(index == 0 ? 'Selling Price' : '', _isEditingPurchase && index == 0 ? '20' : '0')), 
                  const SizedBox(width: 8), 
                  Expanded(flex: 1, child: _buildFormInput(index == 0 ? 'Qty *' : '', _isEditingPurchase && index == 0 ? '449.999' : '1')), 
                  const SizedBox(width: 8), 
                  Expanded(flex: 1, child: _buildFormTextCol(
                    index == 0 ? 'Item Total' : '', 
                    _isEditingPurchase && index == 0 ? '₹5,219.99' : '₹0.00', 
                    icon: Icons.delete_outline, 
                    iconColor: Colors.red,
                    onIconTap: () {
                      if (_itemCount > 1) {
                        setState(() {
                          _itemCount--;
                        });
                      }
                    }
                  ))
                ]),
              );
            }), 
            const Divider(height: 30, color: Color(0xFFF1F5F9)),
            
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildFormSectionHeader('Initial Payment'), const SizedBox(height: 15), Row(children: [Expanded(child: _buildFormInput('Paid Amount', '0', prefixText: '₹ ')), const SizedBox(width: 15), Expanded(child: _buildFormInput('Payment Method', 'Select...', suffixIcon: Icons.keyboard_arrow_down))]), const SizedBox(height: 15), _buildFormInput('Payment Notes', 'Optional: Cheque number, transaction ID, etc.', maxLines: 2)])), 
                const SizedBox(width: 30), 
                Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildFormSectionHeader('Invoice Summary'), const SizedBox(height: 15), Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFFF8FAFC), border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(8)), child: Column(children: [_buildSummaryRow('Sub Total', _isEditingPurchase ? '₹5,219.99' : '₹0.00', isBold: true), const Divider(height: 20, color: Colors.black12), _buildSummaryRow('Grand Total', _isEditingPurchase ? '₹5,219.99' : '₹0.00', isBold: true, valueColor: const Color(0xFF1B59F8)), const Divider(height: 20, color: Colors.black12), _buildSummaryRow('Paid Amount', '- ₹0.00'), const Divider(height: 20, color: Colors.black12), _buildSummaryRow('Balance Due', _isEditingPurchase ? '₹5,219.99' : '₹0.00', isBold: true, valueColor: Colors.red)]))]))
              ]
            ), 
            const Divider(height: 40, color: Color(0xFFF1F5F9)),
            
            Row(children: [const Icon(Icons.camera_alt_outlined, color: Color(0xFF1B59F8), size: 18), const SizedBox(width: 8), _buildFormSectionHeader('Image Attachments')]), 
            const SizedBox(height: 15), 
            const Text('Purchase Images', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)), 
            const SizedBox(height: 10), 
            Container(width: 120, height: 120, decoration: BoxDecoration(color: const Color(0xFFF8FAFC), border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid), borderRadius: BorderRadius.circular(8)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade400)), child: Icon(Icons.add, color: Colors.grey.shade500, size: 20)), const SizedBox(height: 8), Text('Add Images', style: TextStyle(fontSize: 11, color: Colors.grey.shade600))])), 
            const SizedBox(height: 10), 
            Text('ⓘ Images are stored on the server only when the purchase is saved.', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)), 
            Text('ⓘ Attachments are saved only when you click "Save" or "Update".', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
            
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end, 
              children: [
                ElevatedButton(onPressed: () => setState(() => _isCreatingPurchase = false), style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade600, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), child: const Text('Cancel')), 
                const SizedBox(width: 10), 
                ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B59F8), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), child: const Text('Save Purchase (Ctrl+S)'))
              ]
            )
          ],
        ),
      ),
    );
  }

  // --- UI Helpers ---
  Widget _smallIconBtn(IconData icon, Color color, VoidCallback onTap) { return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(4), child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Icon(icon, size: 14, color: color))); }
  Widget _buildFormSectionHeader(String title) { return Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1B59F8))); }
  
  Widget _buildFormInput(String label, String hint, {IconData? suffixIcon, Color? suffixColor, String? prefixText, int maxLines = 1}) { 
    List<TextSpan> labelSpans = []; 
    if (label.isNotEmpty) {
      if (label.contains('*')) { 
        labelSpans.add(TextSpan(text: label.replaceAll('*', ''), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87))); 
        labelSpans.add(const TextSpan(text: '*', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.red))); 
      } else { 
        labelSpans.add(TextSpan(text: label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87))); 
      } 
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        if (label.isNotEmpty) ...[
          RichText(maxLines: 1, overflow: TextOverflow.ellipsis, text: TextSpan(children: labelSpans)), 
          const SizedBox(height: 6), 
        ],
        SizedBox(
          height: maxLines == 1 ? 38 : null, 
          child: TextField(
            controller: TextEditingController(text: hint != 'Select a vendor...' && hint != 'Enter or generate...' && hint != 'Select product...' && hint != 'dd-mm-yyyy' && hint != 'Select...' && hint != 'Optional: Cheque number, transaction ID, etc.' ? hint : ''), 
            maxLines: maxLines, 
            style: const TextStyle(fontSize: 13), 
            decoration: InputDecoration(
              hintText: hint, 
              hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400), 
              prefixText: prefixText, 
              prefixStyle: const TextStyle(fontSize: 13, color: Colors.black87), 
              suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 16, color: suffixColor ?? Colors.grey) : null, 
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), 
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)), 
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)), 
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF1B59F8)))
            )
          )
        )
      ]
    ); 
  }
  
  Widget _buildFormTextCol(String label, String value, {IconData? icon, Color? iconColor, VoidCallback? onIconTap}) { 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [
        if (label.isNotEmpty) ...[
          Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)), 
          const SizedBox(height: 6), 
        ],
        SizedBox(
          height: 38,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Flexible(child: Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))), 
              if (icon != null) ...[
                const SizedBox(width: 4), 
                InkWell(onTap: onIconTap, child: Icon(icon, size: 16, color: iconColor))
              ]
            ]
          )
        )
      ]
    ); 
  }
  
  Widget _buildSummaryRow(String label, String value, {bool isBold = false, Color? valueColor}) { return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: TextStyle(fontSize: 13, fontWeight: isBold ? FontWeight.bold : FontWeight.w500, color: Colors.black87)), Text(value, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.w500, color: valueColor ?? Colors.black87))]); }

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
  void _showDeletePurchaseDialog(BuildContext context) { showDialog(context: context, builder: (BuildContext context) { return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), backgroundColor: Colors.white, child: Container(width: 350, padding: const EdgeInsets.all(30), child: Column(mainAxisSize: MainAxisSize.min, children: [Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.orange, width: 2)), child: const Icon(Icons.priority_high, color: Colors.orange, size: 40)), const SizedBox(height: 20), const Text('Are you sure?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 10), const Text('This will reverse the stock addition for all items in this purchase!', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 13)), const SizedBox(height: 30), Row(mainAxisAlignment: MainAxisAlignment.center, children: [ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), child: const Text('Yes, delete it!')), const SizedBox(width: 10), ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B59F8), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), child: const Text('Cancel'))])]))); }); }

  void _showPrintOptionsDialog(BuildContext context) { String selectedFormat = 'Normal (A4)'; bool printAllCategories = true; bool printBakery = true; showDialog(context: context, builder: (BuildContext context) { return StatefulBuilder(builder: (context, setDialogState) { return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), backgroundColor: Colors.white, child: Container(width: 400, padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.print_outlined, size: 20, color: Colors.black87), const SizedBox(width: 8), const Text('Print Options', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))]), IconButton(icon: const Icon(Icons.close, size: 18), onPressed: () => Navigator.pop(context), padding: EdgeInsets.zero, constraints: const BoxConstraints())]), const SizedBox(height: 20), const Text('Select Format:', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)), Row(children: [Radio<String>(value: 'Normal (A4)', groupValue: selectedFormat, activeColor: const Color(0xFF1B59F8), onChanged: (val) => setDialogState(() => selectedFormat = val!)), const Text('Normal (A4)', style: TextStyle(fontSize: 13)), const SizedBox(width: 20), Radio<String>(value: 'Thermal (80mm)', groupValue: selectedFormat, activeColor: const Color(0xFF1B59F8), onChanged: (val) => setDialogState(() => selectedFormat = val!)), const Text('Thermal (80mm)', style: TextStyle(fontSize: 13))]), const SizedBox(height: 15), const Text('Select Categories:', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)), CheckboxListTile(title: const Text('All Categories', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), value: printAllCategories, activeColor: const Color(0xFF1B59F8), controlAffinity: ListTileControlAffinity.leading, contentPadding: EdgeInsets.zero, visualDensity: const VisualDensity(horizontal: -4, vertical: -4), onChanged: (val) => setDialogState(() { printAllCategories = val!; printBakery = val; })), CheckboxListTile(title: const Text('BAKERY', style: TextStyle(fontSize: 13)), value: printBakery, activeColor: const Color(0xFF1B59F8), controlAffinity: ListTileControlAffinity.leading, contentPadding: EdgeInsets.zero, visualDensity: const VisualDensity(horizontal: -4, vertical: -4), onChanged: (val) => setDialogState(() { printBakery = val!; if(!val) printAllCategories = false; })), const SizedBox(height: 25), Row(mainAxisAlignment: MainAxisAlignment.end, children: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Colors.black87))), const SizedBox(width: 10), ElevatedButton.icon(onPressed: () { Navigator.pop(context); _showPrintPreviewScreen(context); }, icon: const Icon(Icons.print, size: 16), label: const Text('Print'), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B59F8), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))))])]))); }); }); }

  void _showPrintPreviewScreen(BuildContext context) { showDialog(context: context, useSafeArea: false, builder: (BuildContext context) { return Scaffold(backgroundColor: const Color(0xFFF1F3F4), body: Row(children: [Expanded(child: Center(child: SingleChildScrollView(child: Container(margin: const EdgeInsets.symmetric(vertical: 40), width: 700, height: 990, decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5))]), child: Padding(padding: const EdgeInsets.all(40.0), child: Column(children: [const Text('SRI GOWMARIAMMAN F.P.L', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)), const SizedBox(height: 8), const Text('PURCHASE ENTRY', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)), const SizedBox(height: 30), Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(border: Border.all(color: Colors.black)), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('VENDOR:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), Text('MURUGAN AGENCIES', style: TextStyle(fontSize: 12)), Text('10, Forest Road, Vaigundaswamy Mills, Sivaji Nagar, Theni - 625531', style: TextStyle(fontSize: 11)), Text('8610058797', style: TextStyle(fontSize: 11))])), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [_printRowText('Bill No: ', '2322'), _printRowText('Date: ', '13 May 2026'), _printRowText('Time: ', '04:31 PM')]))])), const SizedBox(height: 15), Container(width: double.infinity, padding: const EdgeInsets.all(8), decoration: BoxDecoration(border: Border.all(color: Colors.black)), child: const Text('MATERIAL TYPE: BAKERY', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))), const SizedBox(height: 15), Table(border: TableBorder.all(color: Colors.black), columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(4), 2: FlexColumnWidth(1.5), 3: FlexColumnWidth(1.5), 4: FlexColumnWidth(2)}, children: [_buildPrintTableRow(['Sl.No', 'Material Name', 'Qty', 'Rate', 'Amount'], isHeader: true), _buildPrintTableRow(['1', 'Kinley Water', '450.00', '11.60', '5219.99']), TableRow(children: [const Padding(padding: EdgeInsets.all(8.0), child: Text('')), const Padding(padding: EdgeInsets.all(8.0), child: Text('Type Total:', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))), const Padding(padding: EdgeInsets.all(8.0), child: Text('450.00', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))), const Padding(padding: EdgeInsets.all(8.0), child: Text('')), const Padding(padding: EdgeInsets.all(8.0), child: Text('5219.99', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)))])]), const SizedBox(height: 15), Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2)), child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('GRAND TOTAL QUANTITY: 450.00', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)), Text('GRAND TOTAL: ₹ 5,219.99', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))])), const Spacer(), const Text('This is a computer generated receipt.', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.grey))])))))), Container(width: 320, color: Colors.white, padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Print', style: TextStyle(fontSize: 22, color: Colors.black87)), Text('1 page', style: TextStyle(fontSize: 13, color: Colors.grey))]), const SizedBox(height: 30), _buildPrintSettingDropdown('Destination', 'Save as PDF', Icons.picture_as_pdf), const SizedBox(height: 20), _buildPrintSettingDropdown('Pages', 'All', null), const SizedBox(height: 20), _buildPrintSettingDropdown('Layout', 'Portrait', null), const SizedBox(height: 20), const Divider(color: Colors.grey), const SizedBox(height: 10), const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('More settings', style: TextStyle(fontSize: 14, color: Colors.black87)), Icon(Icons.keyboard_arrow_down, color: Colors.grey)]), const Spacer(), Row(mainAxisAlignment: MainAxisAlignment.end, children: [ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B59F8), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))), child: const Text('Save')), const SizedBox(width: 10), OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF1B59F8), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), side: const BorderSide(color: Colors.grey)), child: const Text('Cancel'))])]))])); }); }

  Widget _printRowText(String label, String value) { return Row(mainAxisSize: MainAxisSize.min, children: [Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text(value, style: const TextStyle(fontSize: 11))]); }
  TableRow _buildPrintTableRow(List<String> cells, {bool isHeader = false}) { return TableRow(children: cells.map((cell) => Padding(padding: const EdgeInsets.all(8.0), child: Text(cell, textAlign: cell == 'Material Name' || cell == 'Sl.No' ? TextAlign.left : TextAlign.right, style: TextStyle(fontSize: 12, fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)))).toList()); }
  Widget _buildPrintSettingDropdown(String label, String value, IconData? icon) { return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(fontSize: 13, color: Colors.black87)), Container(width: 180, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [if(icon != null) ...[Icon(icon, size: 16, color: Colors.grey.shade600), const SizedBox(width: 8)], Text(value, style: const TextStyle(fontSize: 13))]), const Icon(Icons.arrow_drop_down, color: Colors.grey)]))]); }
}