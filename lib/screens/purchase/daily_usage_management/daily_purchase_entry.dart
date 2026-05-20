import 'package:flutter/material.dart';
import '../../components/app_sidebar.dart';
import 'subsidebar.dart';

class DailyPurchaseEntryPage extends StatefulWidget {
  const DailyPurchaseEntryPage({super.key});

  @override
  State<DailyPurchaseEntryPage> createState() => _DailyPurchaseEntryPageState();
}

class _DailyPurchaseEntryPageState extends State<DailyPurchaseEntryPage> {
  // --- Form State ---
  final List<Map<String, dynamic>> _purchaseItems = [];

  void _addItem() {
    setState(() {
      _purchaseItems.add({
        "material": "",
        "qty": "1",
        "unit": "N/A",
        "price": "0",
        "total": "0.00"
      });
    });
  }

  void _removeItem(int index) {
    setState(() {
      _purchaseItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F9),
      body: Row(
        children: [
          // MAIN SIDEBAR
          const AppSidebar(activeMenu: "Daily Usage Management"),
          
          Expanded(
            child: Column(
              children: [
                // HEADER
                _buildExactHeader(),
                
                // MAIN CONTENT AREA
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SUB-SIDEBAR
                      const DailyUsageSubSidebar(activePage: "Daily Usage Purchase"),
                      
                      // PAGE CONTENT
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPageHeader(),
                              const SizedBox(height: 25),
                              
                              // CARD 1: INVOICE DETAILS
                              _buildInvoiceDetailsCard(),
                              const SizedBox(height: 25),
                              
                              // CARD 2: PURCHASE ITEMS
                              _buildPurchaseItemsCard(),
                              const SizedBox(height: 25),
                              
                              // CARD 3 & 4: PAYMENT AND SUMMARY (Side by Side)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _buildInitialPaymentCard()),
                                  const SizedBox(width: 25),
                                  Expanded(child: _buildInvoiceSummaryCard()),
                                ],
                              ),
                              const SizedBox(height: 25),
                              
                              // FOOTER ACTIONS
                              _buildFooterActions(),
                              const SizedBox(height: 40),
                            ],
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

  // --- TOP HEADER ---
  Widget _buildExactHeader() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Color(0xFF64748B), size: 20),
          const SizedBox(width: 20),
          const Text(
            "Home / Purchase Section / Daily Usage Management / Purchase",
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
          ),
          const Spacer(),
          Container(
            width: 300,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search menus ( Press / )",
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 6),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF0D6EFD),
            child: Text("R", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          const Text("RTS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const Icon(Icons.arrow_drop_down, size: 20),
        ],
      ),
    );
  }

  // --- PAGE TITLE ---
  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Daily Purchase Entry", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        SizedBox(height: 4),
        Text("Items entered here will be added to stock.", style: TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  // --- INVOICE DETAILS CARD ---
  Widget _buildInvoiceDetailsCard() {
    return _buildSectionCard(
      title: "Invoice Details",
      child: Row(
        children: [
          Expanded(child: _formField("Vendor *", "Select a vendor...", isSearch: true)),
          const SizedBox(width: 15),
          Expanded(child: _formField("Link Purchase Order", "Manual Entry (No PO)")),
          const SizedBox(width: 15),
          Expanded(child: _formField("Invoice Number", "Optional (Auto-generated if blank)")),
          const SizedBox(width: 15),
          Expanded(child: _formField("Purchase Date *", "20-05-2026", isDate: true)),
        ],
      ),
    );
  }

  // --- PURCHASE ITEMS CARD ---
  Widget _buildPurchaseItemsCard() {
    return _buildSectionCard(
      title: "Purchase Items",
      action: ElevatedButton.icon(
        onPressed: _addItem,
        icon: const Icon(Icons.add, size: 16),
        label: const Text("Add Item"),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0D6EFD),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      child: _purchaseItems.isEmpty ? _buildEmptyItemsState() : _buildItemsTable(),
    );
  }

  Widget _buildEmptyItemsState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(Icons.shopping_cart_outlined, size: 40, color: Colors.grey.shade400),
          const SizedBox(height: 10),
          Text("Click \"Add Item\" to start adding purchase items.", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildItemsTable() {
    return Column(
      children: [
        // Table Header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
          child: Row(
            children: const [
              Expanded(flex: 4, child: Text("Raw Material", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E293B)))),
              SizedBox(width: 10),
              Expanded(flex: 1, child: Text("Qty", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E293B)))),
              SizedBox(width: 10),
              Expanded(flex: 2, child: Text("Unit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E293B)))),
              SizedBox(width: 10),
              Expanded(flex: 2, child: Text("Price/Unit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E293B)))),
              SizedBox(width: 10),
              Expanded(flex: 2, child: Text("Item Total", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E293B)))),
              SizedBox(width: 40), // Space for delete icon
            ],
          ),
        ),
        // Table Rows
        ..._purchaseItems.asMap().entries.map((entry) {
          int index = entry.key;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              children: [
                Expanded(flex: 4, child: _tableInput("Select material...", isSearch: true)),
                const SizedBox(width: 10),
                Expanded(flex: 1, child: _tableInput("1")),
                const SizedBox(width: 10),
                Expanded(flex: 2, child: _tableInput("N/A", isReadOnly: true)),
                const SizedBox(width: 10),
                Expanded(flex: 2, child: _tableInput("0")),
                const SizedBox(width: 10),
                Expanded(flex: 2, child: Container(alignment: Alignment.centerRight, child: const Text("₹0.00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)))),
                const SizedBox(width: 10),
                SizedBox(
                  width: 30,
                  child: IconButton(
                    onPressed: () => _removeItem(index),
                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  // --- INITIAL PAYMENT CARD ---
  Widget _buildInitialPaymentCard() {
    return _buildSectionCard(
      title: "Initial Payment",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Paid Amount", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Padding(padding: EdgeInsets.all(12), child: Text("₹", style: TextStyle(fontSize: 14, color: Colors.grey))),
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              hintText: "0",
              hintStyle: const TextStyle(fontSize: 13, color: Colors.black87),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade200)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade200)),
            ),
          ),
        ],
      ),
    );
  }

  // --- INVOICE SUMMARY CARD ---
  Widget _buildInvoiceSummaryCard() {
    return _buildSectionCard(
      title: "Invoice Summary",
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Grand Total", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text("₹0.00", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Balance Due", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("₹0.00", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- FOOTER BUTTONS ---
  Widget _buildFooterActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade500,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: const Text("Reset Form"),
        ),
        const SizedBox(width: 15),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.print_outlined, size: 16),
          label: const Text("Print Bill"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey.shade700,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            side: BorderSide(color: Colors.grey.shade300),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
        const SizedBox(width: 15),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D6EFD),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: const Text("Save Purchase & Add to Stock", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  // --- REUSABLE UI HELPERS ---

  Widget _buildSectionCard({required String title, required Widget child, Widget? action}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                if (action != null) action,
              ],
            ),
          ),
          // Card Body
          Padding(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _formField(String label, String hint, {bool isDate = false, bool isSearch = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
        const SizedBox(height: 8),
        TextField(
          readOnly: isDate,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
            suffixIcon: isDate ? const Icon(Icons.calendar_month, size: 16) : (isSearch ? const Icon(Icons.search, size: 16) : null),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade200)),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _tableInput(String hint, {bool isReadOnly = false, bool isSearch = false}) {
    return TextField(
      readOnly: isReadOnly,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 13, color: isReadOnly || hint != "Select material..." ? Colors.black87 : Colors.grey),
        prefixIcon: isSearch ? const Icon(Icons.search, size: 16, color: Colors.grey) : null,
        prefixIconConstraints: isSearch ? const BoxConstraints(minWidth: 35, minHeight: 35) : null,
        filled: true,
        fillColor: isReadOnly ? const Color(0xFFF8FAFC) : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade200)),
      ),
    );
  }
}