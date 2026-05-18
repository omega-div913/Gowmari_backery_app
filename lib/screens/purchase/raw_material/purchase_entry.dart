import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/components/app_sidebar.dart';
import 'subsidebar.dart';

class RawMaterialPurchaseEntryPage extends StatefulWidget {
  const RawMaterialPurchaseEntryPage({super.key});

  @override
  State<RawMaterialPurchaseEntryPage> createState() =>
      _RawMaterialPurchaseEntryPageState();
}

class _RawMaterialPurchaseEntryPageState
    extends State<RawMaterialPurchaseEntryPage> {
  // --- STATE ---
  bool _isFormView = false; // Toggle between List View and Form View
  bool _isEditMode = false; // Toggle between New Purchase and Edit Purchase
  bool _isInclusiveGST = false; // Toggle for GST button group
  
  // List to hold active form items rows
  List<Map<String, dynamic>> _formItems = [];

  // --- DUMMY ITEM TEMPLATES ---
  final Map<String, dynamic> _emptyItemTemplate = {
    "material": "Select...", "unit": "N/A", "prevPrice": "-", "price": "0", "qty": "0", "subTotal": "0.00", "total": "₹0.00"
  };
  
  final Map<String, dynamic> _editItemTemplate = {
    "material": "Kattai Pai", "unit": "pcs", "prevPrice": "₹27.14", "price": "27.14", "qty": "2772", "subTotal": "75232.08", "total": "₹75,232.08"
  };

  // --- PAGINATION & DUMMY DATA ---
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  final List<Map<String, dynamic>> _purchaseData =
      List.generate(25, (index) => {
            "date": "18-05-2026",
            "invoiceNo": "${28 + index}",
            "vendor": "DSP Bags",
            "material": "Kattai Pai (2772.00 pcs)",
            "batch": "RB260518-01",
            "total": "₹75,232.08",
            "balance": "Bal: ₹75,232.08",
            "images": "---",
            "status": "Unpaid"
          });

  List<Map<String, dynamic>> get paginatedData {
    int start = (_currentPage - 1) * _itemsPerPage;
    int end = start + _itemsPerPage;
    return _purchaseData.sublist(
        start, end > _purchaseData.length ? _purchaseData.length : end);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile
          ? const Drawer(child: AppSidebar(activeMenu: "Raw Material"))
          : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text("Purchase Entry",
                  style: TextStyle(color: Colors.black, fontSize: 16)))
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const AppSidebar(activeMenu: "Raw Material"),
          Expanded(
            child: Column(
              children: [
                // TOP NAV BAR
                if (!isMobile)
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(color: Color(0xFFE0E0E0)))),
                    child: Row(
                      children: [
                        const Icon(Icons.menu, color: Colors.grey, size: 20),
                        const SizedBox(width: 15),
                        const Text("Home / Purchase Section / Raw Material",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 13)),
                        const Spacer(),
                        Container(
                          width: 300,
                          height: 35,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF4F7FE),
                              borderRadius: BorderRadius.circular(20)),
                          child: const TextField(
                              decoration: InputDecoration(
                                  hintText: "Search menus ( Press / )",
                                  hintStyle: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                  prefixIcon: Icon(Icons.search,
                                      size: 18, color: Colors.grey),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10))),
                        ),
                        const SizedBox(width: 20),
                        Container(
                            width: 35,
                            height: 35,
                            decoration: const BoxDecoration(
                                color: Colors.blue, shape: BoxShape.circle),
                            child: const Center(
                                child: Text("R",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)))),
                        const SizedBox(width: 10),
                        const Text("RTS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        const Icon(Icons.arrow_drop_down, color: Colors.black)
                      ],
                    ),
                  ),

                // MAIN BODY WITH SUB-SIDEBAR
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (screenWidth > 850)
                        const SizedBox(
                            width: 260,
                            child: RawMaterialSubSidebar(
                                activePage: 'Purchase Entry')),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(25),
                            child: _isFormView
                                ? _buildNewPurchaseForm()
                                : _buildListView(),
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
  // LIST VIEW (Grid Page)
  // ==========================================
  Widget _buildListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Purchase RATE ENTRY",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.table_chart_outlined, size: 16),
                  label: const Text("Export to Excel"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF198754),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12)),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isFormView = true;
                      _isEditMode = false;
                      _isInclusiveGST = false;
                      _formItems = [Map.from(_emptyItemTemplate)]; // 1 empty row
                    });
                  },
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text("Create New Purchase"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0056B3),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12)),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 25),

        // Filter Section
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: _buildFilterInput("From Date", "18-05-2026",
                          isDate: true)),
                  const SizedBox(width: 20),
                  Expanded(
                      child: _buildFilterInput("To Date", "18-05-2026",
                          isDate: true)),
                  const SizedBox(width: 20),
                  Expanded(
                      child: _buildFilterInput(
                          "Search by Vendor", "Type or select a vendor...")),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: _buildFilterInput("Search by Material",
                          "Type or select a material...")),
                  const SizedBox(width: 20),
                  Expanded(
                      flex: 1,
                      child: _buildFilterInput(
                          "Search by Invoice", "Enter invoice no...")),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),

        // Data Grid Section
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(builder: (context, constraints) {
                double minTableWidth = 1100;
                double tableWidth = constraints.maxWidth < minTableWidth
                    ? minTableWidth
                    : constraints.maxWidth;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: tableWidth,
                    child: Column(
                      children: [
                        // Grid Header 
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey.shade300))),
                          child: const Row(
                            children: [
                              Expanded(flex: 1, child: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                              Expanded(flex: 2, child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                              Expanded(flex: 2, child: Text("Invoice No.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                              Expanded(flex: 3, child: Text("Vendor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                              Expanded(flex: 4, child: Text("Material(s)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                              Expanded(flex: 3, child: Text("Batch", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                              Expanded(flex: 2, child: Text("Total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.right)),
                              Expanded(flex: 2, child: Text("Images", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center)),
                              Expanded(flex: 2, child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center)),
                              Expanded(flex: 4, child: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.right)),
                            ],
                          ),
                        ),
                        // Grid Rows
                        ...paginatedData.asMap().entries.map((entry) {
                          int sNo = ((_currentPage - 1) * _itemsPerPage) +
                              entry.key +
                              1;
                          var data = entry.value;

                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Text("$sNo", style: const TextStyle(fontSize: 13))),
                                Expanded(flex: 2, child: Text(data["date"], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold))),
                                Expanded(flex: 2, child: Text(data["invoiceNo"], style: const TextStyle(fontSize: 13))),
                                Expanded(flex: 3, child: Text(data["vendor"], style: const TextStyle(fontSize: 13))),
                                Expanded(flex: 4, child: Text(data["material"], style: const TextStyle(fontSize: 13))),
                                Expanded(flex: 3, child: Text(data["batch"], style: const TextStyle(fontSize: 13))),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(data["total"], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                        Text(data["balance"], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                                      ],
                                    )),
                                Expanded(flex: 2, child: Center(child: Text(data["images"], style: const TextStyle(fontSize: 13, color: Colors.grey)))),
                                Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(color: const Color(0xFFDC3545), borderRadius: BorderRadius.circular(4)),
                                        child: Text(data["status"], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                      ),
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Edit Button (Switches to Edit Form Mode)
                                        _actionIconBtn(Icons.edit_outlined, const Color(0xFF0D6EFD), onTap: () {
                                          setState(() {
                                            _isFormView = true;
                                            _isEditMode = true; // Activating Edit mode
                                            _isInclusiveGST = false;
                                            _formItems = [Map.from(_editItemTemplate)]; // Fill with Dummy edit data
                                          });
                                        }),
                                        const SizedBox(width: 4),
                                        _actionIconBtn(Icons.delete_outline, const Color(0xFFDC3545)),
                                        const SizedBox(width: 4),
                                        _actionIconBtn(Icons.refresh, const Color(0xFF0DCAF0)),
                                        const SizedBox(width: 4),
                                        _actionIconBtn(Icons.description_outlined, const Color(0xFF6C757D)),
                                        const SizedBox(width: 4),
                                        _actionIconBtn(Icons.print_outlined, const Color(0xFF6C757D)),
                                      ],
                                    )),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                );
              }),
              _buildPagination(),
            ],
          ),
        )
      ],
    );
  }

  // ==========================================
  // FORM VIEW (New / Edit Purchase Entry)
  // ==========================================
  Widget _buildNewPurchaseForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Form Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_isEditMode ? "Edit Purchase" : "New Purchase Entry",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _isFormView = false; // Go back to List View
                });
              },
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text("Back to List"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  side: BorderSide(color: Colors.grey.shade300),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12)),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Section 1: Invoice Details
        _buildSectionCard(
          title: "Invoice Details",
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: _buildFormInput("Vendor", _isEditMode ? "DSP Bags" : "Select a vendor...",
                          isDropdown: true)),
                  if (!_isEditMode) ...[
                    const SizedBox(width: 15),
                    Expanded(
                        child: _buildFormInput(
                            "Link Purchase Order", "Manual Entry",
                            isDropdown: true)),
                  ],
                  const SizedBox(width: 15),
                  Expanded(
                      child: _buildFormInput(
                          "Invoice Number", _isEditMode ? "28" : "Enter or generate...",
                          suffixIcon: Icons.settings,
                          suffixColor: Colors.blue)),
                  const SizedBox(width: 15),
                  Expanded(
                      child: _buildFormInput("Purchase Date", "18-05-2026",
                          suffixIcon: Icons.calendar_today,
                          suffixColor: Colors.black54)),
                  if (_isEditMode) ...[
                    const SizedBox(width: 15),
                    Expanded(
                        child: _buildFormInput("Batch Code", "RB260518-01",
                            isFilled: true,
                            suffixIcon: Icons.refresh,
                            suffixColor: Colors.black54)),
                  ],
                ],
              ),
              if (!_isEditMode) ...[
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: _buildFormInput("Batch Code", "RB260518-09",
                            isFilled: true,
                            suffixIcon: Icons.refresh,
                            suffixColor: Colors.black54)),
                    const Expanded(flex: 3, child: SizedBox()), // Empty space
                  ],
                )
              ]
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Section 2: Purchase Items
        _buildSectionCard(
          title: "Purchase Items",
          headerTrailing: Row(
            children: [
              // Interactive GST Toggle
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => setState(() => _isInclusiveGST = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        color: !_isInclusiveGST ? Colors.blue : Colors.transparent,
                        child: Text("Exclusive GST",
                            style: TextStyle(fontSize: 12, color: !_isInclusiveGST ? Colors.white : Colors.blue)),
                      ),
                    ),
                    InkWell(
                      onTap: () => setState(() => _isInclusiveGST = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        color: _isInclusiveGST ? Colors.blue : Colors.transparent,
                        child: Text("Inclusive GST",
                            style: TextStyle(fontSize: 12, color: _isInclusiveGST ? Colors.white : Colors.blue)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              // Add Item Button Logic
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _formItems.add(Map.from(_emptyItemTemplate)); // Append new row
                  });
                },
                icon: const Icon(Icons.add_circle_outline, size: 16),
                label: const Text("Add Item (Alt+N)"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0056B3),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12)),
              ),
            ],
          ),
          child: Column(
            children: [
              // Table Header
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200))),
                child: Row(
                  children: [
                    _th("Raw Material", flex: 3),
                    _th("Expiry Date", flex: 2),
                    _th("Unit", flex: 1),
                    _th("Prev. Price", flex: 1, align: TextAlign.center),
                    _th("Price/Unit", flex: 1),
                    _th("Qty", flex: 1),
                    _th("Sub Total", flex: 1),
                    _th("Tax Type", flex: 2),
                    _th("SGST %/Amt", flex: 1, align: TextAlign.center),
                    _th("CGST %/Amt", flex: 1, align: TextAlign.center),
                    _th("Item Total", flex: 1, align: TextAlign.center),
                    const SizedBox(width: 30), // space for delete btn
                  ],
                ),
              ),
              const SizedBox(height: 10),
              
              // Dynamic Table Rows matching _formItems
              ..._formItems.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> item = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _gridInput(item["material"] ?? "Select...", isDropdown: !_isEditMode)),
                      const SizedBox(width: 8),
                      Expanded(
                          flex: 2,
                          child: _gridInput("dd-mm-yyyy",
                              suffixIcon: Icons.calendar_today)),
                      const SizedBox(width: 8),
                      Expanded(
                          flex: 1,
                          child: _gridInput(item["unit"] ?? "N/A", isFilled: true, isCenter: true)),
                      const SizedBox(width: 8),
                      Expanded(
                          flex: 1,
                          child: Center(
                              child: Text(item["prevPrice"] ?? "-",
                                  style: TextStyle(color: item["prevPrice"] != "-" ? Colors.blue : Colors.grey.shade600, fontSize: 12)))),
                      const SizedBox(width: 8),
                      Expanded(flex: 1, child: _gridInput(item["price"] ?? "0", isCenter: true)),
                      const SizedBox(width: 8),
                      Expanded(flex: 1, child: _gridInput(item["qty"] ?? "0", isCenter: true)),
                      const SizedBox(width: 8),
                      Expanded(
                          flex: 1,
                          child: _gridInput(item["subTotal"] ?? "0.00",
                              isCenter: true,
                              isBold: true,
                              borderColor: Colors.grey.shade300)),
                      const SizedBox(width: 8),
                      Expanded(
                          flex: 2,
                          child: _gridInput("SGST + CGST", isDropdown: true)),
                      const SizedBox(width: 8),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              _gridInput("0", suffixText: "%"),
                              const SizedBox(height: 4),
                              _gridInput("0", isCenter: true)
                            ],
                          )),
                      const SizedBox(width: 8),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              _gridInput("0", suffixText: "%"),
                              const SizedBox(height: 4),
                              _gridInput("0", isCenter: true)
                            ],
                          )),
                      const SizedBox(width: 8),
                      Expanded(
                          flex: 1,
                          child: _gridInput(item["total"] ?? "₹0.00",
                              isFilled: true, isCenter: true, isBold: true)),
                      const SizedBox(width: 8),
                      
                      // Delete Row Button
                      InkWell(
                        onTap: () {
                          setState(() {
                            _formItems.removeAt(index);
                          });
                        },
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red.shade300),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Icon(Icons.delete_outline,
                              color: Colors.red, size: 18),
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Section 3: Bottom Split (Payment, Images, Summary)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT SIDE (Payment & Images)
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  _buildSectionCard(
                    title: "Initial Payment",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: _buildFormInput("Paid Amount", "0",
                                    prefixText: "₹")),
                            const SizedBox(width: 15),
                            Expanded(
                                child: _buildFormInput(
                                    "Payment Method", "Select...",
                                    isDropdown: true)),
                          ],
                        ),
                        const SizedBox(height: 15),
                        _buildFormInput("Payment Notes",
                            "Optional: Cheque number, transaction ID, etc."),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    title: "Image Attachments",
                    titleIcon: Icons.camera_alt_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Purchase Images",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade400,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_circle_outline,
                                        color: Colors.grey),
                                    SizedBox(height: 5),
                                    Text("Add Images",
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                            "ⓘ Images are stored on the server only when the purchase is saved.",
                            style: TextStyle(fontSize: 11, color: Colors.grey)),
                        const Text(
                            "ⓘ Attachments are saved only when you click \"Save\" or \"Update\".",
                            style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 20),

            // RIGHT SIDE (Summary)
            Expanded(
              flex: 4,
              child: _buildSectionCard(
                title: "Invoice Summary",
                child: Column(
                  children: [
                    _summaryRow("Sub Total", _isEditMode ? "₹75,232.08" : "₹0.00"),
                    const Divider(),
                    _summaryRow("Grand Total", _isEditMode ? "₹75,232.08" : "₹0.00", isBold: true),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          color: const Color(0xFFE9ECEF),
                          borderRadius: BorderRadius.circular(4)),
                      child: _summaryRow("Balance Due", _isEditMode ? "₹75,232.08" : "₹0.00", isBold: true),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),

        // Action Buttons (Footer)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isFormView = false;
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade500,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15)),
              child: const Text("Cancel"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0056B3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15)),
              child: Text(_isEditMode ? "Update Purchase (Ctrl+Enter)" : "Save Purchase (Ctrl+Enter)"),
            ),
          ],
        )
      ],
    );
  }

  // --- REUSABLE WIDGETS FOR FORM VIEW ---

  Widget _buildSectionCard(
      {required String title,
      required Widget child,
      Widget? headerTrailing,
      IconData? titleIcon}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade200))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (titleIcon != null) ...[
                      Icon(titleIcon, size: 18, color: Colors.blue),
                      const SizedBox(width: 8)
                    ],
                    Text(title,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
                if (headerTrailing != null) headerTrailing,
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(20), child: child),
        ],
      ),
    );
  }

  Widget _buildFormInput(String label, String hint,
      {bool isDropdown = false,
      IconData? suffixIcon,
      Color? suffixColor,
      bool isFilled = false,
      String? prefixText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87)),
        const SizedBox(height: 6),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              color: isFilled ? const Color(0xFFF8F9FA) : Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            children: [
              if (prefixText != null) ...[
                Text(prefixText,
                    style: const TextStyle(color: Colors.black54, fontSize: 13)),
                const SizedBox(width: 8),
              ],
              Expanded(
                  child: Text(hint,
                      style: TextStyle(
                          fontSize: 13,
                          color: isFilled ? Colors.black87 : Colors.grey))),
              if (isDropdown)
                const Icon(Icons.keyboard_arrow_down,
                    size: 16, color: Colors.black54),
              if (suffixIcon != null)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      border: Border.all(color: suffixColor!.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(4)),
                  child: Icon(suffixIcon, size: 12, color: suffixColor),
                )
            ],
          ),
        )
      ],
    );
  }

  Widget _th(String title,
      {required int flex, TextAlign align = TextAlign.left}) {
    return Expanded(
      flex: flex,
      child: Text(title,
          textAlign: align,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _gridInput(String hint,
      {bool isDropdown = false,
      IconData? suffixIcon,
      bool isFilled = false,
      bool isCenter = false,
      bool isBold = false,
      String? suffixText,
      Color? borderColor}) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: isFilled ? const Color(0xFFF8F9FA) : Colors.white,
          border: Border.all(color: borderColor ?? Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisAlignment: isCenter
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              hint,
              textAlign: isCenter ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                  fontSize: 12,
                  color: isFilled ? Colors.black87 : Colors.grey.shade600,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isDropdown)
            const Icon(Icons.keyboard_arrow_down,
                size: 14, color: Colors.black54),
          if (suffixIcon != null)
            Icon(suffixIcon, size: 14, color: Colors.black54),
          if (suffixText != null)
            Text(suffixText,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  // --- REUSABLE WIDGETS FOR LIST VIEW ---

  Widget _buildPagination() {
    int totalPages = (_purchaseData.length / _itemsPerPage).ceil();
    if (totalPages <= 1) return const SizedBox.shrink();

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

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 2,
                runSpacing: 8,
                children: pageButtons)));
  }

  Widget _pageBox(String t, bool active, VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: active ? Colors.blue : Colors.white,
                border: Border.all(
                    color: active ? Colors.blue : Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4)),
            child: Text(t,
                style: TextStyle(
                    color: active ? Colors.white : Colors.blue,
                    fontSize: 13,
                    fontWeight: FontWeight.bold))),
      );

  Widget _buildFilterInput(String label, String hint, {bool isDate = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87)),
        const SizedBox(height: 8),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hint,
                  style: TextStyle(
                      fontSize: 13,
                      color: isDate ? Colors.black87 : Colors.grey)),
              if (isDate)
                const Icon(Icons.calendar_today_outlined,
                    size: 16, color: Colors.black54),
            ],
          ),
        )
      ],
    );
  }

  // Updated to accept onTap interaction
  Widget _actionIconBtn(IconData icon, Color color, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(4)),
        child: Center(child: Icon(icon, size: 14, color: color)),
      ),
    );
  }
}