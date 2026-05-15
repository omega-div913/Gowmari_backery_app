import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/dashboard/dashboard_screen.dart'; // Import to use AppSidebar

class PackagingMaterialPage extends StatefulWidget {
  const PackagingMaterialPage({super.key});

  @override
  State<PackagingMaterialPage> createState() => _PackagingMaterialPageState();
}

class _PackagingMaterialPageState extends State<PackagingMaterialPage> {
  bool _isCreatingNewPurchase = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: AppSidebar()) : null,
      appBar: isMobile ? AppBar(
        backgroundColor: Colors.white, elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(_isCreatingNewPurchase ? "New Purchase Entry" : "Packaging Material",
            style: const TextStyle(color: Colors.black, fontSize: 16)),)
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
                            child: _isCreatingNewPurchase
                                ? SingleChildScrollView(child: _buildNewPurchaseForm())
                                : _buildPurchaseHistoryList(),
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

  Widget _buildTopBar() {
    return Container(
      height: 70, color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey),
          const SizedBox(width: 15),
          const Text("Home / Purchase Section / Packaging Material",
              style: TextStyle(color: Colors.grey, fontSize: 13)),
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
              child: Text("R", style: TextStyle(color: Colors.white))),
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
        mainAxisSize: MainAxisSize.min, // To prevent it from taking full height
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
          _buildOperationItem("Purchase Entry", isActive: true),
          _buildOperationItem("Purchase Order"),
          _buildOperationItem("Invoice Management"),
        ],
      ),
    );
  }

  Widget _buildOperationItem(String title, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {},
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

  // --- WIDGET FOR PURCHASE HISTORY (Overflow Error Fixed) ---
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
                    onPressed: () => setState(() => _isCreatingNewPurchase = true),
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
          
          // ******** RED LETTER ERROR FIX IS HERE ********
          // This will make only the table scroll left and right if it's too wide.
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
          // **********************************

          const Center(
            child: Padding(padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Text("No records found.", style: TextStyle(color: Colors.grey))),
          )
        ],
      ),
    );
  }

  // --- WIDGET FOR NEW PURCHASE ENTRY FORM ---
  Widget _buildNewPurchaseForm() {
    return Container(
      key: const ValueKey('form'),
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
                onPressed: () => setState(() => _isCreatingNewPurchase = false),
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

  // --- HELPER WIDGETS ---
  Widget _buildSectionTitle(String title) => Padding(padding: const EdgeInsets.only(bottom: 15.0), child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),);
  Widget _buildHistoryFilterField(String label, String hint, {bool hasIcon = false}) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)), const SizedBox(height: 5), TextFormField(initialValue: hint, decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(10), suffixIcon: hasIcon ? const Icon(Icons.calendar_today_outlined, size: 16) : null, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300))),), ],),);
  Widget _buildHistoryFilterDropdown(String label, String value) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)), const SizedBox(height: 5), DropdownButtonFormField<String>(value: value, isDense: true, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300))), items: [DropdownMenuItem(value: value, child: Text(value))], onChanged: (newValue) {},), ],),);
  Widget _buildFormTextField(String label, String hint, {bool hasIcon = false}) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 5), TextFormField(initialValue: hint, decoration: InputDecoration(isDense: true, contentPadding: const EdgeInsets.all(12), suffixIcon: hasIcon ? const Icon(Icons.calendar_today_outlined, size: 16) : null, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400))),), ]));
  Widget _buildFormDropdown(String label, String hint) => SizedBox(width: 200, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)), const SizedBox(height: 5), DropdownButtonFormField<String>(hint: Text(hint), isDense: true, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade400))), items: [DropdownMenuItem(value: hint, child: Text(hint))], onChanged: (value) {},), ]));
  Widget _buildItemsTable() => SingleChildScrollView(scrollDirection: Axis.horizontal, child: Table(border: TableBorder.all(color: Colors.grey.shade300), columnWidths: const { 0: IntrinsicColumnWidth(), 1: IntrinsicColumnWidth(), 2: IntrinsicColumnWidth(), 3: IntrinsicColumnWidth(), 4: IntrinsicColumnWidth(), 5: IntrinsicColumnWidth(), 6: IntrinsicColumnWidth(), 7: IntrinsicColumnWidth(), }, children: [TableRow(decoration: BoxDecoration(color: Colors.grey.shade100), children: [ _tableHeader("Raw Material"), _tableHeader("Qty (Kg)"), _tableHeader("Unit/Kg"), _tableHeader("Sub Total"), _tableHeader("Price/Unit"), _tableHeader("GST Type & %"), _tableHeader("GST Amount"), _tableHeader("Item Total"), ]), TableRow(children: [_tableCell(Text("Select...")), _tableCell(Text("1")), _tableCell(Text("1")), _tableCell(Text("0")), _tableCell(Text("₹0.00")), _tableCell(Text("SGST 2.5% CGST 2.5%")), _tableCell(Text("% 0.00")), _tableCell(Text("₹0.00", style: const TextStyle(fontWeight: FontWeight.bold))),]),],),);
  Widget _tableHeader(String text) => Padding(padding: const EdgeInsets.all(10.0), child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)));
  Widget _tableCell(Widget child) => Padding(padding: const EdgeInsets.all(10.0), child: child);
  Widget _buildSummaryRow(String title, String value, {bool isBold = false, bool isLarge = false}) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: TextStyle(fontSize: isLarge ? 15 : 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: Colors.grey.shade800)), Text(value, style: TextStyle(fontSize: isLarge ? 15 : 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: Colors.grey.shade800)),],),);
}