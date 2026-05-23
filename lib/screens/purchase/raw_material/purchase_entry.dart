import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/components/app_sidebar.dart'; 
import 'subsidebar.dart'; 

class RawMaterialPurchaseEntryPage extends StatefulWidget {
  const RawMaterialPurchaseEntryPage({super.key});
  @override
  State<RawMaterialPurchaseEntryPage> createState() => _RawMaterialPurchaseEntryPageState();
}

class _RawMaterialPurchaseEntryPageState extends State<RawMaterialPurchaseEntryPage> {
  bool _isFormView = false, _isEditMode = false, _isInclusiveGST = false;
  List<Map<String, dynamic>> _formItems = [];
  final Map<String, dynamic> _emptyItemTemplate = {"material": "Select...", "unit": "N/A", "prevPrice": "-", "price": "0", "qty": "0", "subTotal": "0.00", "total": "₹0.00"};
  final Map<String, dynamic> _editItemTemplate = {"material": "Kattai Pai", "unit": "pcs", "prevPrice": "₹27.14", "price": "27.14", "qty": "2772", "subTotal": "75232.08", "total": "₹75,232.08"};
  
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  String _vendorSearch = "", _materialSearch = "", _searchStr = "", _fromDate = "", _toDate = "";
  String? _selectedVendor;

  final List<String> _vendorList = [
    "All Vendors", "Sri Poovathal Polychem Industry", "MAXON SYNTHESIS", "GOWMARI & CO", "VPN AGENCY", "SRI BALAJI ENTERPRISE", "NARASUS COFFEE COMPANY"
  ];
  final List<String> _materialList = [
    "All Materials", "1 kg P.P Cover", "1 kg Birthday Cake Box", "1 kg Cake Bag", "1 kg Square Cake Bottom", "1 kg Sweet Box", "Gas Cylinder (2.00 nos)", "7- up Fizz (5.00 kg)", "Coffee Powder", "Chikkari"
  ];
  final List<String> _paymentMethods = ["Select...", "Cash", "GPay", "PhonePe", "Bank Transfer", "Cheque", "Other"];
  final List<String> _poLinks = ["Manual Entry", "PO-2026-001", "PO-2026-002"];

  final List<Map<String, dynamic>> _purchaseData = [
    {
      "date": "23-05-2026", "invoiceNo": "PINV-20260523-0001", "vendor": "NARASUS COFFEE COMPANY",
      "material": "Coffee Powder (40.00 kg), Chikkari (8.00 kg)", "batch": "RB260523-01",
      "total": "₹37,760.00", "balance": "Bal: ₹37,760.00", "images": "---", "status": "Unpaid"
    },
    ...List.generate(24, (index) => {
      "date": "18-05-2026", "invoiceNo": "${28 + index}", "vendor": "DSP Bags", "material": "Kattai Pai (2772.00 pcs)",
      "batch": "RB260518-01", "total": "₹75,232.08", "balance": "Bal: ₹75,232.08", "images": "---", "status": "Unpaid"
    })
  ];

  List<Map<String, dynamic>> get filteredData {
    return _purchaseData.where((item) {
      bool vMatch = item["vendor"].toLowerCase().contains(_vendorSearch.toLowerCase());
      bool mMatch = item["material"].toLowerCase().contains(_materialSearch.toLowerCase());
      bool sMatch = item["invoiceNo"].toLowerCase().contains(_searchStr.toLowerCase()) || item["vendor"].toLowerCase().contains(_searchStr.toLowerCase());
      bool fDateMatch = _fromDate.isEmpty || item["date"].contains(_fromDate);
      bool tDateMatch = _toDate.isEmpty || item["date"].contains(_toDate);
      return vMatch && mMatch && sMatch && fDateMatch && tDateMatch;
    }).toList();
  }

  List<Map<String, dynamic>> get paginatedData {
    List<Map<String, dynamic>> data = filteredData;
    int start = (_currentPage - 1) * _itemsPerPage, end = start + _itemsPerPage;
    if (start >= data.length) return [];
    return data.sublist(start, end > data.length ? data.length : end);
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1100;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: AppSidebar(activeMenu: "Raw Material")) : null,
      appBar: isMobile ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Purchase Entry", style: TextStyle(color: Colors.black, fontSize: 16))) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const AppSidebar(activeMenu: "Raw Material"),
          Expanded(child: Column(children: [
            if (!isMobile) Container(
              height: 60, padding: const EdgeInsets.symmetric(horizontal: 25), decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))),
              child: Row(children: [
                const Icon(Icons.menu, color: Colors.grey, size: 20), const SizedBox(width: 15),
                const Text("Home / Purchase Section / Raw Material", style: TextStyle(color: Colors.black54, fontSize: 13)), const Spacer(),
                Container(width: 300, height: 35, decoration: BoxDecoration(color: const Color(0xFFF4F7FE), borderRadius: BorderRadius.circular(20)), child: const TextField(decoration: InputDecoration(hintText: "Search menus ( Press / )", hintStyle: TextStyle(fontSize: 13, color: Colors.grey), prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 10)))),
                const SizedBox(width: 20), Container(width: 35, height: 35, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle), child: const Center(child: Text("R", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                const SizedBox(width: 10), const Text("RTS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), const Icon(Icons.arrow_drop_down, color: Colors.black)
              ]),
            ),
            Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (MediaQuery.of(context).size.width > 850 && !_isFormView) const SizedBox(width: 260, child: RawMaterialSubSidebar(activePage: 'Purchase Entry')),
              Expanded(child: ScrollConfiguration(behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false), child: SingleChildScrollView(padding: const EdgeInsets.all(25), child: _isFormView ? _buildNewPurchaseForm() : _buildListView()))),
            ]))
          ]))
        ]
      ),
    );
  }

  // --- MODALS ---
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 450, padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 4)), child: const Center(child: Text("!", style: TextStyle(color: Color(0xFFF8BB86), fontSize: 50, fontWeight: FontWeight.w300)))),
              const SizedBox(height: 25), const Text("Are you sure?", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: Color(0xFF545454))),
              const SizedBox(height: 15), const Text("Deleting this purchase will revert the stock quantities and\nremove the entry completely. You won't be able to revert\nthis!", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Color(0xFF545454))),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () => Navigator.pop(ctx), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC3545), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), child: const Text("Yes, delete it!", style: TextStyle(fontSize: 14))),
                  const SizedBox(width: 10),
                  ElevatedButton(onPressed: () => Navigator.pop(ctx), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))), child: const Text("Cancel", style: TextStyle(fontSize: 14))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showReverseDialog(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: SizedBox(
          width: 700,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Reverse Purchase: ${data['invoiceNo']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    InkWell(onTap: () => Navigator.pop(ctx), child: const Icon(Icons.close, size: 18, color: Colors.grey))
                  ]
                )
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(text: TextSpan(style: const TextStyle(fontSize: 13, color: Colors.black87), children: [const TextSpan(text: "Vendor: ", style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: "${data['vendor']}")])),
                      const SizedBox(height: 8),
                      RichText(text: TextSpan(style: const TextStyle(fontSize: 13, color: Colors.black87), children: [const TextSpan(text: "Date: ", style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: "${data['date']}")])),
                      const SizedBox(height: 15),
                      _buildFormInput("Reversal Reason", "Select Reason", isDropdown: true, isFilled: false),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Additional Notes", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87)), const SizedBox(height: 6),
                          TextFormField(maxLines: 2, decoration: InputDecoration(hintText: "Explain the reason for reversal...", hintStyle: const TextStyle(fontSize: 13, color: Colors.grey), contentPadding: const EdgeInsets.all(10), border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4))))
                        ]
                      ),
                      const SizedBox(height: 20),
                      Row(children: [Container(width: 3, height: 15, color: Colors.red), const SizedBox(width: 8), const Text("Select Items to Reverse", style: TextStyle(fontSize: 13, color: Colors.black87))]),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), decoration: BoxDecoration(color: const Color(0xFFF8F9FA), border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                              child: Row(children: [_th("MATERIAL", flex: 3), _th("PURCHASED", flex: 2, align: TextAlign.right), _th("PRICE", flex: 2, align: TextAlign.right), _th("REVERSE QTY", flex: 2, align: TextAlign.center), _th("CREDIT AMT", flex: 2, align: TextAlign.right)])
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                              child: Row(children: [const Expanded(flex: 3, child: Text("Coffee Powder", style: TextStyle(fontSize: 13))), const Expanded(flex: 2, child: Text("40.00", textAlign: TextAlign.right, style: TextStyle(fontSize: 13))), const Expanded(flex: 2, child: Text("₹900.00", textAlign: TextAlign.right, style: TextStyle(fontSize: 13))), Expanded(flex: 2, child: _gridInput("0", isCenter: true)), const Expanded(flex: 2, child: Text("₹0.00", textAlign: TextAlign.right, style: TextStyle(fontSize: 13)))])
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                              child: Row(children: [const Expanded(flex: 3, child: Text("Chikkari", style: TextStyle(fontSize: 13))), const Expanded(flex: 2, child: Text("8.00", textAlign: TextAlign.right, style: TextStyle(fontSize: 13))), const Expanded(flex: 2, child: Text("₹220.00", textAlign: TextAlign.right, style: TextStyle(fontSize: 13))), Expanded(flex: 2, child: _gridInput("0", isCenter: true)), const Expanded(flex: 2, child: Text("₹0.00", textAlign: TextAlign.right, style: TextStyle(fontSize: 13)))])
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), decoration: const BoxDecoration(color: Color(0xFFF8F9FA)),
                              child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Total Reversal Amount:", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Text("₹0.00", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.red))])
                            )
                          ]
                        )
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Financial Impact Preview:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), const SizedBox(height: 15),
                            _summaryRow("Reversal Total:", "₹0.00", fontSize: 13),
                            _summaryRow("Offset Outstanding Balance:", "-₹0.00", color: Colors.green, fontSize: 13),
                            const Divider(),
                            _summaryRow("Net Vendor Credit:", "+₹0.00", color: Colors.blue, fontSize: 13)
                          ]
                        )
                      )
                    ]
                  )
                )
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: () => Navigator.pop(ctx), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)), child: const Text("Cancel")), const SizedBox(width: 10),
                    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE4606D), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)), child: const Text("Confirm Reversal"))
                  ]
                )
              )
            ]
          )
        )
      ),
    );
  }

  void _showPrintDialog() {
    showDialog(context: context, builder: (ctx) {
      int format = 0; bool allMat = true, packMat = true;
      return StatefulBuilder(builder: (context, setState) => Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), child: Container(width: 400, child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.print_outlined, size: 18), const SizedBox(width: 8), const Text("Print Options", style: TextStyle(fontWeight: FontWeight.bold))]), InkWell(onTap: () => Navigator.pop(ctx), child: const Icon(Icons.close, size: 18, color: Colors.grey))])),
        Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Select Format:", style: TextStyle(fontSize: 13, color: Colors.black87)), const SizedBox(height: 10),
          Row(children: [Radio(value: 0, groupValue: format, onChanged: (v) => setState(() => format = v as int), activeColor: Colors.blue), const Text("Normal (A4)", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), const SizedBox(width: 20), Radio(value: 1, groupValue: format, onChanged: (v) => setState(() => format = v as int), activeColor: Colors.blue), const Text("Thermal (80mm)", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))]), const SizedBox(height: 20),
          const Text("Select Material Types:", style: TextStyle(fontSize: 13, color: Colors.black87)), const SizedBox(height: 10),
          Row(children: [Checkbox(value: allMat, onChanged: (v) => setState(() => allMat = v!), activeColor: Colors.blue), const Text("All Material Types", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))]),
          Row(children: [Checkbox(value: packMat, onChanged: (v) => setState(() => packMat = v!), activeColor: Colors.blue), const Text("PACKING MATERIAL", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold))])
        ])),
        Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel", style: TextStyle(color: Colors.black54))), const SizedBox(width: 10), ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.print, size: 16), label: const Text("Print"), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0056B3), foregroundColor: Colors.white))]))
      ]))));
    });
  }

  // --- LIST VIEW ---
  Widget _buildListView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text("Purchase RATE ENTRY", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87)),
        Row(children: [
          ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.table_chart_outlined, size: 16), label: const Text("Export to Excel"), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF198754), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12))), const SizedBox(width: 10),
          ElevatedButton.icon(onPressed: () => setState(() { _isFormView = true; _isEditMode = false; _isInclusiveGST = false; _formItems = [Map.from(_emptyItemTemplate)]; }), icon: const Icon(Icons.add, size: 16), label: const Text("Create New Purchase"), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0056B3), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12))),
        ])
      ]), const SizedBox(height: 25),
      
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: Column(children: [
        Row(children: [
          Expanded(child: _buildFilterInput("From Date", "23-05-2026", isDate: true, onChanged: (v) => setState((){ _fromDate = v; _currentPage = 1;}))), const SizedBox(width: 20), 
          Expanded(child: _buildFilterInput("To Date", "23-05-2026", isDate: true, onChanged: (v) => setState((){ _toDate = v; _currentPage = 1;}))), const SizedBox(width: 20), 
          Expanded(child: _buildFilterInput("Search by Vendor", "Type or select a vendor...", isDropdown: true, options: _vendorList, onChanged: (v) => setState((){ _vendorSearch = v; _currentPage = 1;})))
        ]), const SizedBox(height: 15),
        Row(children: [
          Expanded(flex: 2, child: Padding(padding: const EdgeInsets.only(right: 20), child: _buildFilterInput("Search by Material", "Type or select a material...", isDropdown: true, options: _materialList, onChanged: (v) => setState((){ _materialSearch = v; _currentPage = 1;})))), 
          Expanded(flex: 1, child: _buildFilterInput("Search by Invoice", "Enter invoice no...", onChanged: (v) => setState((){ _searchStr = v; _currentPage = 1;})))
        ])
      ])), const SizedBox(height: 25),
      
      Container(width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(scrollDirection: Axis.horizontal, child: SizedBox(width: constraints.maxWidth < 1100 ? 1100 : constraints.maxWidth, child: Column(children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(color: const Color(0xFFF8F9FA), border: Border(bottom: BorderSide(color: Colors.grey.shade300))), child: const Row(children: [Expanded(flex: 1, child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), Expanded(flex: 2, child: Text("Invoice No.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), Expanded(flex: 2, child: Text("Vendor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), Expanded(flex: 3, child: Text("Material(s)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), Expanded(flex: 2, child: Text("Batch", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))), Expanded(flex: 2, child: Text("Total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.right)), Expanded(flex: 1, child: Text("Images", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center)), Expanded(flex: 2, child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center)), Expanded(flex: 3, child: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.right))])),
            ...paginatedData.asMap().entries.map((entry) {
              var data = entry.value;
              return Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))), child: Row(children: [
                Expanded(flex: 1, child: Text(data["date"], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold))), Expanded(flex: 2, child: Text(data["invoiceNo"], style: const TextStyle(fontSize: 13))), Expanded(flex: 2, child: Text(data["vendor"], style: const TextStyle(fontSize: 13))), Expanded(flex: 3, child: Text(data["material"], style: const TextStyle(fontSize: 13))), Expanded(flex: 2, child: Text(data["batch"], style: const TextStyle(fontSize: 13))),
                Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(data["total"], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)), Text(data["balance"], style: const TextStyle(fontSize: 11, color: Colors.grey))])),
                Expanded(flex: 1, child: Center(child: Text(data["images"], style: const TextStyle(fontSize: 13, color: Colors.grey)))), Expanded(flex: 2, child: Center(child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFDC3545), borderRadius: BorderRadius.circular(4)), child: Text(data["status"], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))))),
                Expanded(flex: 3, child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  _actionIconBtn(Icons.edit_outlined, const Color(0xFF0D6EFD), onTap: () => setState(() { _isFormView = true; _isEditMode = true; _isInclusiveGST = false; _formItems = [Map.from(_editItemTemplate)]; })), const SizedBox(width: 4),
                  _actionIconBtn(Icons.delete_outline, const Color(0xFFDC3545), onTap: () => _showDeleteDialog()), const SizedBox(width: 4),
                  _actionIconBtn(Icons.refresh, const Color(0xFF0DCAF0), onTap: () => _showReverseDialog(data)), const SizedBox(width: 4),
                  _actionIconBtn(Icons.description_outlined, const Color(0xFF6C757D)), const SizedBox(width: 4),
                  _actionIconBtn(Icons.print_outlined, const Color(0xFF6C757D), onTap: () => _showPrintDialog()),
                ]))
              ]));
            }).toList()
          ])));
        }), _buildPagination()
      ]))
    ]);
  }

  // --- FORM VIEW ---
  Widget _buildNewPurchaseForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(_isEditMode ? "Edit Purchase Entry" : "New Purchase Entry", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87)),
        ElevatedButton.icon(onPressed: () => setState(() => _isFormView = false), icon: const Icon(Icons.arrow_back, size: 16), label: const Text("Back to List"), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black87, side: BorderSide(color: Colors.grey.shade300), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)))
      ]), const SizedBox(height: 20),
      _buildSectionCard(title: "Invoice Details", child: Column(children: [
        Row(children: [
          Expanded(child: _buildFormInput("Vendor", "Select a vendor...", isDropdown: true, dropdownItems: _vendorList, initialValue: _isEditMode ? "DSP Bags" : null)), const SizedBox(width: 15), 
          Expanded(child: _buildFormInput("Link Purchase Order", "Manual Entry", isDropdown: true, dropdownItems: _poLinks, initialValue: "Manual Entry")), const SizedBox(width: 15), 
          Expanded(child: _buildFormInput("Invoice Number", "Enter or generate...", initialValue: _isEditMode ? "PINV-20260523-0002" : null, suffixIcon: Icons.settings, suffixColor: Colors.blue)), const SizedBox(width: 15), 
          Expanded(child: _buildFormInput("Purchase Date", "18-05-2026", initialValue: "23-05-2026", suffixIcon: Icons.calendar_today)),
        ]),
        const SizedBox(height: 15),
        Row(children: [
          Expanded(flex: 1, child: _buildFormInput("Batch Code", "RB260518-09", isFilled: true, initialValue: "RB260523-02", suffixIcon: Icons.refresh)),
          const SizedBox(width: 15),
          const Expanded(flex: 3, child: SizedBox()) 
        ])
      ])), const SizedBox(height: 20),
      _buildSectionCard(
        title: "Purchase Items", 
        headerCenter: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(onTap: () => setState(() => _isInclusiveGST = false), child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), color: !_isInclusiveGST ? Colors.blue : Colors.transparent, child: Text("Exclusive GST", style: TextStyle(fontSize: 12, color: !_isInclusiveGST ? Colors.white : Colors.blue)))),
              InkWell(onTap: () => setState(() => _isInclusiveGST = true), child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), color: _isInclusiveGST ? Colors.blue : Colors.transparent, child: Text("Inclusive GST", style: TextStyle(fontSize: 12, color: _isInclusiveGST ? Colors.white : Colors.blue)))),
            ]
          )
        ),
        headerTrailing: ElevatedButton.icon(onPressed: () => setState(() => _formItems.add(Map.from(_emptyItemTemplate))), icon: const Icon(Icons.add_circle_outline, size: 16), label: const Text("Add Item (Alt+N)"), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0056B3), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12))), 
        child: Column(children: [
          Container(padding: const EdgeInsets.only(bottom: 10), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))), child: Row(children: [_th("Raw Material", flex: 3), _th("Expiry Date", flex: 2), _th("Unit", flex: 1), _th("Prev. Price", flex: 1, align: TextAlign.center), _th("Price/Unit", flex: 1), _th("Qty", flex: 1), _th("Sub Total", flex: 1), _th("Tax Type", flex: 2), _th("SGST %/Amt", flex: 1, align: TextAlign.center), _th("CGST %/Amt", flex: 1, align: TextAlign.center), _th("Item Total", flex: 1, align: TextAlign.center), const SizedBox(width: 30)])), const SizedBox(height: 10),
          ..._formItems.asMap().entries.map((entry) {
            int index = entry.key; Map<String, dynamic> item = entry.value;
            return Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 3, child: _gridInput(item["material"] ?? "Select...", isAutocomplete: true, dropdownItems: _materialList)), const SizedBox(width: 8), 
              Expanded(flex: 2, child: _gridInput("dd-mm-yyyy", suffixIcon: Icons.calendar_today)), const SizedBox(width: 8), 
              Expanded(flex: 1, child: _gridInput(item["unit"] ?? "N/A", isFilled: true, isCenter: true)), const SizedBox(width: 8),
              Expanded(flex: 1, child: Center(child: Text(item["prevPrice"] ?? "-", style: TextStyle(color: item["prevPrice"] != "-" ? Colors.blue : Colors.grey.shade600, fontSize: 12)))), const SizedBox(width: 8), 
              Expanded(flex: 1, child: _gridInput(item["price"] ?? "0", isCenter: true)), const SizedBox(width: 8), 
              Expanded(flex: 1, child: _gridInput(item["qty"] ?? "0", isCenter: true)), const SizedBox(width: 8),
              Expanded(flex: 1, child: _gridInput(item["subTotal"] ?? "0.00", isCenter: true, isBold: true, borderColor: Colors.grey.shade300)), const SizedBox(width: 8), 
              Expanded(flex: 2, child: _gridInput("SGST + CGST", isDropdown: true)), const SizedBox(width: 8), 
              Expanded(flex: 1, child: Column(children: [_gridInput("0", suffixText: "%"), const SizedBox(height: 4), _gridInput("0", isCenter: true)])), const SizedBox(width: 8), 
              Expanded(flex: 1, child: Column(children: [_gridInput("0", suffixText: "%"), const SizedBox(height: 4), _gridInput("0", isCenter: true)])), const SizedBox(width: 8),
              Expanded(flex: 1, child: _gridInput(item["total"] ?? "₹0.00", isFilled: true, isCenter: true, isBold: true)), const SizedBox(width: 8), 
              InkWell(onTap: () => setState(() => _formItems.removeAt(index)), child: Container(height: 32, width: 32, decoration: BoxDecoration(border: Border.all(color: Colors.red.shade300), borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.delete_outline, color: Colors.red, size: 18)))
            ]));
          }).toList()
        ])
      ), const SizedBox(height: 20),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(flex: 6, child: Column(children: [
          _buildSectionCard(title: "Initial Payment", child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Expanded(child: _buildFormInput("Paid Amount", "0", prefixText: "₹")), const SizedBox(width: 15), Expanded(child: _buildFormInput("Payment Method", "Select...", isDropdown: true, dropdownItems: _paymentMethods))]), const SizedBox(height: 15), _buildFormInput("Payment Notes", "Optional: Cheque number, transaction ID, etc.")])), const SizedBox(height: 20),
          _buildSectionCard(title: "Image Attachments", titleIcon: Icons.camera_alt_outlined, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Purchase Images", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 10), Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFFF8F9FA), border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 80, height: 80, decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid), borderRadius: BorderRadius.circular(4), color: Colors.white), child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_circle_outline, color: Colors.grey), SizedBox(height: 5), Text("Add Images", style: TextStyle(fontSize: 10, color: Colors.grey))]))])), const SizedBox(height: 10), const Text("ⓘ Images are stored on the server only when the purchase is saved.", style: TextStyle(fontSize: 11, color: Colors.grey)), const Text("ⓘ Attachments are saved only when you click \"Save\" or \"Update\".", style: TextStyle(fontSize: 11, color: Colors.grey))]))
        ])), const SizedBox(width: 20),
        Expanded(flex: 4, child: _buildSectionCard(title: "Invoice Summary", child: Column(children: [_summaryRow("Sub Total", _isEditMode ? "₹75,232.08" : "₹0.00"), const Divider(), _summaryRow("Grand Total", _isEditMode ? "₹75,232.08" : "₹0.00", isBold: true), const SizedBox(height: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), decoration: BoxDecoration(color: const Color(0xFFE9ECEF), borderRadius: BorderRadius.circular(4)), child: _summaryRow("Balance Due", _isEditMode ? "₹75,232.08" : "₹0.00", isBold: true))]))),
      ]), const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        ElevatedButton(onPressed: () => setState(() => _isFormView = false), style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade500, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)), child: const Text("Cancel")), const SizedBox(width: 10),
        ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0056B3), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)), child: Text(_isEditMode ? "Update Purchase (Ctrl+Enter)" : "Save Purchase (Ctrl+Enter)"))
      ])
    ]);
  }

  // --- REUSABLE WIDGETS ---
  Widget _buildSectionCard({required String title, required Widget child, Widget? headerTrailing, Widget? headerCenter, IconData? titleIcon}) => Container(
    width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
        child: Row(
          children: [
            Expanded(child: Row(children: [if (titleIcon != null) ...[Icon(titleIcon, size: 18, color: Colors.blue), const SizedBox(width: 8)], Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))])),
            if (headerCenter != null) Expanded(child: Center(child: headerCenter)),
            if (headerTrailing != null) Expanded(child: Align(alignment: Alignment.centerRight, child: headerTrailing)) else const Expanded(child: SizedBox()),
          ]
        )
      ),
      Padding(padding: const EdgeInsets.all(20), child: child)
    ])
  );

  Widget _buildFilterInput(String label, String hint, {bool isDate = false, bool isDropdown = false, List<String>? options, bool isSearch = false, ValueChanged<String>? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)), const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: 38, decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
              child: isDropdown
                ? Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) return options ?? [];
                      var filtered = (options ?? []).where((String option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase())).toList();
                      return filtered.isEmpty ? (options ?? []) : filtered;
                    },
                    onSelected: onChanged,
                    fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                      return TextFormField(
                        controller: controller, focusNode: focusNode, onChanged: onChanged,
                        decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(fontSize: 13, color: Colors.grey), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11), border: InputBorder.none, isDense: true, suffixIcon: InkWell(onTap: () { if (focusNode.hasFocus) { focusNode.unfocus(); } else { focusNode.requestFocus(); } }, child: const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black54))),
                        style: const TextStyle(fontSize: 13, color: Colors.black87),
                      );
                    },
                    optionsViewBuilder: (context, onSelected, optionsList) => _buildAutocompleteOptions(context, onSelected, optionsList, constraints),
                  )
                : TextFormField(
                    readOnly: isDate, onChanged: onChanged,
                    decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(fontSize: 13, color: Colors.grey), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11), isDense: true, border: InputBorder.none, prefixIcon: isSearch ? const Icon(Icons.search, size: 16, color: Colors.grey) : null, suffixIcon: isDate ? const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black54) : null),
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
            );
          }
        )
      ],
    );
  }

  Widget _buildFormInput(String label, String hint, {bool isDropdown = false, IconData? suffixIcon, Color? suffixColor, bool isFilled = false, String? prefixText, List<String>? dropdownItems, String? initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87)), const SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: 38, decoration: BoxDecoration(color: isFilled ? const Color(0xFFF8F9FA) : Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  if (prefixText != null) Padding(padding: const EdgeInsets.only(left: 12), child: Text(prefixText, style: const TextStyle(color: Colors.black54, fontSize: 13))),
                  Expanded(
                    child: isDropdown
                      ? Autocomplete<String>(
                          initialValue: TextEditingValue(text: initialValue ?? ''),
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) return dropdownItems ?? [];
                            var filtered = (dropdownItems ?? []).where((String option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase())).toList();
                            return filtered.isEmpty ? (dropdownItems ?? []) : filtered;
                          },
                          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                            return TextFormField(
                              controller: controller, focusNode: focusNode,
                              decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(fontSize: 13, color: Colors.grey), contentPadding: EdgeInsets.symmetric(horizontal: prefixText != null ? 4 : 12, vertical: 11), border: InputBorder.none, isDense: true, suffixIcon: InkWell(onTap: () { if(focusNode.hasFocus){focusNode.unfocus();}else{focusNode.requestFocus();} }, child: const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black54))),
                              style: const TextStyle(fontSize: 13, color: Colors.black87),
                            );
                          },
                          optionsViewBuilder: (context, onSelected, options) => _buildAutocompleteOptions(context, onSelected, options, constraints),
                        )
                      : TextFormField(
                          initialValue: initialValue,
                          decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(fontSize: 13, color: Colors.grey), contentPadding: EdgeInsets.symmetric(horizontal: prefixText != null ? 4 : 12, vertical: 11), border: InputBorder.none, isDense: true, suffixIcon: suffixIcon != null ? InkWell(onTap: () {}, child: Icon(suffixIcon, size: 16, color: suffixColor ?? Colors.black54)) : null),
                          style: const TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                  ),
                ],
              ),
            );
          }
        )
      ],
    );
  }

  Widget _buildAutocompleteOptions(BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options, BoxConstraints constraints) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: BorderSide(color: Colors.grey.shade300)),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 250, maxWidth: constraints.maxWidth), 
          child: ListView.builder(
            padding: EdgeInsets.zero, shrinkWrap: true, itemCount: options.length,
            itemBuilder: (context, index) {
              final String option = options.elementAt(index);
              return InkWell(
                onTap: () => onSelected(option),
                child: Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))), child: Text(option, style: const TextStyle(fontSize: 13, color: Colors.black87))),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _th(String title, {required int flex, TextAlign align = TextAlign.left}) => Expanded(flex: flex, child: Text(title, textAlign: align, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)));
  
  Widget _gridInput(String hint, {bool isDropdown = false, IconData? suffixIcon, bool isFilled = false, bool isCenter = false, bool isBold = false, String? suffixText, Color? borderColor, bool isAutocomplete = false, List<String>? dropdownItems}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 32, decoration: BoxDecoration(color: isFilled ? const Color(0xFFF8F9FA) : Colors.white, border: Border.all(color: borderColor ?? Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
          child: isAutocomplete
            ? Autocomplete<String>(
                initialValue: TextEditingValue(text: hint == "Select..." ? "" : hint),
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) return dropdownItems ?? [];
                  var filtered = (dropdownItems ?? []).where((String option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase())).toList();
                  return filtered.isEmpty ? (dropdownItems ?? []) : filtered;
                },
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  return TextFormField(
                    controller: controller, focusNode: focusNode, textAlign: isCenter ? TextAlign.center : TextAlign.left,
                    decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade600), contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10), border: InputBorder.none, isDense: true, suffixIcon: InkWell(onTap: () { if(focusNode.hasFocus){focusNode.unfocus();}else{focusNode.requestFocus();} }, child: const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black54))),
                    style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
                  );
                },
                optionsViewBuilder: (context, onSelected, options) => _buildAutocompleteOptions(context, onSelected, options, constraints),
              )
            : TextFormField(
                initialValue: (hint == "Select..." || hint == "-" || hint == "N/A" || hint == "dd-mm-yyyy" || hint == "0" || hint == "0.00" || hint == "₹0.00") ? "" : hint,
                textAlign: isCenter ? TextAlign.center : TextAlign.left, readOnly: isFilled || hint == "dd-mm-yyyy",
                decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade600), contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: suffixIcon != null || suffixText != null || isDropdown ? 8 : 10), border: InputBorder.none, isDense: true, suffixIcon: isDropdown ? const Icon(Icons.keyboard_arrow_down, size: 14, color: Colors.black54) : (suffixIcon != null ? Icon(suffixIcon, size: 14, color: Colors.black54) : (suffixText != null ? Padding(padding: const EdgeInsets.only(right: 8, top: 8), child: Text(suffixText, style: const TextStyle(fontSize: 12, color: Colors.grey))) : null))),
                style: TextStyle(fontSize: 12, color: isFilled ? Colors.black87 : Colors.grey.shade800, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
              )
        );
      }
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false, Color? color, double fontSize = 14}) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: TextStyle(fontSize: fontSize, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)), Text(value, style: TextStyle(color: color, fontSize: fontSize, fontWeight: isBold ? FontWeight.bold : FontWeight.normal))]));
  
  Widget _buildPagination() {
    int totalPages = (filteredData.length / _itemsPerPage).ceil(); if (totalPages <= 1) return const SizedBox.shrink();
    List<Widget> pageBtns = [_pageBox("Prev", false, () { if (_currentPage > 1) setState(() => _currentPage--); }), const SizedBox(width: 5)];
    for (int i = 1; i <= totalPages; i++) { pageBtns.add(_pageBox("$i", _currentPage == i, () => setState(() => _currentPage = i))); if (i < totalPages) pageBtns.add(const SizedBox(width: 5)); }
    pageBtns.addAll([const SizedBox(width: 5), _pageBox("Next", false, () { if (_currentPage < totalPages) setState(() => _currentPage++); })]);
    return Padding(padding: const EdgeInsets.all(16.0), child: Center(child: Wrap(alignment: WrapAlignment.center, spacing: 2, runSpacing: 8, children: pageBtns)));
  }
  
  Widget _pageBox(String t, bool active, VoidCallback onTap) => InkWell(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: active ? Colors.blue : Colors.white, border: Border.all(color: active ? Colors.blue : Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Text(t, style: TextStyle(color: active ? Colors.white : Colors.blue, fontSize: 13, fontWeight: FontWeight.bold))));
  Widget _actionIconBtn(IconData icon, Color color, {VoidCallback? onTap}) => InkWell(onTap: onTap, child: Container(height: 28, width: 28, decoration: BoxDecoration(border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)), child: Center(child: Icon(icon, size: 14, color: color))));
}