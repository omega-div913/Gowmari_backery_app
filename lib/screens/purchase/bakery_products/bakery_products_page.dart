import 'package:flutter/material.dart';
import '../../components/app_sidebar.dart';
import 'subsidebar.dart';
import 'available_stock.dart';
import 'purchase_entry.dart';

class BakeryProductsPage extends StatefulWidget {
  const BakeryProductsPage({Key? key}) : super(key: key);

  @override
  State<BakeryProductsPage> createState() => _BakeryProductsPageState();
}

class _BakeryProductsPageState extends State<BakeryProductsPage> {
  int _activeTabIndex = 0; // 0 = Stock, 1 = Purchase
  bool _openPurchaseForm = false; // Triggers "Create New Purchase" when coming from Stock

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      drawer: isMobile ? const Drawer(child: AppSidebar()) : null,
      appBar: isMobile 
        ? AppBar(backgroundColor: Colors.white, elevation: 0.5, iconTheme: const IconThemeData(color: Colors.black), title: const Text("Bakery Products", style: TextStyle(color: Colors.black, fontSize: 16))) 
        : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const SizedBox(width: 260, child: AppSidebar()),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) _buildTopBar(),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isMobile) 
                        SubSidebar(
                          activeTabIndex: _activeTabIndex,
                          onTabChanged: (index) {
                            setState(() {
                              _activeTabIndex = index;
                              _openPurchaseForm = false; // Reset create form state when manually clicking tabs
                            });
                          },
                        ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: _activeTabIndex == 0 
                              ? AvailableStock(
                                  isMobile: isMobile,
                                  onNavigateToPurchase: () {
                                    setState(() {
                                      _activeTabIndex = 1;
                                      _openPurchaseForm = true; // Auto-open the Create form
                                    });
                                  },
                                )
                              : PurchaseEntry(
                                  startInCreateMode: _openPurchaseForm,
                                  onResetCreateMode: () => _openPurchaseForm = false, // Consume the trigger
                                ),
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

  Widget _buildTopBar() {
    String breadcrumb = _activeTabIndex == 0 ? "Home / Purchase Section / Bakery Products / Available Stock" : "Home / Purchase Section / Bakery Products / Purchase";
    return Container(
      height: 70, 
      color: Colors.white, 
      padding: const EdgeInsets.symmetric(horizontal: 20), 
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey), 
          const SizedBox(width: 15), 
          Text(breadcrumb, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)), 
          const Spacer(), 
          Container(
            width: 300, 
            height: 38, 
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)), 
            child: const TextField(decoration: InputDecoration(hintText: "Search menus (Press /)", prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.only(top: 8)))
          ), 
          const SizedBox(width: 20), 
          const CircleAvatar(radius: 18, backgroundColor: Colors.blue, child: Text("R", style: TextStyle(color: Colors.white)))
        ]
      )
    );
  }
}