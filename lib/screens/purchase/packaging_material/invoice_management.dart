import 'package:flutter/material.dart';

// --- DATA MODEL ---
class InvoiceData {
  final String invoiceNo, vendor, purchaseDate, invoiceTotal;
  InvoiceData(this.invoiceNo, this.vendor, this.purchaseDate, this.invoiceTotal);
}

class InvoiceManagementView extends StatelessWidget {
  const InvoiceManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: const InvoiceManagementDataTable(),
    );
  }
}

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
    _dataSource = _InvoiceDataSource(onView: () => _showInvoiceDialog(context));
  }

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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Invoice Document", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("To print on Windows desktop, you need to implement the 'printing' package."),
                                backgroundColor: Colors.orange,
                              ));
                            },
                            icon: const Icon(Icons.print, size: 16),
                            label: const Text("Print Invoice"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D6EFD),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
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
    // (Existing print layout unchanged as requested)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(
            child: Text("INVOICE",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontFamily: 'Times New Roman'))),
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
                Row(children: const [
                  SizedBox(width: 80, child: Text("INV. NO.", style: TextStyle(fontWeight: FontWeight.bold))),
                  Text(": 3496")
                ]),
                const SizedBox(height: 5),
                Row(children: const [
                  SizedBox(width: 80, child: Text("DATE.", style: TextStyle(fontWeight: FontWeight.bold))),
                  Text(": 15-05-2026")
                ]),
                const SizedBox(height: 5),
                Row(children: const [
                  SizedBox(width: 80, child: Text("BATCH.", style: TextStyle(fontWeight: FontWeight.bold))),
                  Text(": RB260515-03")
                ]),
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
              Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("VISWA FOODS (NB)", style: TextStyle(fontWeight: FontWeight.bold)))
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
                    _gridHeaderCell("Sl\nNo", 1),
                    _gridHeaderCell("Description", 5),
                    _gridHeaderCell("QTY", 1),
                    _gridHeaderCell("RATE", 1.5),
                    _gridHeaderCell("Tax\n%", 1),
                    _gridHeaderCell("Amount", 2, isLast: true),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _gridCell("1", 1, alignCenter: true),
                    _gridCell("IC BP Butter Scotch 5 Lit.", 5),
                    _gridCell("1 nos", 1, alignCenter: true),
                    _gridCell("610.42", 1.5, alignRight: true),
                    _gridCell("5%", 1, alignCenter: true),
                    _gridCell("640.94", 2, alignRight: true, isLast: true, bold: true),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _gridCell("", 1, height: 100), _gridCell("", 5), _gridCell("", 1),
                    _gridCell("", 1.5), _gridCell("", 1), _gridCell("", 2, isLast: true),
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
                        decoration: const BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.black), right: BorderSide(color: Colors.black))),
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
    return Expanded(
        flex: (flex * 10).toInt(),
        child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                border: Border(bottom: const BorderSide(color: Colors.black), right: isLast ? BorderSide.none : const BorderSide(color: Colors.black))),
            alignment: Alignment.center,
            child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center)));
  }
  Widget _gridCell(String text, double flex, {bool isLast = false, bool bold = false, bool alignCenter = false, bool alignRight = false, double? height}) {
    return Expanded(
        flex: (flex * 10).toInt(),
        child: Container(
            height: height,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(border: Border(right: isLast ? BorderSide.none : const BorderSide(color: Colors.black))),
            alignment: alignCenter ? Alignment.center : (alignRight ? Alignment.centerRight : Alignment.centerLeft),
            child: Text(text, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: 13))));
  }
  Widget _totalsRow(String label, String value, {bool isTop = false, bool isLast = false, bool bold = false}) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: isTop ? const BorderSide(color: Colors.black) : BorderSide.none,
                bottom: isLast ? BorderSide.none : const BorderSide(color: Colors.black))),
        child: IntrinsicHeight(
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.black))),
                  child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center))),
          Expanded(
              flex: 2,
              child: Container(
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.centerRight,
                  child: Text(value, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: 13), textAlign: TextAlign.right)))
        ])));
  }

  Widget _buildInvoiceFilterField(String label, String hint, {bool hasIcon = false}) => SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          const SizedBox(height: 5),
          TextFormField(
            initialValue: hint,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.all(12),
                suffixIcon: hasIcon ? const Icon(Icons.calendar_today_outlined, size: 16) : null,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300))),
          ),
        ],
      ),
    );
  Widget _buildInvoiceFilterDropdown(String label, String value) => SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          const SizedBox(height: 5),
          DropdownButtonFormField(
            value: value,
            isDense: true,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey.shade300))),
            items: [DropdownMenuItem(value: value, child: Text(value))],
            onChanged: (newValue) {},
          ),
        ],
      ),
    );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Packaging Invoice Management", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  const SizedBox(height: 4),
                  Text("View and manage packaging invoices.", style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
                ]
              ),
              Container(
                width: 300,
                height: 40,
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search by vendor, invoice no...",
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade500, size: 20),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ]
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
            child: Wrap(
              spacing: 20,
              runSpacing: 15,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                _buildInvoiceFilterDropdown("Vendor", "All Vendors"),
                _buildInvoiceFilterField("From Date", "30-04-2026", hasIcon: true),
                _buildInvoiceFilterField("To Date", "30-05-2026", hasIcon: true),
                SizedBox(
                  height: 38,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C757D),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    child: const Text("Reset", style: TextStyle(fontSize: 15)),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 25),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Theme(
              data: Theme.of(context).copyWith(
                cardColor: Colors.white,
                dividerColor: Colors.transparent,
                cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero, color: Colors.white),
              ),
              child: PaginatedDataTable(
                columns: [
                  DataColumn(label: Text('S.NO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey.shade600))),
                  DataColumn(label: Text('INVOICE NO', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey.shade600))),
                  DataColumn(label: Text('VENDOR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey.shade600))),
                  DataColumn(label: Text('PURCHASE DATE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey.shade600))),
                  DataColumn(label: Text('INVOICE TOTAL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey.shade600))),
                  DataColumn(label: Text('VIEW', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey.shade600))),
                ],
                source: _dataSource,
                rowsPerPage: _rowsPerPage,
                showCheckboxColumn: false,
                onRowsPerPageChanged: (int? value) => setState(() => _rowsPerPage = value!),
              ),
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
      DataCell(InkWell(
        onTap: onView,
        child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
            child: Icon(Icons.arrow_forward_ios, color: Colors.blue.shade600, size: 14)),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _invoices.length;
  @override
  int get selectedRowCount => 0;
}