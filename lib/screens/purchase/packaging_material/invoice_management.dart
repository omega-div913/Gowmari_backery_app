import 'package:flutter/material.dart';
import 'dart:math';

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
  // Pagination State Variables
  int _currentPage = 1;
  int _rowsPerPage = 10;

  final List<InvoiceData> _invoices = [
    InvoiceData('2', 'Testvendors', '15 May, 2026', '₹10.50'),
    InvoiceData('3', 'Vendor A', '16 May, 2026', '₹20.00'),
    InvoiceData('4', 'Vendor B', '17 May, 2026', '₹35.00'),
    InvoiceData('5', 'Vendor C', '18 May, 2026', '₹40.50'),
    InvoiceData('6', 'Vendor D', '19 May, 2026', '₹15.20'),
  ];

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
          Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          TextFormField(
            initialValue: hint,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: hasIcon ? const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF64748B)) : null,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF0D6EFD)))),
          ),
        ],
      ),
    );
    
  Widget _buildInvoiceFilterDropdown(String label, String value) => SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          DropdownButtonFormField(
            value: value,
            isDense: true,
            icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF64748B)),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color(0xFF0D6EFD)))),
            items: [DropdownMenuItem(value: value, child: Text(value, style: const TextStyle(fontSize: 14)))],
            onChanged: (newValue) {},
          ),
        ],
      ),
    );

  @override
  Widget build(BuildContext context) {
    // Pagination Calculations
    int totalItems = _invoices.length;
    int totalPages = (totalItems / _rowsPerPage).ceil();
    int startIndex = (_currentPage - 1) * _rowsPerPage;
    int endIndex = min(startIndex + _rowsPerPage, totalItems);
    List<InvoiceData> paginatedEntries = _invoices.sublist(startIndex, endIndex);

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
                  Text("View and manage packaging invoices.", style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8))),
                ]
              ),
              Container(
                width: 300,
                height: 40,
                decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(20)),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search by vendor, invoice no...",
                    hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                    prefixIcon: Icon(Icons.search, color: Color(0xFF94A3B8), size: 18),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ]
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE2E8F0)), 
              borderRadius: BorderRadius.circular(8)
            ),
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
                        backgroundColor: const Color(0xFF64748B),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                    child: const Text("Reset", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 25),
          
          // Custom Modern Grid (Table)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(60),
                    1: FlexColumnWidth(1.2),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(1.5),
                    4: FlexColumnWidth(1.5),
                    5: FixedColumnWidth(100), // Fixed width for actions
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    // Header Row
                    TableRow(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
                      ),
                      children: [
                        _buildCustomHeaderCell('S.NO'),
                        _buildCustomHeaderCell('INVOICE NO'),
                        _buildCustomHeaderCell('VENDOR'),
                        _buildCustomHeaderCell('PURCHASE DATE'),
                        _buildCustomHeaderCell('INVOICE TOTAL'),
                        _buildCustomHeaderCell('VIEW'),
                      ]
                    ),
                    // Data Rows
                    ...paginatedEntries.asMap().entries.map((mapEntry) {
                      int index = mapEntry.key;
                      InvoiceData inv = mapEntry.value;

                      return TableRow(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: index == paginatedEntries.length - 1 ? Colors.transparent : const Color(0xFFF1F5F9))),
                        ),
                        children: [
                          _buildCustomDataCell((startIndex + index + 1).toString()),
                          _buildCustomDataCell(inv.invoiceNo),
                          _buildCustomDataCell(inv.vendor),
                          _buildCustomDataCell(inv.purchaseDate),
                          _buildCustomDataCell(inv.invoiceTotal),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: _buildActionIcon(Icons.arrow_forward_ios, const Color(0xFF2563EB), () => _showInvoiceDialog(context)),
                            ),
                          )
                        ]
                      );
                    }),
                  ],
                ),
                // Custom Modern Pagination Footer
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                    border: Border(top: BorderSide(color: Color(0xFFE2E8F0)))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Showing ${totalItems == 0 ? 0 : startIndex + 1} to $endIndex of $totalItems entries",
                        style: const TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500)
                      ),
                      Row(
                        children: [
                          const Text("Rows per page: ", style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                          const SizedBox(width: 8),
                          Container(
                            height: 32,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                              borderRadius: BorderRadius.circular(6)
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: _rowsPerPage,
                                icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF64748B)),
                                style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B), fontWeight: FontWeight.w500),
                                items: [5, 10, 20, 50].map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    _rowsPerPage = newValue!;
                                    _currentPage = 1; // Reset to first page
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Prev Page Button
                          InkWell(
                            onTap: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: _currentPage > 1 ? Colors.white : const Color(0xFFF1F5F9),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Icon(Icons.chevron_left, size: 18, color: _currentPage > 1 ? const Color(0xFF1E293B) : const Color(0xFF94A3B8)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text("Page $_currentPage of ${totalPages == 0 ? 1 : totalPages}", style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B), fontWeight: FontWeight.w500)),
                          const SizedBox(width: 12),
                          // Next Page Button
                          InkWell(
                            onTap: _currentPage < totalPages ? () => setState(() => _currentPage++) : null,
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: _currentPage < totalPages ? Colors.white : const Color(0xFFF1F5F9),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Icon(Icons.chevron_right, size: 18, color: _currentPage < totalPages ? const Color(0xFF1E293B) : const Color(0xFF94A3B8)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF64748B), letterSpacing: 0.5)),
    );
  }

  Widget _buildCustomDataCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        text, 
        style: const TextStyle(
          fontSize: 13, 
          fontWeight: FontWeight.w500, 
          color: Color(0xFF1E293B)
        )
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, Color iconColor, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.circular(6)
        ),
        child: Icon(icon, color: iconColor, size: 14)
      ),
    );
  }
}