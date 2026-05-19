import 'package:flutter/material.dart';

class RecordSectionConsumptionScreen extends StatefulWidget {
  const RecordSectionConsumptionScreen({Key? key}) : super(key: key);

  @override
  State<RecordSectionConsumptionScreen> createState() => _RecordSectionConsumptionScreenState();
}

class _RecordSectionConsumptionScreenState extends State<RecordSectionConsumptionScreen> {
  String selectedCategory = "BAKERY";
  String selectedSubCategory = "ALL BAKERY ITEMS";

  final List<String> categories = [
    "BAKERY", "SWEET", "MURUKKU", "KOLUKATTAI", "KAARAM", "KADALAI MITTAI", "KAJU", "KITCHEN", "PACKING", "LAB", "OFFICE", "DONATION", "HOME", "NULL", "WASHING", "COVAI"
  ];

  // Helper to get Sub-Categories based on Category selection
  List<String> _getSubCategories() {
    if (selectedCategory == "SWEET") {
      return ["ALL SWEET ITEMS", "REGULAR SWEET'S", "MILK SWEET'S", "KAJU & DRY FRUIT & NUTS SWEET'S", "GHEE SWEET'S", "SPL SWEET'S", "JAMUN SWEET'S", "RASGULLA SWEET'S"];
    }
    return ["ALL BAKERY ITEMS", "PUFF'S", "COOKIES & BISCUITS", "BUN"];
  }

  // Helper to get Items based on Category selection
  List<Map<String, dynamic>> _getItems() {
    if (selectedCategory == "SWEET") {
      return [
        {"name": "120 ml Container", "unit": "per roll", "stock": "397 per roll", "rate": 90, "uom": "per roll", "hasIcon": true},
        {"name": "25 kg Liquid Glucose", "unit": "pcs", "stock": "488 pcs", "rate": 1950, "uom": "pcs"},
        {"name": "250 ml Container", "unit": "per roll", "stock": "323 per roll", "rate": 160, "uom": "per roll"},
        {"name": "5 kg Liquid Glucose", "unit": "pcs", "stock": "499 pcs", "rate": 600, "uom": "pcs"},
        {"name": "6 No Cup Roll", "unit": "per roll", "stock": "530 per roll", "rate": 49, "uom": "per roll"},
        {"name": "7*7 Butter Sheet", "unit": "kg", "stock": "492 kg", "rate": 160, "uom": "kg"},
        {"name": "Aththipalam", "unit": "kg", "stock": "498.8 kg", "rate": 1250, "uom": "kg"},
        {"name": "Backing Soda", "unit": "kg", "stock": "498 kg", "rate": 80, "uom": "kg"},
        {"name": "Banana", "unit": "kg", "stock": "2 kg", "rate": 40, "uom": "kg"},
        {"name": "Bhadam Paruppu", "unit": "kg", "stock": "490.75 kg", "rate": 800, "uom": "kg"},
        {"name": "Bio Gloves", "unit": "box", "stock": "521 box", "rate": 400, "uom": "box"},
      ];
    }
    return [
      {"name": "1 kg Square Cake Bottom", "unit": "pcs", "stock": "124 pcs", "rate": 8.79, "uom": "pcs"},
      {"name": "1.5 kg Square Cake Bottom", "unit": "pcs", "stock": "449 pcs", "rate": 9.79, "uom": "pcs"},
      {"name": "1/2 kg Round Cake Bottom", "unit": "pcs", "stock": "350 pcs", "rate": 5.02, "uom": "pcs"},
      {"name": "1/2 kg Square Cake Bottom", "unit": "pcs", "stock": "199 pcs", "rate": 5.07, "uom": "pcs"},
      {"name": "12 No Cup Roll", "unit": "per roll", "stock": "482 per roll", "rate": 100.0, "uom": "per roll"},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildTopHeader(context),
          _buildCategoryRibbon(),
          _buildSubCategoryRibbon(),
          Expanded(child: _buildEntryGrid()),
          _buildBottomSummary(),
        ],
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))),
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text("Back"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E293B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
          ),
          const SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Record Section Consumption", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              Text("Record material usage for a specific section", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              const Text("DATE & TIME: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF475569), fontSize: 14)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(border: Border.all(color: const Color(0xFFCBD5E1)), borderRadius: BorderRadius.circular(4)),
                child: Row(
                  children: const [
                    Text("19-05-2026 12:53", style: TextStyle(fontSize: 14, color: Colors.black87)),
                    SizedBox(width: 40),
                    Icon(Icons.calendar_month_outlined, size: 18, color: Colors.black87),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 30),
          SizedBox(
            width: 280, height: 45,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search item... (Alt+S)",
                hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
                prefixIcon: const Icon(Icons.search, size: 22, color: Color(0xFF475569)),
                filled: true, fillColor: Colors.white, contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: const BorderSide(color: Color(0xFF0D6EFD))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRibbon() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9)))),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isActive = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () => setState(() {
              selectedCategory = categories[index];
              selectedSubCategory = _getSubCategories().first; // Reset sub-cat on cat change
            }),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isActive ? const Color(0xFF0D6EFD) : Colors.transparent, width: 2))),
              child: Text(categories[index], style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? const Color(0xFF0D6EFD) : Colors.grey, fontSize: 12)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubCategoryRibbon() {
    final List<String> subs = _getSubCategories();
    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: subs.map((sub) {
            bool isSel = selectedSubCategory == sub;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: InkWell(
                onTap: () => setState(() => selectedSubCategory = sub),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSel ? const Color(0xFF1E293B) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isSel ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
                  ),
                  child: Text(sub, style: TextStyle(color: isSel ? Colors.white : Colors.black87, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEntryGrid() {
    final List<Map<String, dynamic>> currentItems = _getItems();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFF1F5F9))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            color: const Color(0xFFF8FAFC),
            child: Row(
              children: const [
                Expanded(flex: 3, child: Text("MATERIAL NAME", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B)))),
                Expanded(flex: 1, child: Text("BASE UNIT", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B)))),
                Expanded(flex: 1, child: Text("STOCK", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B)))),
                Expanded(flex: 1, child: Text("RATE (₹)", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B)))),
                Expanded(flex: 2, child: Text("ENTER CONSUMPTION QTY", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD)))),
                Expanded(flex: 1, child: Text("AMOUNT (₹)", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green))),
                Expanded(flex: 1, child: Text("UOM", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B)))),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: currentItems.length,
              separatorBuilder: (c, i) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
              itemBuilder: (c, i) {
                final item = currentItems[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Row(
                        children: [
                          Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                          if (item.containsKey('hasIcon')) ...[
                            const SizedBox(width: 8),
                            const Icon(Icons.add_circle, size: 16, color: Color(0xFF0D6EFD)),
                          ]
                        ],
                      )),
                      Expanded(flex: 1, child: Text(item['unit'], style: const TextStyle(color: Colors.grey))),
                      Expanded(flex: 1, child: Text(item['stock'], style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text(item['rate'].toString(), style: const TextStyle(color: Color(0xFF0D6EFD), fontWeight: FontWeight.bold))),
                      Expanded(flex: 2, child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Container(
                          height: 40, decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(4)),
                          child: const TextField(textAlign: TextAlign.center, decoration: InputDecoration(hintText: "-", border: InputBorder.none)),
                        ),
                      )),
                      Expanded(flex: 1, child: Text("0.00", style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 16))),
                      Expanded(flex: 1, child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(value: item['uom'], items: [DropdownMenuItem(value: item['uom'], child: Text(item['uom']))], onChanged: (v){})
                      )),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFE2E8F0)))),
      child: Row(
        children: [
          _summaryBadge("ITEMS TO CONSUME:", "0", Colors.amber),
          const SizedBox(width: 15),
          _summaryBadge("TOTAL AMOUNT:", "₹ 0.00", Colors.green),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.save, size: 18),
            label: const Text("Save Consumption"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 22),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryBadge(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.2))),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
          const SizedBox(width: 10),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color.withOpacity(0.9))),
        ],
      ),
    );
  }
}