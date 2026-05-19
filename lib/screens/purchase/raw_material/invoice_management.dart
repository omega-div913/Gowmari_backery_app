import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/components/app_sidebar.dart';
import 'subsidebar.dart';

class InvoiceManagementPage extends StatefulWidget {
  const InvoiceManagementPage({super.key});

  @override
  State<InvoiceManagementPage> createState() => _InvoiceManagementPageState();
}

class _InvoiceManagementPageState extends State<InvoiceManagementPage> {
  // Filter States & Controllers
  late TextEditingController _vendorController;
  late TextEditingController _fromDateController;
  late TextEditingController _toDateController;

  // Pagination State
  int _currentPage = 1;
  final int _rowsPerPage = 9;

  // Dummy Data mimicking the screenshot (expanded for pagination)
  final List<Map<String, dynamic>> _invoiceData = [
    {"inv": "4709", "vendor": "VISWA FOODS", "date": "18-05-2026", "total": "₹14799.83"},
    {"inv": "4708", "vendor": "VISWA FOODS", "date": "18-05-2026", "total": "₹12598.92"},
    {"inv": "83", "vendor": "PRAKASH (NB)", "date": "18-05-2026", "total": "₹1350.00"},
    {"inv": "82", "vendor": "PRAKASH ( NRT )", "date": "18-05-2026", "total": "₹530.00"},
    {"inv": "82", "vendor": "PRAKASH ( B.BUN )", "date": "18-05-2026", "total": "₹180.00"},
    {"inv": "PUR-202605-0178", "vendor": "PRAKASH ( KITCHEN )", "date": "18-05-2026", "total": "₹1260.00"},
    {"inv": "PUR-202605-0177", "vendor": "PRAKASH ( KARAM )", "date": "18-05-2026", "total": "₹985.00"},
    {"inv": "PUR-202605-0176", "vendor": "PRAKASH ( BAKERY )", "date": "18-05-2026", "total": "₹2255.00"},
    {"inv": "PUR-202605-0175", "vendor": "K.R.BUTTER GHEE STORE", "date": "18-05-2026", "total": "₹45500.00"},
    {"inv": "48", "vendor": "MEENACHI MILK KOVA", "date": "18-05-2026", "total": "₹16537.50"},
    {"inv": "PUR-202605-0174", "vendor": "HARIHARAN TRADERS", "date": "18-05-2026", "total": "₹16765.00"},
    {"inv": "PUR-202605-0173", "vendor": "SATHURAGIRI EGG", "date": "18-05-2026", "total": "₹20280.00"},
    {"inv": "4707", "vendor": "VISWA FOODS", "date": "17-05-2026", "total": "₹9500.00"},
    {"inv": "4706", "vendor": "ANNACHI PROVISIONS", "date": "17-05-2026", "total": "₹3450.75"},
  ];

  @override
  void initState() {
    super.initState();
    _vendorController = TextEditingController(text: "All Vendors");
    _fromDateController = TextEditingController(text: "18-05-2026");
    _toDateController = TextEditingController(text: "18-05-2026");
  }

  @override
  void dispose() {
    _vendorController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: AppSidebar(activeMenu: "Raw Material")) : null,
      appBar: isMobile
          ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Invoice Management", style: TextStyle(color: Colors.black, fontSize: 16)))
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const AppSidebar(activeMenu: "Raw Material"),
          Expanded(
            child: Column(
              children: [
                if (!isMobile)
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))),
                    child: Row(children: [
                      const Icon(Icons.menu, color: Colors.grey, size: 20),
                      const SizedBox(width: 15),
                      const Text("Home / Purchase Section / Raw Material", style: TextStyle(color: Colors.black54, fontSize: 13)),
                      const Spacer(),
                      Container(width: 300, height: 35, decoration: BoxDecoration(color: const Color(0xFFF4F7FE), borderRadius: BorderRadius.circular(20)), child: const TextField(decoration: InputDecoration(hintText: "Search menus ( Press / )", hintStyle: TextStyle(fontSize: 13, color: Colors.grey), prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 10)))),
                      const SizedBox(width: 20),
                      Container(width: 35, height: 35, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle), child: const Center(child: Text("R", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      const SizedBox(width: 10),
                      const Text("RTS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const Icon(Icons.arrow_drop_down, color: Colors.black)
                    ]),
                  ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (MediaQuery.of(context).size.width > 850) const SizedBox(width: 260, child: RawMaterialSubSidebar(activePage: 'Invoice Management')),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(25),
                            child: _buildMainContent(),
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

  Widget _buildMainContent() {
    final int totalPages = (_invoiceData.length / _rowsPerPage).ceil();
    final int startIndex = (_currentPage - 1) * _rowsPerPage;
    final int endIndex = startIndex + _rowsPerPage > _invoiceData.length ? _invoiceData.length : startIndex + _rowsPerPage;
    final List<Map<String, dynamic>> currentData = _invoiceData.sublist(startIndex, endIndex);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Invoice Management", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.end,
            children: [
              _buildFilterTextField("Vendor", _vendorController, flex: 3),
              _buildFilterDateField("From Date", _fromDateController, context, flex: 2),
              _buildFilterDateField("To Date", _toDateController, context, flex: 2),
              SizedBox(
                height: 38,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _vendorController.text = "All Vendors";
                      _fromDateController.text = "18-05-2026";
                      _toDateController.text = "18-05-2026";
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C757D), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), padding: const EdgeInsets.symmetric(horizontal: 30)),
                  child: const Text("Reset", style: TextStyle(fontSize: 13)),
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
            children: [
              LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: constraints.maxWidth < 900 ? 900 : constraints.maxWidth,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(color: const Color(0xFFF8F9FA), border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                          child: const Row(
                            children: [
                              Expanded(flex: 1, child: Text("S.No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87))),
                              Expanded(flex: 3, child: Text("Invoice No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87))),
                              Expanded(flex: 4, child: Text("Vendor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87))),
                              Expanded(flex: 3, child: Text("Purchase Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87))),
                              Expanded(flex: 2, child: Text("Invoice Total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87), textAlign: TextAlign.right)),
                              Expanded(flex: 1, child: Text("View", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87), textAlign: TextAlign.center)),
                            ],
                          ),
                        ),
                        ...currentData.asMap().entries.map((entry) {
                          int index = entry.key;
                          var data = entry.value;
                          int serialNumber = startIndex + index + 1;
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                            child: Row(
                              children: [
                                Expanded(flex: 1, child: Text(serialNumber.toString(), style: const TextStyle(fontSize: 13, color: Colors.black87))),
                                Expanded(flex: 3, child: Text(data["inv"], style: const TextStyle(fontSize: 13, color: Colors.black87))),
                                Expanded(flex: 4, child: Text(data["vendor"], style: const TextStyle(fontSize: 13, color: Colors.black87))),
                                Expanded(flex: 3, child: Text(data["date"], style: const TextStyle(fontSize: 13, color: Colors.black87))),
                                Expanded(flex: 2, child: Text(data["total"], style: const TextStyle(fontSize: 13, color: Colors.black87), textAlign: TextAlign.right)),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: InkWell(
                                      onTap: () => _showInvoiceDialog(context, data),
                                      child: const Icon(Icons.add_circle, color: Colors.blue, size: 22),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                );
              }),
              _buildPaginationControls(totalPages),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPaginationControls(int totalPages) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Showing ${(_currentPage - 1) * _rowsPerPage + 1} to ${(_currentPage * _rowsPerPage > _invoiceData.length) ? _invoiceData.length : _currentPage * _rowsPerPage} of ${_invoiceData.length} entries",
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          Row(
            children: [
              TextButton(
                onPressed: _currentPage > 1
                    ? () {
                        setState(() {
                          _currentPage--;
                        });
                      }
                    : null,
                child: const Text("Previous"),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text("$_currentPage", style: const TextStyle(fontSize: 13)),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: _currentPage < totalPages
                    ? () {
                        setState(() {
                          _currentPage++;
                        });
                      }
                    : null,
                child: const Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTextField(String label, TextEditingController controller, {required int flex}) {
    return SizedBox(
      width: 200, // Fixed width for wrap layout
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
          const SizedBox(height: 8),
          SizedBox(
            height: 38,
            child: TextFormField(
              controller: controller,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDateField(String label, TextEditingController controller, BuildContext context, {required int flex}) {
    return SizedBox(
      width: 150, // Fixed width for wrap layout
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _selectDate(context, controller),
            child: AbsorbPointer(
              child: SizedBox(
                height: 38,
                child: TextFormField(
                  controller: controller,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black54),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // UPDATED: Manually formatting date without intl package
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));
    
    if (picked != null) {
      setState(() {
        // PadLeft ensures single digits have a '0' in front (e.g., 5 becomes 05)
        String day = picked.day.toString().padLeft(2, '0');
        String month = picked.month.toString().padLeft(2, '0');
        String year = picked.year.toString();
        
        controller.text = "$day-$month-$year";
      });
    }
  }

  void _showInvoiceDialog(BuildContext context, Map<String, dynamic> invoiceData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dialog Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Invoice Document", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      ElevatedButton.icon(
                        onPressed: () {}, // Add print logic here
                        icon: const Icon(Icons.print, size: 16),
                        label: const Text("Print Invoice"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                // Dialog Body
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(30),
                    child: _buildInvoiceContent(invoiceData),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInvoiceContent(Map<String, dynamic> invoiceData) {
    const boldStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 13);
    const regularStyle = TextStyle(fontSize: 13, color: Colors.black87);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("HEAD OFFICE:", style: regularStyle.copyWith(fontWeight: FontWeight.bold)),
                const Text("SRI GOWMARIAMMAN F.P.L", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("Address Not Set", style: regularStyle),
              ],
            ),
            const Text("INVOICE", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [const Text("INV. NO. : ", style: boldStyle), Text("3496", style: regularStyle)]),
                const SizedBox(height: 4),
                Row(children: [const Text("DATE : ", style: boldStyle), Text("15-05-2026", style: regularStyle)]),
                const SizedBox(height: 4),
                Row(children: [const Text("BATCH : ", style: boldStyle), Text("RB260515-03", style: regularStyle)]),
              ],
            ),
          ],
        ),
        const Divider(height: 40),
        // To Section
        Text("To:", style: regularStyle.copyWith(fontWeight: FontWeight.bold)),
        Text(invoiceData['vendor'] ?? "VISWA FOODS (NB)", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 25),
        // Items Table
        Table(
          border: TableBorder.all(color: Colors.grey.shade300, width: 1),
          columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth(4), 2: FlexColumnWidth(1), 3: FlexColumnWidth(1.2), 4: FlexColumnWidth(1), 5: FlexColumnWidth(1.2)},
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              children: ["SI No", "Description", "QTY", "RATE", "Tax %", "Amount"].map((h) => Padding(padding: const EdgeInsets.all(10), child: Text(h, style: boldStyle))).toList(),
            ),
            TableRow(
              children: [
                const Padding(padding: EdgeInsets.all(10), child: Text("1", style: regularStyle)),
                const Padding(padding: EdgeInsets.all(10), child: Text("IC BP Butter Scotch 5 Lit.", style: regularStyle)),
                const Padding(padding: EdgeInsets.all(10), child: Text("1 nos", style: regularStyle)),
                const Padding(padding: EdgeInsets.all(10), child: Text("610.42", style: regularStyle, textAlign: TextAlign.right)),
                const Padding(padding: EdgeInsets.all(10), child: Text("5%", style: regularStyle, textAlign: TextAlign.right)),
                const Padding(padding: EdgeInsets.all(10), child: Text("640.94", style: regularStyle, textAlign: TextAlign.right)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Footer Section
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bank Details
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("BANK Details,", style: boldStyle),
                  const SizedBox(height: 5),
                  Text("STATE BANK OF INDIA,", style: regularStyle),
                  Text("A/C NO 36367296645", style: regularStyle),
                  Text("IFSC CODE SBIN0004059", style: regularStyle),
                  Text("RAJAPALAYAM", style: regularStyle),
                ],
              ),
            ),
            // Totals
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _buildTotalRow("Sub Total", "610.42"),
                  const Divider(height: 10),
                  _buildTotalRow("CGST", "15.26"),
                  const Divider(height: 10),
                  _buildTotalRow("SGST", "15.26"),
                  const Divider(thickness: 1.5, height: 20, color: Colors.black),
                  _buildTotalRow("Total", "640.94", isBold: true),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),
        // Signature
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                const SizedBox(width: 200, child: Divider(color: Colors.black)),
                const SizedBox(height: 5),
                Text("Authorized Signatory", style: regularStyle),
                const SizedBox(height: 5),
                Text("For SRI GOWMARIAMMAN F.P.L", style: boldStyle),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, String value, {bool isBold = false}) {
    final style = TextStyle(fontSize: 13, fontWeight: isBold ? FontWeight.bold : FontWeight.normal);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }
}