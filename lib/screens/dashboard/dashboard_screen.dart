import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/layout/main_layout.dart'; // Import layout from layout folder

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Wrap the entire page content in the MainLayout
    return MainLayout(
      breadcrumb: "Home / Overall Dashboard",
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FilterButtons(), 
              const SizedBox(height: 25),
              _buildStatGrid(context, screenWidth), 
              const SizedBox(height: 30),
              _buildChartSection(context, screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  // Statistics Grid
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
      crossAxisCount = 1; 
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

// --- FILTER SECTION ---
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