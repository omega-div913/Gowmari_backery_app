import 'package:flutter/material.dart';

class RecordSectionConsumptionScreen extends StatefulWidget {
  const RecordSectionConsumptionScreen({Key? key}) : super(key: key);

  @override
  State<RecordSectionConsumptionScreen> createState() => _RecordSectionConsumptionScreenState();
}

class _RecordSectionConsumptionScreenState extends State<RecordSectionConsumptionScreen> {
  // Fixed variable names to be consistent
  String selectedCategory = "BAKERY";
  String selectedSubCategory = "ALL BAKERY ITEMS"; 

  final List<String> categories = [
    "BAKERY", "SWEET", "MURUKKU", "KOLUKATTAI", "KAARAM", "KADALAI MITTAI", "KAJU", "KITCHEN"
  ];

  final List<Map<String, dynamic>> items = [
    {"name": "1 kg Square Cake Bottom", "unit": "pcs", "stock": "124 pcs", "rate": 8.79, "uom": "pcs"},
    {"name": "1.5 kg Square Cake Bottom", "unit": "pcs", "stock": "449 pcs", "rate": 9.79, "uom": "pcs"},
    {"name": "1/2 kg Round Cake Bottom", "unit": "pcs", "stock": "350 pcs", "rate": 5.02, "uom": "pcs"},
    {"name": "1/2 kg Square Cake Bottom", "unit": "pcs", "stock": "199 pcs", "rate": 5.07, "uom": "pcs"},
    {"name": "12 No Cup Roll", "unit": "per roll", "stock": "482 per roll", "rate": 100.0, "uom": "per roll"},
  ];

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
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
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
              Text("Record Section Consumption", 
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              Text("Record material usage for a specific section", 
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          
          // DATE & TIME SECTION (IMAGE 2 EXACT)
          Row(
            children: [
              const Text(
                "DATE & TIME: ",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF475569), fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                  borderRadius: BorderRadius.circular(4),
                ),
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

          // SEARCH BOX SECTION (IMAGE 3 EXACT)
          SizedBox(
            width: 280,
            height: 45,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search item... (Alt+S)",
                hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
                prefixIcon: const Icon(Icons.search, size: 22, color: Color(0xFF475569)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Color(0xFF0D6EFD)),
                ),
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
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isActive = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = categories[index]),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: isActive ? const Color(0xFF0D6EFD) : Colors.transparent, width: 2)),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: isActive ? const Color(0xFF0D6EFD) : Colors.grey, 
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubCategoryRibbon() {
    final subs = ["ALL BAKERY ITEMS", "PUFF'S", "COOKIES & BISCUITS", "BUN"];
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: subs.map((sub) {
          bool isSel = selectedSubCategory == sub; // Use the correct variable name
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () => setState(() => selectedSubCategory = sub), // Fix: variable name must match state
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSel ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSel ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  sub,
                  style: TextStyle(
                    color: isSel ? Colors.white : Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEntryGrid() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
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
              itemCount: items.length,
              separatorBuilder: (c, i) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
              itemBuilder: (c, i) {
                final item = items[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text(item['unit'], style: const TextStyle(color: Colors.grey))),
                      Expanded(flex: 1, child: Text(item['stock'], style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
                      Expanded(flex: 1, child: Text(item['rate'].toString(), style: const TextStyle(color: Color(0xFF0D6EFD), fontWeight: FontWeight.bold))),
                      Expanded(flex: 2, child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(4)),
                          child: const TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(hintText: "-", border: InputBorder.none),
                          ),
                        ),
                      )),
                      Expanded(flex: 1, child: Text("0.00", style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 16))),
                      Expanded(flex: 1, child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: item['uom'], 
                          items: [DropdownMenuItem(value: item['uom'], child: Text(item['uom']))], 
                          onChanged: (v){}
                        ),
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
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
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
              backgroundColor: const Color(0xFF0D6EFD),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 22),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryBadge(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05), 
        borderRadius: BorderRadius.circular(8), 
        border: Border.all(color: color.withOpacity(0.2))
      ),
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