import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/masters/masters_page.dart';
import 'package:gowmari_mobile/screens/inventory/bakery_products_page.dart';
import 'package:gowmari_mobile/screens/inventory/packaging_material_page.dart'; // 1. IMPORT THE NEW PAGE

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      // Drawer for mobile view
      drawer: isMobile ? const Drawer(child: AppSidebar()) : null,
      appBar: isMobile
          ? AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text("Purchase Dashboard", 
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            )
          : null,
      body: Row(
        children: [
          // Sidebar shows only on large screens
          if (!isMobile) const SizedBox(width: 300, child: AppSidebar()),

          Expanded(
            child: Column(
              children: [
                if (!isMobile) const AppTopbar(),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          const FilterButtons(), // Fixed for responsiveness
                          const SizedBox(height: 25),
                          _buildStatGrid(context, screenWidth), // Fixed for overflow
                          const SizedBox(height: 30),
                          _buildChartSection(context, screenWidth),
                        ],
                      ),
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

  // Statistics Grid with Dynamic Sizing to fix Overflow
  Widget _buildStatGrid(BuildContext context, double width) {
    int crossAxisCount;
    double ratio;

    if (width > 1400) {
      crossAxisCount = 5;
      ratio = 2.2;
    } else if (width > 900) {
      crossAxisCount = 3;
      ratio = 2.0;
    } else if (width > 600) {
      crossAxisCount = 2;
      ratio = 1.8;
    } else {
      crossAxisCount = 1; // Single column on very small phones
      ratio = 3.5;
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: ratio, 
      children: const [
        DashboardCard(title: 'GROSS SALES', value: '₹13,505.86', subText: '₹0.00 Charges', color: Colors.green),
        DashboardCard(title: 'DISCOUNTS', value: '₹0.00', subText: '₹0.00 Disc', color: Colors.blue),
        DashboardCard(title: 'REFUNDS', value: '₹0.00', subText: '₹0.00 Ref...', color: Colors.red),
        DashboardCard(title: 'NET SALES', value: '₹13,505.86', subText: '55 Transac...', color: Colors.teal),
        DashboardCard(title: 'TAXES', value: '₹664.14', subText: '₹0.00 Tax', color: Colors.orange),
        DashboardCard(title: 'NET TOTAL', value: '₹14,170.00', subText: '₹0.00 Round...', color: Colors.purple),
        DashboardCard(title: 'SUPPLIER CREDIT', value: '₹0.00', subText: '₹0.00 Debit', color: Colors.indigo),
        DashboardCard(title: 'TOTAL CUSTOMERS', value: '2', subText: '8 Customers', color: Colors.amber),
        DashboardCard(title: 'CUSTOMER CREDIT', value: '₹4,450.00', subText: '₹4,355.00 Credit', color: Colors.pink),
      ],
    );
  }

  Widget _buildChartSection(BuildContext context, double width) {
    bool isNarrow = width < 800;
    return Flex(
      direction: isNarrow ? Axis.vertical : Axis.horizontal,
      children: [
        Expanded(flex: isNarrow ? 0 : 1, child: _whiteBox("Top Item by Sales")),
        SizedBox(width: isNarrow ? 0 : 20, height: isNarrow ? 20 : 0),
        Expanded(flex: isNarrow ? 0 : 1, child: _whiteBox("Top Category by Sales")),
      ],
    );
  }

  Widget _whiteBox(String title) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(15), 
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]
      ),
      child: Center(child: Text(title, style: const TextStyle(color: Colors.grey))),
    );
  }
}

// --- SIDEBAR ---
class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE1F5FE), 
      child: Column(
        children: [
          const SizedBox(height: 35),
          Container(
            height: 100, width: 100,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('assets/images/rts_logo.png', fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 35),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _menuItem(Icons.speed, "Overall Dashboard"), // Set to false, as we'll be on another page
                const SizedBox(height: 20),
                _menuItem(Icons.shopping_cart_outlined, "Purchase Section", isActive: true), // Set this section to active
                const SizedBox(height: 10),
                
                _subItem(context, Icons.inventory_2_outlined, "Raw Material", badge: "192"),
                _subItem(context, Icons.assignment_turned_in_outlined, "RM Request Management"),
                _subItem(context, Icons.event_available_outlined, "Daily Usage Management"),

                // 2. THIS IS THE CORRECTED AND FINAL CHANGE
                _subItem(context, Icons.inventory_2_outlined, "Packaging Material", destination: const PackagingMaterialPage()),
                
                _subItem(context, Icons.storage_outlined, "Masters", destination: const MastersPage()),
                _subItem(context, Icons.account_balance_wallet_outlined, "Stock Cost"),
                _subItem(context, Icons.assignment_outlined, "Inventory Audit Entry"),
                _subItem(context, Icons.delete_outline, "Wastage Management"),
                _subItem(context, Icons.history, "Reversal History"),
                _subItem(context, Icons.shopping_cart_checkout, "Bakery Products", destination: const BakeryProductsPage()),
                _subItem(context, Icons.update, "Purchase Transfer History"),
                _subItem(context, Icons.shopping_cart_checkout, "Purchase Report"),
              ],
            ),
          ),
          const Divider(height: 1),
          _menuItem(Icons.verified_user_outlined, "Access Provider"),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, {bool isActive = false}) {
    return Container(
      decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0D47A1) : Colors.transparent, 
          borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -2),
        leading: Icon(icon, color: isActive ? Colors.white : const Color(0xFF1A237E), size: 22),
        title: Text(label, style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF1A237E), 
            fontSize: 14, 
            fontWeight: FontWeight.bold)
        ),
        onTap: () {
          // You might want to add navigation for main menu items too
        },
      ),
    );
  }

  Widget _subItem(BuildContext context, IconData icon, String text, {String? badge, Widget? destination}) {
    // Check if the current route is the destination to set active state
    bool isActive = false;
    if (destination != null) {
      // A simple check; more robust routing might use ModalRoute.of(context)?.settings.name
      isActive = ModalRoute.of(context)?.settings is MaterialPageRoute &&
                 (ModalRoute.of(context)?.settings as MaterialPageRoute).builder(context).runtimeType == destination.runtimeType;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        selected: isActive,
        selectedTileColor: const Color(0xFFBBDEFB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        visualDensity: const VisualDensity(vertical: -4),
        leading: Icon(icon, size: 20, color: const Color(0xFF1A237E)),
        title: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF1A237E), fontWeight: FontWeight.w600)),
        trailing: badge != null ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(12)),
          child: Text(badge, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ) : null,
        onTap: () {
          if (destination != null) {
            // Use pushReplacement to avoid building up a stack of pages
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context) => destination)
            );
          }
        },
      ),
    );
  }
}

// --- INTERACTIVE CARD ---
class DashboardCard extends StatefulWidget {
  final String title, value, subText;
  final Color color;
  const DashboardCard({super.key, required this.title, required this.value, required this.subText, required this.color});

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, isHover ? -5 : 0, 0), 
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: widget.color.withOpacity(isHover ? 0.2 : 0.05), 
                blurRadius: 10, 
                offset: const Offset(0, 5)
            )
          ],
        ),
        child: Stack(
          children: [
            Container(width: 5, decoration: BoxDecoration(color: widget.color, borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)))),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                  const SizedBox(height: 5),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(widget.value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1A237E))),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(widget.subText, style: const TextStyle(fontSize: 9, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Positioned(right: 10, top: 0, bottom: 0, child: Icon(Icons.trending_up_rounded, color: widget.color.withOpacity(0.06), size: 30)),
          ],
        ),
      ),
    );
  }
}

// --- TOPBAR ---
class AppTopbar extends StatelessWidget {
  const AppTopbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, color: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey),
          const SizedBox(width: 15),
          const Text("Home / Overall Dashboard", style: TextStyle(color: Colors.grey, fontSize: 13)),
          const Spacer(),
          Container(
            width: 300, height: 38, 
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
            child: const TextField(decoration: InputDecoration(hintText: "Search menus...", prefixIcon: Icon(Icons.search, size: 20), border: InputBorder.none)),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(radius: 18, backgroundColor: Colors.blue, child: Text("R", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}

// --- FILTER SECTION (Fixed for Mobile Overflow) ---
class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _btn("Jul 26, 2025 - Jul 26, 2025", Icons.calendar_today),
        _btn("All Location", null),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("Clear Filters", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
      ],
    );
  }
  Widget _btn(String t, IconData? i) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(i!=null)Icon(i, size: 14, color: Colors.grey), 
            if(i!=null)const SizedBox(width: 8), 
            Text(t, style: const TextStyle(fontSize: 11))
          ]
      ),
    );
  }
}