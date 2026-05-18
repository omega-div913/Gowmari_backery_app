import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/components/app_sidebar.dart'; 
import 'subsidebar.dart'; 

class RawMaterialPurchaseOrderPage extends StatefulWidget {
  const RawMaterialPurchaseOrderPage({super.key});

  @override
  State<RawMaterialPurchaseOrderPage> createState() => _RawMaterialPurchaseOrderPageState();
}

class _RawMaterialPurchaseOrderPageState extends State<RawMaterialPurchaseOrderPage> {
  // 0: List View, 1: Create Form, 2: Edit Form
  int _currentView = 0; 
  
  // --- PAGINATION STATE ---
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  // --- FORM STATE ---
  String? _selectedVendor;
  List<Map<String, dynamic>> _createOrderItems = [{"material": null, "availableQty": "0.00", "quantity": "1", "unit": "N/A"}];
  List<Map<String, dynamic>> _editOrderItems = [];


  // --- DUMMY DATA ---
  final List<String> _vendorList = ["Vendor A", "Vendor B", "Test Vendor"];
  final List<String> _materialList = ["Material X", "Material Y", "TEST"];

  final List<Map<String, dynamic>> _orders = [
    {
      "orderDate": "18/05/2026",
      "requestDate": "18/05/2026",
      "vendor": "test1",
      "material": "test11 (1.00 Pcs)",
      "status": "Waiting For Approval",
      "items": [{"material": "test11", "availableQty": "2.00", "quantity": "1", "unit": "Pcs"}]
    },
    {
      "orderDate": "18/05/2026",
      "requestDate": "19/05/2026",
      "vendor": "test",
      "material": "TEST (1.00 Box)",
      "status": "Pending",
      "items": [{"material": "TEST", "availableQty": "5.00", "quantity": "1", "unit": "Box"}]
    },
    // Adding more for pagination demonstration
    ...List.generate(20, (index) => {
      "orderDate": "18/05/2026",
      "requestDate": "19/05/2026",
      "vendor": "test ${index + 2}",
      "material": "TEST (1.00 Box)",
      "status": "Waiting For Approval",
      "items": [{"material": "TEST", "availableQty": "2.00", "quantity": "1", "unit": "Box"}]
    })
  ];
  
  List<Map<String, dynamic>> get paginatedOrders {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = (startIndex + _itemsPerPage > _orders.length) ? _orders.length : startIndex + _itemsPerPage;
    return _orders.sublist(startIndex, endIndex);
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: AppSidebar(activeMenu: "Raw Material")) : null,
      appBar: isMobile 
        ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Purchase Order", style: TextStyle(color: Colors.black, fontSize: 16))) 
        : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const AppSidebar(activeMenu: "Raw Material"),
          
          Expanded(
            child: Column(
              children: [
                if (!isMobile) Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))),
                  child: Row(
                    children: [
                      const Icon(Icons.menu, color: Colors.grey, size: 20),
                      const SizedBox(width: 15),
                      const Text("Home", style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(
                        width: 300, height: 35,
                        decoration: BoxDecoration(color: const Color(0xFFF4F7FE), borderRadius: BorderRadius.circular(20)),
                        child: const TextField(decoration: InputDecoration(hintText: "Search menus ( Press / )", hintStyle: TextStyle(fontSize: 13, color: Colors.grey), prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 10))),
                      ),
                      const SizedBox(width: 20),
                      Container(width: 35, height: 35, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle), child: const Center(child: Text("R", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      const SizedBox(width: 10),
                      const Text("RTS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const Icon(Icons.arrow_drop_down, color: Colors.black)
                    ],
                  ),
                ),
                
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (screenWidth > 850) const SizedBox(width: 260, child: RawMaterialSubSidebar(activePage: 'Purchase Order')),
                      
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(25),
                            child: _getContentWidget(),
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

  Widget _getContentWidget() {
    if (_currentView == 1) return _buildCreateOrderForm();
    if (_currentView == 2) return _buildEditOrderForm(); 
    return _buildOrderList(); 
  }

  // =========================================================================
  // VIEW 0: ORDER LIST (UPDATED DESIGN)
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
              onPressed: () => setState(() => _currentView = 1),
              icon: const Icon(Icons.add, size: 16),
              label: const Text("Create New Order"),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
            )
          ],
        ),
        const SizedBox(height: 25),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildFilterDropdown("Vendor:", "All Vendors"),
            const SizedBox(width: 15),
            _buildFilterDate("From:", "18-05-2026"),
            const SizedBox(width: 15),
            _buildFilterDate("To:", "18-05-2026"),
            const SizedBox(width: 15),
            SizedBox(
              height: 38,
              child: OutlinedButton.icon(
                onPressed: () {}, icon: const Icon(Icons.close, size: 14, color: Colors.grey), label: const Text("Reset", style: TextStyle(color: Colors.grey)), style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
              ),
            )
          ],
        ),
        const SizedBox(height: 25),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                child: const Row(
                  children: [
                    Expanded(flex: 2, child: Text("Order Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 2, child: Text("Request Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 2, child: Text("Vendor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 3, child: Text("Material(s)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                    Expanded(flex: 3, child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center)),
                    Expanded(flex: 3, child: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.right)), 
                  ],
                ),
              ),
              ...paginatedOrders.map((order) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 2, child: Text(order["orderDate"], style: const TextStyle(fontSize: 13))),
                      Expanded(flex: 2, child: Text(order["requestDate"], style: const TextStyle(fontSize: 13))),
                      Expanded(flex: 2, child: Text(order["vendor"], style: const TextStyle(fontSize: 13))),
                      Expanded(flex: 3, child: Text(order["material"], style: const TextStyle(fontSize: 13, color: Color(0xFF0D6EFD), fontWeight: FontWeight.w500))),
                      Expanded(flex: 3, child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: order["status"] == "Pending" ? const Color(0xFF0DCAF0) : const Color(0xFFFFC107), 
                            borderRadius: BorderRadius.circular(4)
                          ),
                          child: Text(order["status"], style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: order["status"] == "Pending" ? Colors.white : Colors.black87)),
                        ),
                      )),
                      Expanded(
                        flex: 3, 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _gridActionBtn(Icons.print_outlined, Colors.grey.shade400, Colors.grey.shade600, onTap: () => _showPrintOptionsDialog(context)),
                            const SizedBox(width: 4),
                            _gridActionBtn(Icons.chat_bubble_outline, const Color(0xFF198754), const Color(0xFF198754), onTap: () => _showWhatsAppOptionsDialog(context)), 
                            if (order["status"] != "Pending") ...[
                              const SizedBox(width: 4),
                              _gridActionBtn(Icons.check, const Color(0xFF198754), Colors.white, isSolid: true, onTap: () => _showApproveDialog(context, order)),
                              const SizedBox(width: 4),
                              _gridActionBtn(Icons.edit_outlined, const Color(0xFF0D6EFD), const Color(0xFF0D6EFD), onTap: () => setState(() {
                                  _editOrderItems = List<Map<String, dynamic>>.from(order['items']);
                                  _currentView = 2;
                              })),
                              const SizedBox(width: 4),
                              _gridActionBtn(Icons.delete_outline, const Color(0xFFDC3545), const Color(0xFFDC3545), onTap: () => _showDeleteDialog(context)),
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

  // --- APPROVE POPUP ---
  void _showApproveDialog(BuildContext context, Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFC9DAE1), width: 4)),
                  child: const Center(child: Text("?", style: TextStyle(fontSize: 50, color: Color(0xFF87ADBD), fontWeight: FontWeight.w300))),
                ),
                const SizedBox(height: 25),
                const Text("Approve this Order?", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF595959))),
                const SizedBox(height: 15),
                Text("Approve PO for ${order['vendor']}?", style: const TextStyle(fontSize: 16, color: Color(0xFF545454))),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF28A745), padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                      child: const Text("Yes, Approve", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6E7881), padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                      child: const Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // UPDATED SMALL ACTION BUTTONS
  Widget _gridActionBtn(IconData icon, Color color, Color iconColor, {bool isSolid = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 28, width: 30,
        decoration: BoxDecoration(
          color: isSolid ? color : Colors.white,
          border: Border.all(color: color.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(child: Icon(icon, size: 14, color: isSolid ? Colors.white : iconColor)),
      ),
    );
  }

  // =========================================================================
  // VIEW 1: CREATE ORDER FORM
  // =========================================================================
  Widget _buildCreateOrderForm() {
    return _buildFormBase(
      title: "New Purchase Order",
      onBack: () {
        setState(() {
          _currentView = 0;
          _createOrderItems = [{"material": null, "availableQty": "0.00", "quantity": "1", "unit": "N/A"}];
          _selectedVendor = null;
        });
      },
      currentItems: _createOrderItems, 
    );
  }

  // =========================================================================
  // VIEW 2: EDIT ORDER FORM
  // =========================================================================
  Widget _buildEditOrderForm() {
    Map<String, dynamic> editData = _orders[0];

    return _buildFormBase(
      title: "Edit Purchase Order",
      onBack: () => setState(() => _currentView = 0),
      orderData: editData,
      currentItems: _editOrderItems, 
    );
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
            OutlinedButton.icon(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text("Back to List"),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.grey.shade700, side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
            )
          ],
        ),
        const SizedBox(height: 25),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.all(20), child: Text("Order Details", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87))),
              Divider(height: 1, color: Colors.grey.shade300),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildFormField("Vendor", "Select a vendor...", isDropdown: !isEdit, initialValue: orderData?['vendor'], value: _selectedVendor, dropdownItems: _vendorList, onChanged: (v) => setState(() => _selectedVendor = v))),
                        const SizedBox(width: 20),
                        Expanded(child: _buildFormField("Order Date", "...", isDate: true, initialValue: orderData?['orderDate'])),
                        const SizedBox(width: 20),
                        Expanded(child: _buildFormField("Request Date", "...", isDate: true, initialValue: orderData?['requestDate'])),
                        const SizedBox(width: 20),
                        Expanded(child: _buildFormField("Estimation Days", "0", initialValue: isEdit ? "1" : "0")),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    if (isEdit) ...[
                      const Text("Status", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
                      const SizedBox(height: 8),
                      Container(
                        width: 250, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                        child: Text(orderData?['status'] ?? 'N/A', style: const TextStyle(fontSize: 13, color: Colors.black54)),
                      ),
                      const SizedBox(height: 20),
                    ],

                    const Text("Notes", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
                    const SizedBox(height: 8),
                    TextFormField(
                      maxLines: 3,
                      decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey.shade300)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(color: Colors.grey.shade300))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 25),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Items", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
                    ElevatedButton.icon(
                      onPressed: () => setState(() => currentItems.add({"material": null, "availableQty": "0.00", "quantity": "1", "unit": "N/A"})),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text("Add Item"),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
                    )
                  ],
                ),
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
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
                int index = entry.key;
                Map<String, dynamic> item = entry.value;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 40, child: Text("${index + 1}", style: const TextStyle(fontSize: 13))),
                      Expanded(flex: 4, child: _buildFormInput("Select a material...", isDropdown: !isEdit, initialValue: item['material'], value: item["material"], dropdownItems: _materialList, onChanged: (v) => setState(() => item["material"] = v))),
                      const SizedBox(width: 15),
                      Expanded(flex: 2, child: _buildFormInput("0.00", isReadOnly: true, initialValue: item['availableQty'])),
                      const SizedBox(width: 15),
                      Expanded(flex: 2, child: _buildFormInput("1", initialValue: item['quantity'])),
                      const SizedBox(width: 15),
                      Expanded(flex: 2, child: _buildFormInput("N/A", isReadOnly: true, bgColor: Colors.grey.shade100, initialValue: item['unit'])),
                      const SizedBox(width: 15),
                      Container(
                        height: 38, width: 38,
                        decoration: BoxDecoration(border: Border.all(color: Colors.red.withOpacity(0.3)), borderRadius: BorderRadius.circular(4)),
                        child: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18), 
                          padding: EdgeInsets.zero, 
                          onPressed: () {
                            setState(() {
                              if (currentItems.length > 1) {
                                currentItems.removeAt(index);
                              }
                            });
                          }
                        ),
                      )
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
            ElevatedButton(
              onPressed: onBack,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
              child: const Text("Cancel"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => setState(() => _currentView = 0),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
              child: Text(isEdit ? "Update Order" : "Save Order", style: const TextStyle(fontWeight: FontWeight.bold)),
            )
          ],
        )
      ],
    );
  }

  // --- HELPERS ---

  Widget _buildPagination() {
    int totalPages = (_orders.length / _itemsPerPage).ceil();
    if (totalPages <= 1) return const SizedBox.shrink();

    List<Widget> pageButtons = [];
    pageButtons.add(_pageBox("Prev", false, () { if (_currentPage > 1) setState(() => _currentPage--); }));
    pageButtons.add(const SizedBox(width: 5));

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(_pageBox("$i", _currentPage == i, () { setState(() => _currentPage = i); }));
      if (i < totalPages) pageButtons.add(const SizedBox(width: 5));
    }

    pageButtons.add(const SizedBox(width: 5));
    pageButtons.add(_pageBox("Next", false, () { if (_currentPage < totalPages) setState(() => _currentPage++); }));

    return Padding(
      padding: const EdgeInsets.all(16.0), 
      child: Wrap(alignment: WrapAlignment.center, spacing: 2, runSpacing: 8, children: pageButtons)
    );
  }

  Widget _pageBox(String t, bool active, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 
      decoration: BoxDecoration(color: active ? Colors.blue : Colors.white, border: Border.all(color: active ? Colors.blue : Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), 
      child: Text(t, style: TextStyle(color: active ? Colors.white : Colors.blue, fontSize: 13, fontWeight: FontWeight.bold))
    ),
  );

  void _showWhatsAppOptionsDialog(BuildContext context) {
    bool allMaterial = true;
    bool bakery = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              backgroundColor: Colors.white,
              child: Container(
                width: 350,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.chat_bubble_outline, size: 18, color: Color(0xFF198754)),
                            SizedBox(width: 8),
                            Text("WhatsApp Options", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ],
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close, size: 18, color: Colors.grey),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(color: Colors.grey.shade200),
                    const SizedBox(height: 15),

                    const Text("Select Material Types:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                    const SizedBox(height: 15),
                    _buildCheckbox("All Material Types", allMaterial, (v) => setState(() => allMaterial = v ?? false)),
                    _buildCheckbox("BAKERY", bakery, (v) => setState(() => bakery = v ?? false)),

                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), foregroundColor: Colors.black87),
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.send, size: 14),
                          label: const Text("Send"),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFF8BB86), width: 4)), child: const Center(child: Text("!", style: TextStyle(fontSize: 50, color: Color(0xFFF8BB86), fontWeight: FontWeight.w300)))),
                const SizedBox(height: 25),
                const Text("Delete Order?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 10),
                const Text("You won't be able to revert this!", style: TextStyle(fontSize: 14, color: Color(0xFF545454)), textAlign: TextAlign.center),
                const SizedBox(height: 30),
                Wrap(
                  alignment: WrapAlignment.center, spacing: 10, runSpacing: 10, 
                  children: [
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC3545), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))), onPressed: () => Navigator.pop(context), child: const Text("Yes, delete it!", style: TextStyle(color: Colors.white, fontSize: 14))),
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007BFF), elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))), onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 14))),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void _showPrintOptionsDialog(BuildContext context) {
    String printFormat = "A4 (Normal)";
    bool allMaterial = true;
    bool bakery = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              backgroundColor: Colors.white,
              child: Container(
                width: 450,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.print_outlined, size: 18),
                            SizedBox(width: 8),
                            Text("Print Options", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close, size: 18, color: Colors.grey),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(color: Colors.grey.shade200),
                    const SizedBox(height: 10),

                    const Text("Print Format:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildRadio("A4 (Normal)", printFormat, (v) => setState(() => printFormat = v.toString())),
                        const SizedBox(width: 20),
                        _buildRadio("80mm (Thermal)", printFormat, (v) => setState(() => printFormat = v.toString())),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Divider(color: Colors.grey.shade200),
                    const SizedBox(height: 15),

                    const Text("Select Material Types:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                    const SizedBox(height: 15),
                    _buildCheckbox("All Material Types", allMaterial, (v) => setState(() => allMaterial = v ?? false)),
                    _buildCheckbox("BAKERY", bakery, (v) => setState(() => bakery = v ?? false)),

                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), foregroundColor: Colors.black87),
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.print, size: 16),
                          label: const Text("Print"),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }

  Widget _buildRadio(String title, String groupValue, ValueChanged onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(value: title, groupValue: groupValue, onChanged: onChanged, activeColor: const Color(0xFF0D6EFD), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: const VisualDensity(horizontal: -4, vertical: -4)),
        const SizedBox(width: 5),
        Text(title, style: const TextStyle(fontSize: 13, color: Colors.black87)),
      ],
    );
  }

  Widget _buildCheckbox(String title, bool value, ValueChanged<bool?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 18, width: 18, child: Checkbox(value: value, onChanged: onChanged, activeColor: const Color(0xFF0D6EFD), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)), side: BorderSide(color: Colors.grey.shade400, width: 1.5))),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, String hint, {bool isDropdown = false, bool isDate = false, String? value, List<String>? dropdownItems, ValueChanged<String?>? onChanged, String? initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
        const SizedBox(height: 8),
        _buildFormInput(hint, isDropdown: isDropdown, isDate: isDate, value: value, dropdownItems: dropdownItems, onChanged: onChanged, initialValue: initialValue),
      ],
    );
  }

  Widget _buildFormInput(String hint, {bool isDropdown = false, bool isDate = false, bool isReadOnly = false, Color? bgColor, String? value, List<String>? dropdownItems, ValueChanged<String?>? onChanged, String? initialValue}) {
    return Container(
      height: 38,
      decoration: BoxDecoration(color: bgColor ?? Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
      child: isDropdown 
        ? DropdownButtonHideUnderline(
            child: DropdownButton<String>(isExpanded: true, padding: const EdgeInsets.symmetric(horizontal: 12), hint: Text(hint, style: const TextStyle(fontSize: 13, color: Colors.grey)), icon: const Icon(Icons.keyboard_arrow_down, size: 16), value: value,
              items: dropdownItems?.map((String item) => DropdownMenuItem<String>(value: item, child: Text(item, style: const TextStyle(fontSize: 13, color: Colors.black87)))).toList() ?? [], 
              onChanged: onChanged,
            )
          )
        : TextFormField(
            initialValue: initialValue,
            readOnly: isReadOnly || isDate,
            decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(fontSize: 13, color: isReadOnly ? Colors.black87 : Colors.grey), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), border: InputBorder.none, suffixIcon: isDate ? const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black87) : null),
          ),
    );
  }

  Widget _buildFilterDropdown(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black87)),
        const SizedBox(width: 10),
        Container(
          width: 180, height: 38, padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(value: value, isExpanded: true, icon: const Icon(Icons.keyboard_arrow_down, size: 16), style: const TextStyle(fontSize: 13, color: Colors.black87), items: [DropdownMenuItem(value: value, child: Text(value))], onChanged: (v) {}),
          ),
        )
      ],
    );
  }
  
  Widget _buildFilterDate(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black87)),
        const SizedBox(width: 10),
        Container(
          width: 130, height: 38, padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(value, style: const TextStyle(fontSize: 13, color: Colors.black87)), const Icon(Icons.calendar_today_outlined, size: 14, color: Colors.black87)]),
        )
      ],
    );
  }
}