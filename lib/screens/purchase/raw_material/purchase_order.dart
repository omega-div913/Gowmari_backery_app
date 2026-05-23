import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/components/app_sidebar.dart'; 
import 'subsidebar.dart'; 

class RawMaterialPurchaseOrderPage extends StatefulWidget {
  const RawMaterialPurchaseOrderPage({super.key});

  @override
  State<RawMaterialPurchaseOrderPage> createState() => _RawMaterialPurchaseOrderPageState();
}

class _RawMaterialPurchaseOrderPageState extends State<RawMaterialPurchaseOrderPage> {
  int _currentView = 0; 
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  String? _selectedVendor;
  List<Map<String, dynamic>> _createOrderItems = [{"material": null, "availableQty": "0.00", "quantity": "1", "unit": "N/A"}];
  List<Map<String, dynamic>> _editOrderItems = [];
  Map<String, dynamic>? _editingOrder;
  
  List<String> _selectedStatuses = [];
  OverlayEntry? _statusDropdown;
  final GlobalKey _statusKey = GlobalKey();
  final LayerLink _statusLayerLink = LayerLink();

  final List<String> _vendorList = [
    "All Vendors", "Sri Poovathal Polychem Industry", "MAXON SYNTHESIS", 
    "GOWMARI & CO", "VPN AGENCY", "SRI BALAJI ENTERPRISE"
  ];
  final List<String> _materialList = [
    "All Materials", "1 kg P.P Cover", "1 kg Birthday Cake Box", "1 kg Cake Bag", 
    "1 kg Square Cake Bottom", "1 kg Sweet Box", "Gas Cylinder (2.00 nos)", "7- up Fizz (5.00 kg)"
  ];

  final List<Map<String, dynamic>> _orders = [
    {"orderDate": "18/05/2026", "requestDate": "18/05/2026", "vendor": "test1", "material": "test11 (1.00 Pcs)", "status": "Waiting For Approval", "items": [{"material": "test11", "availableQty": "2.00", "quantity": "1", "unit": "Pcs"}]},
    {"orderDate": "18/05/2026", "requestDate": "19/05/2026", "vendor": "test", "material": "TEST (1.00 Box)", "status": "Pending", "items": [{"material": "TEST", "availableQty": "5.00", "quantity": "1", "unit": "Box"}]},
    ...List.generate(20, (index) => {"orderDate": "18/05/2026", "requestDate": "19/05/2026", "vendor": "test ${index + 2}", "material": "Gas Cylinder (1.00 nos)", "status": "Waiting For Approval", "items": [{"material": "Gas Cylinder", "availableQty": "2.00", "quantity": "1", "unit": "nos"}]})
  ];
  
  List<Map<String, dynamic>> get paginatedOrders {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    return _orders.sublist(startIndex, (startIndex + _itemsPerPage > _orders.length) ? _orders.length : startIndex + _itemsPerPage);
  }

  @override
  void dispose() {
    _statusDropdown?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: AppSidebar(activeMenu: "Raw Material")) : null,
      appBar: isMobile ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Purchase Order", style: TextStyle(color: Colors.black, fontSize: 16))) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const AppSidebar(activeMenu: "Raw Material"),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) Container(
                  height: 60, padding: const EdgeInsets.symmetric(horizontal: 25), decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))),
                  child: Row(
                    children: [
                      const Icon(Icons.menu, color: Colors.grey, size: 20), const SizedBox(width: 15),
                      const Text("Home", style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)), const Spacer(),
                      Container(width: 300, height: 35, decoration: BoxDecoration(color: const Color(0xFFF4F7FE), borderRadius: BorderRadius.circular(20)), child: const TextField(decoration: InputDecoration(hintText: "Search menus ( Press / )", hintStyle: TextStyle(fontSize: 13, color: Colors.grey), prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 10)))),
                      const SizedBox(width: 20), Container(width: 35, height: 35, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle), child: const Center(child: Text("R", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))), const SizedBox(width: 10), const Text("RTS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), const Icon(Icons.arrow_drop_down, color: Colors.black)
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (screenWidth > 850) const SizedBox(width: 260, child: RawMaterialSubSidebar(activePage: 'Purchase Order')),
                      Expanded(child: ScrollConfiguration(behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false), child: SingleChildScrollView(padding: const EdgeInsets.all(25), child: _getContentWidget()))),
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

  Widget _getContentWidget() {
    if (_currentView == 1) return _buildCreateOrderForm();
    if (_currentView == 2) return _buildEditOrderForm(); 
    return _buildOrderList(); 
  }

  // =========================================================================
  // VIEW 0: ORDER LIST
  // =========================================================================
  Widget _buildOrderList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Purchase Order (Raw Material)", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87)),
            ElevatedButton.icon(
              onPressed: () => setState(() => _currentView = 1), icon: const Icon(Icons.add, size: 16), label: const Text("Create New Order"),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
            )
          ],
        ),
        const SizedBox(height: 25),
        
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildNewField("From Date", "18-05-2026", isDate: true)), const SizedBox(width: 15),
                  Expanded(child: _buildNewField("To Date", "18-05-2026", isDate: true)), const SizedBox(width: 15),
                  Expanded(child: _buildNewField("Search by Vendor", "Type or select a vendor...", isDropdown: true, options: _vendorList)),
                ]
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: _buildNewField("Search by Material", "Type or select a material...", isDropdown: true, options: _materialList)), const SizedBox(width: 15),
                  Expanded(child: _buildNewField("Search", "Search...", isSearch: true)), const SizedBox(width: 15),
                  Expanded(child: _buildMultiSelectDropdown("Status", "Select Status")),
                ]
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.close, size: 14, color: Colors.grey), label: const Text("Reset", style: TextStyle(color: Colors.grey)), style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
                ],
              )
            ],
          )
        ),
        
        const SizedBox(height: 25),
        Container(
          width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                child: const Row(
                  children: [
                    SizedBox(width: 40, child: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 2, child: Text("Order Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 2, child: Text("Request Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 2, child: Text("Vendor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 3, child: Text("Material(s)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 3, child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center)),
                    Expanded(flex: 3, child: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.right)), 
                  ],
                ),
              ),
              ...paginatedOrders.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> order = entry.value;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 40, child: Text("${((_currentPage - 1) * _itemsPerPage) + index + 1}", style: const TextStyle(fontSize: 13))),
                      Expanded(flex: 2, child: Text(order["orderDate"], style: const TextStyle(fontSize: 13))),
                      Expanded(flex: 2, child: Text(order["requestDate"], style: const TextStyle(fontSize: 13))),
                      Expanded(flex: 2, child: Text(order["vendor"], style: const TextStyle(fontSize: 13))),
                      Expanded(flex: 3, child: InkWell(
                        onTap: () => _showPriceComparisonDialog(context, order["material"]),
                        child: Text(order["material"], style: const TextStyle(fontSize: 13, color: Color(0xFF0D6EFD), fontWeight: FontWeight.w500))
                      )),
                      Expanded(flex: 3, child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(color: order["status"] == "Pending" ? const Color(0xFF0DCAF0) : const Color(0xFFFFC107), borderRadius: BorderRadius.circular(4)),
                          child: Text(order["status"], style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: order["status"] == "Pending" ? Colors.white : Colors.black87)),
                        ),
                      )),
                      Expanded(
                        flex: 3, 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _gridActionBtn(Icons.print_outlined, Colors.grey.shade400, Colors.grey.shade600, onTap: () => _showPrintOptionsDialog(context)), const SizedBox(width: 4),
                            _gridActionBtn(Icons.chat_bubble_outline, const Color(0xFF198754), const Color(0xFF198754), onTap: () => _showWhatsAppOptionsDialog(context)), 
                            if (order["status"] != "Pending") ...[
                              const SizedBox(width: 4), _gridActionBtn(Icons.check, const Color(0xFF198754), Colors.white, isSolid: true, onTap: () {}),
                              const SizedBox(width: 4), _gridActionBtn(Icons.edit_outlined, const Color(0xFF0D6EFD), const Color(0xFF0D6EFD), onTap: () => setState(() { _editingOrder = order; _editOrderItems = (order['items'] as List).map((e) => Map<String, dynamic>.from(e)).toList(); _currentView = 2; })),
                              const SizedBox(width: 4), _gridActionBtn(Icons.delete_outline, const Color(0xFFDC3545), const Color(0xFFDC3545), onTap: () => _showDeleteDialog(context)),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              _buildPagination(),
            ],
          ),
        )
      ],
    );
  }

  void _toggleStatusDropdown() {
    if (_statusDropdown != null) {
      _statusDropdown!.remove();
      _statusDropdown = null;
      return;
    }
    final RenderBox renderBox = _statusKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _statusDropdown = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(behavior: HitTestBehavior.opaque, onTap: () { _statusDropdown?.remove(); _statusDropdown = null; }, child: Container(color: Colors.transparent)),
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _statusLayerLink, showWhenUnlinked: false, offset: Offset(0, size.height + 5),
              child: Material(
                elevation: 4, borderRadius: BorderRadius.circular(4),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
                  child: StatefulBuilder(
                    builder: (context, setOverlayState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: ["Waiting For Approval", "Pending", "Purchased"].map((status) {
                          bool isChecked = _selectedStatuses.contains(status);
                          return InkWell(
                            onTap: () {
                              setOverlayState(() { if (isChecked) { _selectedStatuses.remove(status); } else { _selectedStatuses.add(status); } });
                              setState(() {}); 
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                              decoration: BoxDecoration(
                                color: isChecked ? const Color(0xFFF4F7FE) : Colors.white,
                                border: Border(bottom: BorderSide(color: Colors.grey.shade100))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(status, style: TextStyle(fontSize: 13, color: isChecked ? const Color(0xFF0D47A1) : Colors.black87, fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal)),
                                  if (isChecked) const Icon(Icons.check, size: 16, color: Color(0xFF0D47A1))
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  )
                )
              )
            )
          )
        ]
      )
    );
    Overlay.of(context).insert(_statusDropdown!);
  }

  Widget _buildMultiSelectDropdown(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 8),
        CompositedTransformTarget(
          link: _statusLayerLink,
          child: InkWell(
            key: _statusKey, onTap: _toggleStatusDropdown,
            child: Container(
              height: 38, padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedStatuses.isEmpty ? hint : "${_selectedStatuses.length} Selected", style: TextStyle(fontSize: 13, color: _selectedStatuses.isEmpty ? Colors.grey : Colors.black87)),
                  const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black54)
                ]
              )
            )
          ),
        )
      ]
    );
  }

  Widget _buildNewField(String label, String hint, {bool isDate = false, bool isDropdown = false, List<String>? options, bool isSearch = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 8),
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
                    fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                      return TextFormField(
                        controller: controller, focusNode: focusNode,
                        decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(fontSize: 13, color: Colors.grey), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11), border: InputBorder.none, isDense: true, suffixIcon: InkWell(onTap: () { if (focusNode.hasFocus) { focusNode.unfocus(); } else { focusNode.requestFocus(); } }, child: const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black54))),
                        style: const TextStyle(fontSize: 13, color: Colors.black87),
                      );
                    },
                    optionsViewBuilder: (context, onSelected, optionsList) => _buildAutocompleteOptions(context, onSelected, optionsList, constraints),
                  )
                : TextFormField(
                    readOnly: isDate,
                    decoration: InputDecoration(
                      hintText: hint, 
                      hintStyle: const TextStyle(fontSize: 13, color: Colors.grey), 
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11), 
                      isDense: true, 
                      border: InputBorder.none, 
                      prefixIcon: isSearch ? const Icon(Icons.search, size: 16, color: Colors.grey) : null,
                      suffixIcon: isDate ? const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black54) : null
                    ),
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
            );
          }
        )
      ],
    );
  }

  void _showPriceComparisonDialog(BuildContext context, String materialRaw) {
    String material = materialRaw.split(' (')[0];
    if (material == "TEST" || material == "test11") material = "Gas Cylinder";

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 800, height: 500, padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [const Icon(Icons.bar_chart, color: Color(0xFF0D6EFD)), const SizedBox(width: 10), Text("Price Comparison: $material", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87))]),
                  IconButton(icon: const Icon(Icons.close, color: Colors.grey, size: 20), onPressed: () => Navigator.pop(context), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                ],
              ),
              const Divider(height: 30),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: const Color(0xFF0D6EFD), width: 1.5), borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          children: [
                            Container(width: double.infinity, padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Color(0xFF0D6EFD), borderRadius: BorderRadius.vertical(top: Radius.circular(4))), child: const Text("Selected Vendor: KRISHNAN GAS AGENCY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))),
                            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))), child: Row(children: const [Text("Total Outstanding: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text("₹1,19,880.00", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13))])),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                              child: Row(children: const [Expanded(child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))), Expanded(child: Text("Invoice #", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))), Expanded(child: Text("Qty", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))), Expanded(child: Text("Price", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))), SizedBox(width: 24)]),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 10, padding: const EdgeInsets.symmetric(vertical: 5),
                                itemBuilder: (c, i) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  child: Row(children: [Expanded(child: Text("16/05/2026", style: TextStyle(fontSize: 12, color: Colors.grey.shade800))), Expanded(child: Text("549", style: TextStyle(fontSize: 12, color: Colors.grey.shade800))), Expanded(child: Text(i % 2 == 0 ? "10.00" : "1.00", textAlign: TextAlign.right, style: TextStyle(fontSize: 12, color: Colors.grey.shade800))), const Expanded(child: Text("₹3,240.00", textAlign: TextAlign.right, style: TextStyle(color: Color(0xFF0D6EFD), fontWeight: FontWeight.bold, fontSize: 12))), const SizedBox(width: 10), const Icon(Icons.article_outlined, size: 14, color: Color(0xFF0D6EFD))]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Other Vendors Comparison (2)", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 13)), const SizedBox(height: 10),
                          Expanded(child: ListView(children: [_buildVendorExpansion("LALITHA BHARATGAS", "₹25,824.00", true), _buildVendorExpansion("VELAN GAS AGENCY", "₹41,306.00", false)]))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  Widget _buildVendorExpansion(String name, String out, bool initExp) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: BorderSide(color: Colors.grey.shade300)), elevation: 0,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: initExp, backgroundColor: const Color(0xFFF4F7FE), collapsedBackgroundColor: Colors.white, tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0D47A1))),
          children: [
            Container(
              color: Colors.white, padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Outstanding:", style: TextStyle(fontSize: 12, color: Colors.black87)), Text(out, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12))]),
                  const Divider(height: 20),
                  Row(children: const [Expanded(child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))), Expanded(child: Text("Qty", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))), Expanded(child: Text("Price", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)))]),
                  const SizedBox(height: 5),
                  ...List.generate(3, (i) => Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(children: const [Expanded(child: Text("13/05/2026", style: TextStyle(fontSize: 12, color: Colors.black87))), Expanded(child: Text("4.00", textAlign: TextAlign.right, style: TextStyle(fontSize: 12, color: Colors.black87))), Expanded(child: Text("₹3,228.00", textAlign: TextAlign.right, style: TextStyle(color: Color(0xFF198754), fontWeight: FontWeight.bold, fontSize: 12)))])))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _gridActionBtn(IconData icon, Color color, Color iconColor, {bool isSolid = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(height: 28, width: 30, decoration: BoxDecoration(color: isSolid ? color : Colors.white, border: Border.all(color: color.withOpacity(0.5)), borderRadius: BorderRadius.circular(4)), child: Center(child: Icon(icon, size: 14, color: isSolid ? Colors.white : iconColor))),
    );
  }

  Widget _buildCreateOrderForm() {
    return _buildFormBase(title: "New Purchase Order", onBack: () => setState(() { _currentView = 0; _createOrderItems = [{"material": null, "availableQty": "0.00", "quantity": "1", "unit": "N/A"}]; _selectedVendor = null; }), currentItems: _createOrderItems);
  }

  Widget _buildEditOrderForm() {
    if (_editingOrder == null) return const SizedBox.shrink();
    return _buildFormBase(title: "Edit Purchase Order", onBack: () => setState(() { _currentView = 0; _editingOrder = null; }), orderData: _editingOrder, currentItems: _editOrderItems);
  }

  Widget _buildFormBase({required String title, required VoidCallback onBack, required List<Map<String, dynamic>> currentItems, Map<String, dynamic>? orderData}) {
    bool isEdit = orderData != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87)),
            OutlinedButton.icon(onPressed: onBack, icon: const Icon(Icons.arrow_back, size: 16), label: const Text("Back to List"), style: OutlinedButton.styleFrom(foregroundColor: Colors.grey.shade700, side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))))
          ],
        ),
        const SizedBox(height: 25),
        Container(
          width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(20), child: Text("Order Details", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87))), Divider(height: 1, color: Colors.grey.shade300),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildFormField("Vendor", "Select a vendor...", isDropdown: true, initialValue: orderData?['vendor'], value: _selectedVendor, dropdownItems: _vendorList, onChanged: (v) => setState(() => _selectedVendor = v))), const SizedBox(width: 20),
                        Expanded(child: _buildFormField("Order Date", "23-05-2026", isDate: true, initialValue: orderData?['orderDate'] ?? "23-05-2026")), const SizedBox(width: 20),
                        Expanded(child: _buildFormField("Request Date", "23-05-2026", isDate: true, initialValue: orderData?['requestDate'] ?? "23-05-2026")), const SizedBox(width: 20),
                        Expanded(child: _buildFormField("Estimation Days", "0", initialValue: isEdit ? "1" : "0")),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (isEdit) ...[
                      const Text("Status", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)), const SizedBox(height: 8),
                      Container(width: 250, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)), child: Text(orderData?['status'] ?? 'N/A', style: const TextStyle(fontSize: 13, color: Colors.black54))),
                      const SizedBox(height: 20),
                    ],
                    const Text("Notes", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)), const SizedBox(height: 8),
                    TextFormField(maxLines: 3, decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey.shade300)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey.shade300)))),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 25),
        Container(
          width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Items", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                    ElevatedButton.icon(onPressed: () => setState(() => currentItems.add({"material": null, "availableQty": "0.00", "quantity": "1", "unit": "N/A"})), icon: const Icon(Icons.add_circle_outline, size: 16), label: const Text("Add Item (Alt+N)"), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)))
                  ],
                ),
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                child: const Row(
                  children: [
                    SizedBox(width: 40, child: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 4, child: Text("Raw Material", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 2, child: Text("Available Qty", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 2, child: Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 2, child: Text("Unit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    SizedBox(width: 40), 
                  ],
                ),
              ),
              ...currentItems.asMap().entries.map((entry) {
                int index = entry.key; Map<String, dynamic> item = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 40, child: Padding(padding: const EdgeInsets.only(top: 10), child: Text("${index + 1}", style: const TextStyle(fontSize: 13)))),
                      Expanded(flex: 4, child: _buildFormInput("Select a material...", isDropdown: true, initialValue: item['material'], value: item["material"], dropdownItems: _materialList, onChanged: (v) => setState(() => item["material"] = v))), const SizedBox(width: 15),
                      Expanded(flex: 2, child: _buildFormInput("0.00", isReadOnly: true, initialValue: item['availableQty'])), const SizedBox(width: 15),
                      Expanded(flex: 2, child: _buildFormInput("1", initialValue: item['quantity'], isQuantity: true)), const SizedBox(width: 15),
                      Expanded(flex: 2, child: _buildFormInput("N/A", isReadOnly: true, bgColor: Colors.grey.shade100, initialValue: item['unit'])), const SizedBox(width: 15),
                      Container(height: 38, width: 38, decoration: BoxDecoration(border: Border.all(color: Colors.red.withOpacity(0.3)), borderRadius: BorderRadius.circular(4)), child: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18), padding: EdgeInsets.zero, onPressed: () { setState(() { if (currentItems.length > 1) { currentItems.removeAt(index); } }); }))
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: onBack, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)), child: const Text("Cancel")), const SizedBox(width: 10),
            ElevatedButton(onPressed: () => setState(() => _currentView = 0), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)), child: Text(isEdit ? "Update Order" : "Save Order", style: const TextStyle(fontWeight: FontWeight.bold)))
          ],
        )
      ],
    );
  }

  Widget _buildPagination() {
    int totalPages = (_orders.length / _itemsPerPage).ceil();
    if (totalPages <= 1) return const SizedBox.shrink();
    List<Widget> pageButtons = [];
    pageButtons.add(_pageBox("Prev", false, () { if (_currentPage > 1) setState(() => _currentPage--); }));
    for (int i = 1; i <= totalPages; i++) pageButtons.add(_pageBox("$i", _currentPage == i, () { setState(() => _currentPage = i); }));
    pageButtons.add(_pageBox("Next", false, () { if (_currentPage < totalPages) setState(() => _currentPage++); }));
    return Padding(padding: const EdgeInsets.all(16.0), child: Wrap(alignment: WrapAlignment.center, spacing: 5, runSpacing: 8, children: pageButtons));
  }

  Widget _pageBox(String t, bool active, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: active ? Colors.blue : Colors.white, border: Border.all(color: active ? Colors.blue : Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Text(t, style: TextStyle(color: active ? Colors.white : Colors.blue, fontSize: 13, fontWeight: FontWeight.bold))),
  );

  void _showWhatsAppOptionsDialog(BuildContext context) {}
  void _showDeleteDialog(BuildContext context) {}
  void _showPrintOptionsDialog(BuildContext context) {}

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

  Widget _buildFormField(String label, String hint, {bool isDropdown = false, bool isDate = false, String? value, List<String>? dropdownItems, ValueChanged<String?>? onChanged, String? initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)), const SizedBox(height: 8),
        _buildFormInput(hint, isDropdown: isDropdown, isDate: isDate, value: value, dropdownItems: dropdownItems, onChanged: onChanged, initialValue: initialValue),
      ],
    );
  }

  Widget _buildFormInput(String hint, {bool isDropdown = false, bool isDate = false, bool isReadOnly = false, Color? bgColor, String? value, List<String>? dropdownItems, ValueChanged<String?>? onChanged, String? initialValue, bool isQuantity = false}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 38, decoration: BoxDecoration(color: bgColor ?? Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
          child: isDropdown 
            ? Autocomplete<String>(
                initialValue: TextEditingValue(text: value ?? initialValue ?? ''),
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) return dropdownItems ?? [];
                  var filtered = (dropdownItems ?? []).where((String option) => option.toLowerCase().contains(textEditingValue.text.toLowerCase())).toList();
                  return filtered.isEmpty ? (dropdownItems ?? []) : filtered;
                },
                onSelected: onChanged,
                fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                  return TextFormField(
                    controller: controller, focusNode: focusNode,
                    decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(fontSize: 13, color: Colors.grey), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11), border: InputBorder.none, isDense: true, suffixIcon: InkWell(onTap: () { if (focusNode.hasFocus) { focusNode.unfocus(); } else { focusNode.requestFocus(); } }, child: const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black54))),
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  );
                },
                optionsViewBuilder: (context, onSelected, options) => _buildAutocompleteOptions(context, onSelected, options, constraints),
              )
            : TextFormField(
                initialValue: initialValue, readOnly: isReadOnly || isDate, keyboardType: isQuantity ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(fontSize: 13, color: isReadOnly ? Colors.black87 : Colors.grey), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11), isDense: true, border: InputBorder.none, suffixIcon: isQuantity ? Container(width: 25, decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.grey.shade300))), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.arrow_drop_up, size: 18, color: Colors.black54), Icon(Icons.arrow_drop_down, size: 18, color: Colors.black54)])) : (isDate ? const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black87) : null)),
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
        );
      }
    );
  }
}