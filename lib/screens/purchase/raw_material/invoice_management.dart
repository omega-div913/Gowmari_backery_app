import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/components/app_sidebar.dart';
import 'subsidebar.dart';

class InvoiceManagementPage extends StatefulWidget {
  const InvoiceManagementPage({super.key});

  @override
  State<InvoiceManagementPage> createState() => _InvoiceManagementPageState();
}

class _InvoiceManagementPageState extends State<InvoiceManagementPage> {
  // Filter States
  String _vendorSearch = "All Vendors";
  String _fromDate = "18-05-2026";
  String _toDate = "18-05-2026";

  // Dummy Data mimicking the screenshot
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
  ];

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
                // TOP NAV BAR (Consistent with the app shell)
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
                
                // MAIN BODY WITH SUB-SIDEBAR
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (MediaQuery.of(context).size.width > 850) 
                        const SizedBox(width: 260, child: RawMaterialSubSidebar(activePage: 'Invoice Management')),
                      
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Page Title
        const Text("Invoice Management", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 25),

        // Filter Section
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(flex: 3, child: _buildFilterInput("Vendor", _vendorSearch, isDropdown: true)),
              const SizedBox(width: 20),
              Expanded(flex: 2, child: _buildFilterInput("From Date", _fromDate, isDate: true)),
              const SizedBox(width: 20),
              Expanded(flex: 2, child: _buildFilterInput("To Date", _toDate, isDate: true)),
              const SizedBox(width: 20),
              // Reset Button
              SizedBox(
                height: 38,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _vendorSearch = "All Vendors";
                      _fromDate = "18-05-2026";
                      _toDate = "18-05-2026";
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

        // Data Table Section
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: constraints.maxWidth < 900 ? 900 : constraints.maxWidth,
                  child: Column(
                    children: [
                      // Header Row
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(color: const Color(0xFFF8F9FA), border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
                        child: const Row(
                          children: [
                            Expanded(flex: 3, child: Text("Invoice No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87))),
                            Expanded(flex: 4, child: Text("Vendor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87))),
                            Expanded(flex: 3, child: Text("Purchase Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87))),
                            Expanded(flex: 2, child: Text("Invoice Total", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87), textAlign: TextAlign.right)),
                            Expanded(flex: 1, child: Text("View", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87), textAlign: TextAlign.center)),
                          ],
                        ),
                      ),
                      
                      // Data Rows
                      ..._invoiceData.map((data) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                          child: Row(
                            children: [
                              Expanded(flex: 3, child: Text(data["inv"], style: const TextStyle(fontSize: 13, color: Colors.black87))),
                              Expanded(flex: 4, child: Text(data["vendor"], style: const TextStyle(fontSize: 13, color: Colors.black87))),
                              Expanded(flex: 3, child: Text(data["date"], style: const TextStyle(fontSize: 13, color: Colors.black87))),
                              Expanded(flex: 2, child: Text(data["total"], style: const TextStyle(fontSize: 13, color: Colors.black87), textAlign: TextAlign.right)),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: InkWell(
                                    onTap: () {}, // Add View Action logic here
                                    child: const Icon(Icons.arrow_circle_right_outlined, color: Colors.blue, size: 22),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      
                      // Bottom padding for cleaner look
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            }
          ),
        )
      ],
    );
  }

  // Helper Widget for Modern Filter Inputs
  Widget _buildFilterInput(String label, String hint, {bool isDate = false, bool isDropdown = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
        const SizedBox(height: 8),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hint, style: TextStyle(fontSize: 13, color: (isDate || isDropdown) ? Colors.black87 : Colors.grey)),
              if (isDate) const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black54),
              if (isDropdown) const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black54),
            ],
          ),
        )
      ],
    );
  }
}