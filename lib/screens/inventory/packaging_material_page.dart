import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/dashboard/dashboard_screen.dart'; // Import to use AppSidebar

// --- ENUMS & DATA MODELS ---
enum OperationTab { purchaseEntry, purchaseOrder, invoiceManagement }

class PurchaseOrderData {
  final String orderDate, requestDate, vendor, materials, status;
  PurchaseOrderData(this.orderDate, this.requestDate, this.vendor, this.materials, this.status);
}

class InvoiceData {
  final String invoiceNo, vendor, purchaseDate, invoiceTotal;
  InvoiceData(this.invoiceNo, this.vendor, this.purchaseDate, this.invoiceTotal);
}

class PackagingMaterialPage extends StatefulWidget {
  const PackagingMaterialPage({super.key});

  @override
  State<PackagingMaterialPage> createState() => _PackagingMaterialPageState();
}

class _PackagingMaterialPageState extends State<PackagingMaterialPage> {
  // --- STATE VARIABLES ---
  OperationTab _activeTab = OperationTab.purchaseEntry;
  bool _isCreatingNew = false;
  bool _isEditingOrder = false; // Added for Edit Mode

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;

    // Dynamic Title
    String getTitle() {
      if (_activeTab == OperationTab.purchaseEntry) {
        return _isCreatingNew ? "New Purchase Entry" : "Packaging Material";
      } else if (_activeTab == OperationTab.purchaseOrder) {
        if (_isEditingOrder) return "Edit Purchase Order";
        return _isCreatingNew ? "New Purchase Order" : "Packaging Orders";
      }
      return "Packaging Invoice Management";
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: AppSidebar()) : null,
      appBar: isMobile ? AppBar(
        backgroundColor: Colors.white, elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(getTitle(), style: const TextStyle(color: Colors.black, fontSize: 16)),)
          : null,
      body: Row(
        children: [
          if (!isMobile) const SizedBox(width: 300, child: AppSidebar()),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) _buildTopBar(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isMobile) _buildInternalSidebar(),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: _buildMainContent(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- CONTENT SWITCHER ---
  Widget _buildMainContent() {
    if (_activeTab == OperationTab.purchaseEntry) {
      return _isCreatingNew
          ? SingleChildScrollView(key: const ValueKey('pe_form'), child: _buildNewPurchaseForm())
          : _buildPurchaseHistoryList();
    } else if (_activeTab == OperationTab.purchaseOrder) {
      if (_isCreatingNew) return _buildOrderForm(isEdit: false);
      if (_isEditingOrder) return _buildOrderForm(isEdit: true);
      return _buildPurchaseOrderList();
    } else {
      return _buildInvoiceManagementList(); 
    }
  }

  Widget _buildTopBar() {
    String breadcrumb = "Home / Purchase Section / Packaging Material";
    if (_activeTab == OperationTab.purchaseOrder) {
      breadcrumb = "Home / Packaging Material / Packaging Orders";
    } else if (_activeTab == OperationTab.invoiceManagement) {
      breadcrumb = "Home / Packaging Material / Packaging Invoices";
    }

    return Container(
      height: 70, color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey),
          const SizedBox(width: 15),
          Text(breadcrumb, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const Spacer(),
          Container( width: 300, height: 38,
            decoration: BoxDecoration( color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
            child: const TextField(
                decoration: InputDecoration( hintText: "Search menus...",
                    prefixIcon: Icon(Icons.search, size: 20),
                    border: InputBorder.none)),
          ),
          const SizedBox(width: 20),
          const CircleAvatar( radius: 18, backgroundColor: Colors.blue,
              child: Text("RTS", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildInternalSidebar() {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text("Packaging Material", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text("OPERATIONS", style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          _buildOperationItem("Purchase Entry", 
            isActive: _activeTab == OperationTab.purchaseEntry,
            onTap: () => setState(() { _activeTab = OperationTab.purchaseEntry; _isCreatingNew = false; _isEditingOrder = false; })
          ),
          _buildOperationItem("Purchase Order", 
            isActive: _activeTab == OperationTab.purchaseOrder,
            onTap: () => setState(() { _activeTab = OperationTab.purchaseOrder; _isCreatingNew = false; _isEditingOrder = false; })
          ),
          _buildOperationItem("Invoice Management", 
            isActive: _activeTab == OperationTab.invoiceManagement,
            onTap: () => setState(() { _activeTab = OperationTab.invoiceManagement; _isCreatingNew = false; _isEditingOrder = false; })
          ),
        ],
      ),
    );
  }

  Widget _buildOperationItem(String title, {bool isActive = false, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF0D47A1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? Colors.white : Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // EXISTING PURCHASE ENTRY CODE
  // =========================================================================

  Widget _buildPurchaseHistoryList() {
    return Container(
      key: const ValueKey('history'),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
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
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.green.shade700,
                        side: BorderSide(color: Colors.green.shade700),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text("Create New Purchase"),
                    onPressed: () => setState(() => _isCreatingNew = true),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              dividerThickness: 1,
              headingRowColor: MaterialStateProperty.all(Colors.transparent),
              headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
              columns: const [
                DataColumn(label: Text('Date')), DataColumn(label: Text('Invoice No.')),
                DataColumn(label: Text('Vendor')), DataColumn(label: Text('Material(s)')),
                DataColumn(label: Text('Total Amount')), DataColumn(label: Text('Images')),
                DataColumn(label: Text('Balance')), DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: const [],
            ),
          ),
          const Center(
            child: Padding(padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Text("No records found.", style: TextStyle(color: Colors.grey))),
          )
        ],
      ),
    );
  }

  Widget _buildNewPurchaseForm() {
    return Container(
      key: const ValueKey('pe_form'),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("New Purchase Entry", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              OutlinedButton.icon(
                icon: const Icon(Icons.arrow_back, size: 16),
                label: const Text("Back to List"),
                onPressed: () => setState(() => _isCreatingNew = false),
                style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
              ),
            ],
          ),
          const Divider(height: 30),
          _buildSectionTitle("Invoice Details"),
          Wrap(
            spacing: 20, runSpacing: 20,
            children: [
              _buildFormDropdown("Vendor", "Select a vendor"),
              _buildFormDropdown("Link Purchase Order", "Manual Entry"),
              _buildFormTextField("Invoice Number", "No."),
              _buildFormTextField("Purchase Date", "15-05-2026", hasIcon: true),
              _buildFormTextField("Batch Code", ""),
            ],
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Purchase Items"),
          _buildItemsTable(),
          const SizedBox(height: 10),
          Align( alignment: Alignment.centerRight,
            child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add, size: 16),
              label: const Text("Add Item"), style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Initial Payment"),
                    _buildFormTextField("Paid Amount", "₹ 0"),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Expanded(flex: 1, child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Invoice Summary"),
                    _buildSummaryRow("Sub Total", "₹0.00"),
                    _buildSummaryRow("Total (Before Round Off)", "₹0.00"),
                    _buildSummaryRow("Round Off", "0"),
                    _buildSummaryRow("Grand Total", "₹0.00", isBold: true),
                    _buildSummaryRow("Paid Amount", "-₹0.00"),
                    const Divider(height: 15),
                    Container(
                      color: Colors.grey.shade200, padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: _buildSummaryRow("Balance Due", "₹0.00", isBold: true, isLarge: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Image Attachments"),
          const Text("Purchase Images"),
          const SizedBox(height: 10),
          Container(
            height: 120, width: 120,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
            child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.add_circle_outline, color: Colors.grey), SizedBox(height: 8), Text("Add Images", style: TextStyle(color: Colors.grey)),
              ],),
          ),
          const SizedBox(height: 10),
          const Text("Images are stored on the server only when the purchase is saved.", style: TextStyle(fontSize: 12, color: Colors.grey)),
          const Text("Attachments are saved only when you click 'Save' or 'Update'.", style: TextStyle(fontSize: 12, color: Colors.grey)),
          const Divider(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              OutlinedButton(onPressed: () {}, child: const Text("Cancel")), const SizedBox(width: 10),
              ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white,),
                child: const Text("Save Purchase"),)
            ],)
        ],
      ),
    );
  }

  // =========================================================================
  // EXISTING PURCHASE ORDER COMPONENTS 
  // =========================================================================

  Widget _buildPurchaseOrderList() {
    return Container(
      key: const ValueKey('po_list'),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(25),
      child: PurchaseOrderDataTable(
        onCreateNew: () => setState(() { _isCreatingNew = true; _isEditingOrder = false; }),
        onEdit: () => setState(() { _isEditingOrder = true; _isCreatingNew = false; }),
      ),
    );
  }

  Widget _buildOrderForm({required bool isEdit}) {
    return SingleChildScrollView(
      key: ValueKey(isEdit ? 'po_edit_form' : 'po_create_form'),
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
                  onPressed: () => setState(() { _isCreatingNew = false; _isEditingOrder = false; }),
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
                OutlinedButton(onPressed: () => setState(() { _isCreatingNew = false; _isEditingOrder = false; }), child: const Text("Cancel")), const SizedBox(width: 10),
                ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white), child: Text(isEdit ? "Update Order" : "Save Order"))
              ],
            )
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // UPDATED INVOICE MANAGEMENT COMPONENTS
  // =========================================================================

  Widget _buildInvoiceManagementList() {
    return Container(
      key: const ValueKey('invoice_list'),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: const InvoiceManagementDataTable(), 
    );
  }

  // --- HELPER WIDGETS ---
  Widget _buildSectionTitle(String title) => Padding(padding: const EdgeInsets.only(bottom: 15.0), child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),);
  Widget _buildHistoryFilterField(String label, String hint, {bool hasIcon = false}) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)), const SizedBox(height: 5), TextFormField(initialValue: hint, decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(10), suffixIcon: hasIcon ? const Icon(Icons.calendar_today_outlined, size: 16) : null, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300))),), ],),);
  Widget _buildHistoryFilterDropdown(String label, String value) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)), const SizedBox(height: 5), DropdownButtonFormField<String>(value: value, isDense: true, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300))), items: [DropdownMenuItem(value: value, child: Text(value))], onChanged: (newValue) {},), ],),);
  Widget _buildFormTextField(String label, String hint, {bool hasIcon = false}) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 5), TextFormField(initialValue: hint, decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(12), suffixIcon: hasIcon ? const Icon(Icons.calendar_today_outlined, size: 16) : null, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400))),), ]));
  Widget _buildFormDropdown(String label, String hint, {bool isStatus = false}) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 5), DropdownButtonFormField<String>(value: isStatus ? hint : null, hint: !isStatus ? Text(hint) : null, isDense: true, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400))), items: [DropdownMenuItem(value: hint, child: Text(hint))], onChanged: (value) {},), ]));
  Widget _buildItemsTable() => SingleChildScrollView(scrollDirection: Axis.horizontal, child: Table(border: TableBorder.all(color: Colors.grey.shade300), columnWidths: const { 0: IntrinsicColumnWidth(), 1: IntrinsicColumnWidth(), 2: IntrinsicColumnWidth(), 3: IntrinsicColumnWidth(), 4: IntrinsicColumnWidth(), 5: IntrinsicColumnWidth(), 6: IntrinsicColumnWidth(), 7: IntrinsicColumnWidth(), }, children: [TableRow(decoration: BoxDecoration(color: Colors.grey.shade100), children: [ _tableHeader("Raw Material"), _tableHeader("Qty (Kg)"), _tableHeader("Unit/Kg"), _tableHeader("Sub Total"), _tableHeader("Price/Unit"), _tableHeader("GST Type & %"), _tableHeader("GST Amount"), _tableHeader("Item Total"), ]), TableRow(children: [_tableCell(const Text("Select...")), _tableCell(const Text("1")), _tableCell(const Text("1")), _tableCell(const Text("0")), _tableCell(const Text("₹0.00")), _tableCell(const Text("SGST 2.5% CGST 2.5%")), _tableCell(const Text("% 0.00")), _tableCell(const Text("₹0.00", style: const TextStyle(fontWeight: FontWeight.bold))),]),],),);
  Widget _tableHeader(String text) => Padding(padding: const EdgeInsets.all(10.0), child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)));
  Widget _tableCell(Widget child) => Padding(padding: const EdgeInsets.all(10.0), child: child);
  Widget _buildSummaryRow(String title, String value, {bool isBold = false, bool isLarge = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: TextStyle(fontSize: isLarge ? 15 : 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: Colors.grey.shade800)), Text(value, style: TextStyle(fontSize: isLarge ? 15 : 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: Colors.grey.shade800)),],),);
}


// =========================================================================
// DATA TABLE & DATA SOURCE CLASSES FOR INVOICE MANAGEMENT
// =========================================================================

class InvoiceManagementDataTable extends StatefulWidget {
  const InvoiceManagementDataTable({super.key});

  @override
  State<InvoiceManagementDataTable> createState() => _InvoiceManagementDataTableState();
}

class _InvoiceManagementDataTableState extends State<InvoiceManagementDataTable> {
  late _InvoiceDataSource _dataSource;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    _dataSource = _InvoiceDataSource(
      onView: () => _showInvoiceDialog(context) 
    );
  }

  // --- INVOICE DOCUMENT POPUP ---
  void _showInvoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: Container(
            width: 800, 
            height: 700,
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                // Top Action Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Invoice Document", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Row(
                        children: [
                          // PRINT BUTTON FIX FOR WINDOWS DESKTOP
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Print action triggered. (Note: Chrome print dialog only works when running Flutter for Web. For Windows Native, additional packages like 'printing' are needed)"),
                                  duration: Duration(seconds: 4),
                                )
                              );
                            },
                            icon: const Icon(Icons.print, size: 16),
                            label: const Text("Print Invoice"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D6EFD), // Bootstrap blue
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12)
                            ),
                          ),
                          const SizedBox(width: 15),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.grey),
                            onPressed: () => Navigator.of(context).pop(),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                // Invoice Paper Layout
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(40),
                    child: _buildInvoicePaperLayout(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInvoicePaperLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(child: Text("INVOICE", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, fontFamily: 'Times New Roman'))),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("HEAD OFFICE:", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                SizedBox(height: 5),
                Text("SRI GOWMARIAMMAN F.P.L", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Address Not Set", style: TextStyle(fontSize: 13)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: const [SizedBox(width: 80, child: Text("INV. NO.", style: TextStyle(fontWeight: FontWeight.bold))), Text(": 3496")]),
                const SizedBox(height: 5),
                Row(children: const [SizedBox(width: 80, child: Text("DATE.", style: TextStyle(fontWeight: FontWeight.bold))), Text(": 15-05-2026")]),
                const SizedBox(height: 5),
                Row(children: const [SizedBox(width: 80, child: Text("BATCH.", style: TextStyle(fontWeight: FontWeight.bold))), Text(": RB260515-03")]),
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black, width: 1.5))),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("To:", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Padding(padding: EdgeInsets.only(left: 20), child: Text("VISWA FOODS (NB)", style: TextStyle(fontWeight: FontWeight.bold)))
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _gridHeaderCell("Sl\nNo", 1), _gridHeaderCell("Description", 5), _gridHeaderCell("QTY", 1), _gridHeaderCell("RATE", 1.5), _gridHeaderCell("Tax\n%", 1), _gridHeaderCell("Amount", 2, isLast: true),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _gridCell("1", 1, alignCenter: true), _gridCell("IC BP Butter Scotch 5 Lit.", 5), _gridCell("1 nos", 1, alignCenter: true), _gridCell("610.42", 1.5, alignRight: true), _gridCell("5%", 1, alignCenter: true), _gridCell("640.94", 2, alignRight: true, isLast: true, bold: true),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _gridCell("", 1, height: 100), _gridCell("", 5), _gridCell("", 1), _gridCell("", 1.5), _gridCell("", 1), _gridCell("", 2, isLast: true),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 95, 
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black), right: BorderSide(color: Colors.black))),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("BANK Details.", style: TextStyle(decoration: TextDecoration.underline, fontSize: 13)),
                            SizedBox(height: 2),
                            Text("STATE BANK OF INDIA.", style: TextStyle(fontSize: 13)),
                            Text("A/C NO 36367396645", style: TextStyle(fontSize: 13)),
                            Text("IFSC CODE SBIN0004059", style: TextStyle(fontSize: 13)),
                            Text("RAJAPALAYAM", style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 20, 
                      child: Column(
                        children: [
                          _totalsRow("Sub\nTotal", "610.42", isTop: true),
                          _totalsRow("CGST", "15.26"),
                          _totalsRow("SGST", "15.26"),
                          _totalsRow("Total", "640.94", isLast: true, bold: true),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 50),
        const Align(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("For SRI GOWMARIAMMAN F.P.L", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              SizedBox(height: 40),
              Text("Authorized Signatory", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
        )
      ],
    );
  }

  Widget _gridHeaderCell(String text, double flex, {bool isLast = false}) {
    return Expanded(flex: (flex * 10).toInt(), child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(border: Border(bottom: const BorderSide(color: Colors.black), right: isLast ? BorderSide.none : const BorderSide(color: Colors.black))), alignment: Alignment.center, child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center)));
  }
  Widget _gridCell(String text, double flex, {bool isLast = false, bool bold = false, bool alignCenter = false, bool alignRight = false, double? height}) {
    return Expanded(flex: (flex * 10).toInt(), child: Container(height: height, padding: const EdgeInsets.all(6), decoration: BoxDecoration(border: Border(right: isLast ? BorderSide.none : const BorderSide(color: Colors.black))), alignment: alignCenter ? Alignment.center : (alignRight ? Alignment.centerRight : Alignment.centerLeft), child: Text(text, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: 13))));
  }
  Widget _totalsRow(String label, String value, {bool isTop = false, bool isLast = false, bool bold = false}) {
    return Container(decoration: BoxDecoration(border: Border(top: isTop ? const BorderSide(color: Colors.black) : BorderSide.none, bottom: isLast ? BorderSide.none : const BorderSide(color: Colors.black))), child: IntrinsicHeight(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Expanded(flex: 1, child: Container(padding: const EdgeInsets.all(4), alignment: Alignment.center, decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.black))), child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center))), Expanded(flex: 2, child: Container(padding: const EdgeInsets.all(4), alignment: Alignment.centerRight, child: Text(value, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: 13), textAlign: TextAlign.right)))])));
  }

  Widget _buildInvoiceFilterField(String label, String hint, {bool hasIcon = false}) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)), const SizedBox(height: 5), TextFormField(initialValue: hint, decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(12), suffixIcon: hasIcon ? const Icon(Icons.calendar_today_outlined, size: 16) : null, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300))),), ],),);
  Widget _buildInvoiceFilterDropdown(String label, String value) => SizedBox(width: 250, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)), const SizedBox(height: 5), DropdownButtonFormField<String>(value: value, isDense: true, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300))), items: [DropdownMenuItem(value: value, child: Text(value))], onChanged: (newValue) {},), ],),);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Packaging Invoice Management", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
            child: Wrap(
              spacing: 20, runSpacing: 15, crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                _buildInvoiceFilterDropdown("Vendor", "All Vendors"),
                _buildInvoiceFilterField("From Date", "30-04-2026", hasIcon: true),
                _buildInvoiceFilterField("To Date", "30-05-2026", hasIcon: true),
                SizedBox(
                  height: 38, width: 120,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    child: const Text("Reset", style: TextStyle(fontSize: 15)),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 25),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
            child: PaginatedDataTable(
              columns: const [
                DataColumn(label: Text('S.No', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Invoice No', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Vendor', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Purchase Date', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Invoice Total', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('View', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              source: _dataSource,
              rowsPerPage: _rowsPerPage,
              showCheckboxColumn: false,
              onRowsPerPageChanged: (int? value) => setState(() => _rowsPerPage = value!),
            ),
          )
        ],
      ),
    );
  }
}

class _InvoiceDataSource extends DataTableSource {
  final VoidCallback onView;
  _InvoiceDataSource({required this.onView});

  final List<InvoiceData> _invoices = [
    InvoiceData('2', 'Testvendors', '15 May, 2026', '₹10.50'),
    InvoiceData('3', 'Vendor A', '16 May, 2026', '₹20.00'),
    InvoiceData('4', 'Vendor B', '17 May, 2026', '₹35.00'),
    InvoiceData('5', 'Vendor C', '18 May, 2026', '₹40.50'),
    InvoiceData('6', 'Vendor D', '19 May, 2026', '₹15.20'),
  ];
  
  @override
  DataRow? getRow(int index) {
    if (index >= _invoices.length) return null;
    final inv = _invoices[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(inv.invoiceNo)),
      DataCell(Text(inv.vendor)),
      DataCell(Text(inv.purchaseDate)),
      DataCell(Text(inv.invoiceTotal)),
      DataCell(
        IconButton(
          icon: const Icon(Icons.arrow_circle_right_outlined, color: Colors.blue, size: 28),
          onPressed: onView, 
        )
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _invoices.length;
  @override
  int get selectedRowCount => 0;
}

// =========================================================================
// DATA TABLE & DATA SOURCE CLASSES FOR PURCHASE ORDERS
// =========================================================================

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

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _orders.length;
  @override
  int get selectedRowCount => 0;
}