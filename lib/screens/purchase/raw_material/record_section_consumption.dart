import 'package:flutter/material.dart';

class RecordSectionConsumptionScreen extends StatefulWidget {
  final bool isEdit;
  final String? initialSection;
  const RecordSectionConsumptionScreen({Key? key, this.isEdit = false, this.initialSection}) : super(key: key);

  @override
  State<RecordSectionConsumptionScreen> createState() => _RecordSectionConsumptionScreenState();
}

class _RecordSectionConsumptionScreenState extends State<RecordSectionConsumptionScreen> {
  late String selectedCategory;
  String selectedSubCategory = "ALL BAKERY ITEMS";

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialSection ?? "BAKERY";
  }

  final List<String> categories = [
    "BAKERY", "SWEET", "MURUKKU", "KOLUKATTAI", "KAARAM", "KADALAI MITTAI", "KAJU", "KITCHEN", "PACKING", "LAB", "OFFICE", "DONATION", "HOME", "NULL", "WASHING", "COVAI"
  ];

  List<String> _getSubCategories() {
    if (selectedCategory == "BAKERY") {
      return ["ALL BAKERY ITEMS", "PUFF'S", "COOKIES & BISCUITS PACKED ITEM'S", "BUN"];
    }
    if (selectedCategory == "SWEET") {
      return ["ALL SWEET ITEMS", "REGULAR SWEET'S", "MILK SWEET'S", "KAJU & DRY FRUIT & NUTS SWEET'S", "GHEE SWEET'S", "SPL SWEET'S", "JAMUN SWEET'S", "RASGULLA SWEET'S", "K", "TEST"];
    }
    if (selectedCategory == "MURUKKU") {
      return ["ALL MURUKKU ITEMS", "MURUKKU & CHIPS PACKED ITEM'S"];
    }
    return ["ALL ${selectedCategory} ITEMS"];
  }

  List<Map<String, dynamic>> _getItems() {
    switch (selectedCategory) {
      case "OFFICE":
      case "DONATION": // Image 1 & 2
        return [
          {"name": "100 gms P.P Cover (Old)", "unit": "kg", "stock": "483.5 kg", "rate": 283.2, "uom": "kg"},
          {"name": "250 gms P.P cover (Old)", "unit": "kg", "stock": "479.7 kg", "rate": 283.2, "uom": "kg"},
          {"name": "50 gms P.P Cover (Old)", "unit": "kg", "stock": "483 kg", "rate": 265.48, "uom": "kg"},
          {"name": "Aqu 1 lit", "unit": "pcs", "stock": "924 pcs", "rate": 20, "uom": "pcs"},
          {"name": "Aqu 2 lit", "unit": "pcs", "stock": "1275 pcs", "rate": 35, "uom": "pcs"},
          {"name": "Aqu 500 lit", "unit": "pcs", "stock": "500 pcs", "rate": 10, "uom": "pcs"},
          {"name": "Arica Plate", "unit": "pcs", "stock": "500 pcs", "rate": 7, "uom": "pcs"},
          {"name": "Bio Gloves", "unit": "box", "stock": "521 box", "rate": 400, "uom": "box"},
          {"name": "Bisileri 1 lit", "unit": "pcs", "stock": "-248 pcs", "rate": 20, "uom": "pcs", "isNegative": true},
          {"name": "Bisileri 2 lit", "unit": "pcs", "stock": "993 pcs", "rate": 30, "uom": "pcs"},
          {"name": "Bisileri 300 ml", "unit": "pcs", "stock": "500 pcs", "rate": 7, "uom": "pcs"},
          {"name": "Bisileri 500 ml", "unit": "pcs", "stock": "500 pcs", "rate": 10, "uom": "pcs"},
        ];
      case "HOME": // Image 3
        return [
          {"name": "120 ml Containar", "unit": "per roll", "stock": "397 per roll", "rate": 90, "uom": "per roll", "hasIcon": true},
          {"name": "250 ml Containar", "unit": "per roll", "stock": "323 per roll", "rate": 160, "uom": "per roll"},
          {"name": "7-up Fizz", "unit": "nos", "stock": "1763 nos", "rate": 20, "uom": "nos", "hasIcon": true},
          {"name": "7-up Nimbooz", "unit": "nos", "stock": "722 nos", "rate": 10, "uom": "nos"},
          {"name": "7*7 Butter Sheet", "unit": "kg", "stock": "492 kg", "rate": 160, "uom": "kg"},
          {"name": "Aashirvad Aatta", "unit": "bag", "stock": "487 bag", "rate": 562, "uom": "bag"},
          {"name": "Amma Idiyapa Mavu", "unit": "pkt", "stock": "527 pkt", "rate": 75, "uom": "pkt"},
          {"name": "AnnasiPoo", "unit": "kg", "stock": "499.8 kg", "rate": 590, "uom": "kg"},
          {"name": "Applam", "unit": "pkt", "stock": "485 pkt", "rate": 70, "uom": "pkt"},
          {"name": "Apple", "unit": "kg", "stock": "2 kg", "rate": 120, "uom": "kg"},
          {"name": "Arica Plate", "unit": "pcs", "stock": "500 pcs", "rate": 7, "uom": "pcs"},
          {"name": "Arisi Mavu", "unit": "kg", "stock": "198 kg", "rate": 45, "uom": "kg"},
        ];
      case "NULL": // Image 4
        return [
          {"name": "250ml KINLEY CLUB SODA", "unit": "nos", "stock": "1 nos", "rate": 200, "uom": "nos"},
          {"name": "250ml SPRITE", "unit": "nos", "stock": "1 nos", "rate": 300, "uom": "nos"},
          {"name": "AMUL DICED MOZZARELLA 12 - 1Kg", "unit": "nos", "stock": "3 nos", "rate": 400, "uom": "nos"},
          {"name": "ATR Fish Boneless 1kg", "unit": "nos", "stock": "10 nos", "rate": 300, "uom": "nos"},
          {"name": "Balloon 10 Pcs", "unit": "pcs", "stock": "1425 pcs", "rate": 230, "uom": "pcs"},
          {"name": "Balloon 8 Pcs", "unit": "pcs", "stock": "1470 pcs", "rate": 200, "uom": "pcs"},
          {"name": "Birthday Cap", "unit": "pcs", "stock": "1374 pcs", "rate": 50, "uom": "pcs"},
          {"name": "Birthday Knife", "unit": "pkt", "stock": "454 pkt", "rate": 82.5, "uom": "pkt"},
          {"name": "Cake Order Form", "unit": "pcs", "stock": "500 pcs", "rate": 210, "uom": "pcs"},
          {"name": "Chilli Sauce", "unit": "pcs", "stock": "501 pcs", "rate": 54, "uom": "pcs"},
          {"name": "CI CUP VANILA 55ML ( 16*9) RS. 10", "unit": "nos", "stock": "0 nos", "rate": 100, "uom": "nos"},
          {"name": "CREMICA CHEF S CHOICE MAYO 1KGX12PCS-PREM", "unit": "nos", "stock": "2 nos", "rate": 200, "uom": "nos", "hasIcon": true},
        ];
      case "WASHING": // Image 5
        return [
          {"name": "Broom", "unit": "pcs", "stock": "397 pcs", "rate": 50, "uom": "pcs"},
          {"name": "Broom Stick", "unit": "pcs", "stock": "396 pcs", "rate": 25, "uom": "pcs"},
          {"name": "Garbage Bag", "unit": "pcs", "stock": "641 pcs", "rate": 11, "uom": "pcs"},
          {"name": "Cleaning Mat", "unit": "pcs", "stock": "491 pcs", "rate": 33, "uom": "pcs"},
          {"name": "Colin", "unit": "pcs", "stock": "445 pcs", "rate": 102.44, "uom": "pcs"},
          {"name": "Exo Powder", "unit": "kg", "stock": "443 kg", "rate": 26.34, "uom": "kg"},
          {"name": "Exo Soap", "unit": "pcs", "stock": "453 pcs", "rate": 27.7, "uom": "pcs"},
          {"name": "Finaoil", "unit": "lit", "stock": "491.9 lit", "rate": 380, "uom": "lit"},
          {"name": "Hand Gloves", "unit": "pkt", "stock": "653 pkt", "rate": 40, "uom": "pkt"},
          {"name": "Harpic", "unit": "pcs", "stock": "495 pcs", "rate": 91.62, "uom": "pcs"},
          {"name": "kitchen Cap", "unit": "pkt", "stock": "453 pkt", "rate": 58, "uom": "pkt"},
          {"name": "Lizal", "unit": "pcs", "stock": "514 pcs", "rate": 106.21, "uom": "pcs"},
        ];
      case "COVAI": // Image 6
        return [
          {"name": "1 kg P.P Cover", "unit": "kg", "stock": "549 kg", "rate": 377.6, "uom": "kg"},
          {"name": "1 kg Sweet Container", "unit": "pcs", "stock": "219 pcs", "rate": 17.5, "uom": "pcs"},
          {"name": "100 gms P.P Cover", "unit": "kg", "stock": "525.5 kg", "rate": 377.6, "uom": "kg"},
          {"name": "100 gms P.P Cover (Old)", "unit": "kg", "stock": "483.5 kg", "rate": 283.2, "uom": "kg"},
          {"name": "13*16 Compostable Bag", "unit": "kg", "stock": "618.6 kg", "rate": 190, "uom": "kg", "hasIcon": true},
          {"name": "16*20 Compostable Bag", "unit": "kg", "stock": "428.9 kg", "rate": 190, "uom": "kg"},
          {"name": "2 kg Icing Box (Per Pcs = 0.265 gms)", "unit": "pcs", "stock": "460 pcs", "rate": 35.4, "uom": "pcs"},
          {"name": "200 gms P.P Cover", "unit": "kg", "stock": "455.9 kg", "rate": 377.6, "uom": "kg"},
          {"name": "25 kg Liquid Glucose", "unit": "pcs", "stock": "488 pcs", "rate": 1950, "uom": "pcs"},
          {"name": "250 gms P.P Cover", "unit": "kg", "stock": "535.69 kg", "rate": 377.6, "uom": "kg"},
          {"name": "250 gms Sweet Container", "unit": "pcs", "stock": "2904 pcs", "rate": 10.33, "uom": "pcs"},
          {"name": "250 ml Containar", "unit": "per roll", "stock": "323 per roll", "rate": 160, "uom": "per roll"},
        ];
      case "BAKERY":
        if (selectedSubCategory == "ALL BAKERY ITEMS") {
          return [
            {"name": "1 kg Square Cake Bottom", "unit": "pcs", "stock": "124 pcs", "rate": 8.79, "uom": "pcs"},
            {"name": "1.5 kg Square Cake Bottom", "unit": "pcs", "stock": "449 pcs", "rate": 9.79, "uom": "pcs"},
            {"name": "1/2 kg Round Cake Bottom", "unit": "pcs", "stock": "350 pcs", "rate": 5.02, "uom": "pcs"},
            {"name": "1/2 kg Square Cake Bottom", "unit": "pcs", "stock": "199 pcs", "rate": 5.07, "uom": "pcs"},
            {"name": "12 No Cup Roll", "unit": "per roll", "stock": "482 per roll", "rate": 100.0, "uom": "per roll"},
          ];
        }
        return [];
      case "KITCHEN":
        return [
          {"name": "1 kg P.P Cover", "unit": "kg", "stock": "549 kg", "rate": 377.6, "uom": "kg"},
          {"name": "1 Parcel Covers", "unit": "pkt", "stock": "500 pkt", "rate": 55, "uom": "pkt", "hasIcon": true},
          {"name": "1/2 Parcel Cover", "unit": "pkt", "stock": "519 pkt", "rate": 42, "uom": "pkt", "hasIcon": true},
          {"name": "2 Parcel Covers", "unit": "pkt", "stock": "492 pkt", "rate": 88, "uom": "pkt", "hasIcon": true},
        ];
      case "KADALAI MITTAI":
        return [
          {"name": "25 kg Liquid Glucose", "unit": "pcs", "stock": "488 pcs", "rate": 1950, "uom": "pcs"},
          {"name": "5 kg Liquid Glucose", "unit": "pcs", "stock": "499 pcs", "rate": 600, "uom": "pcs"},
          {"name": "Bio Gloves", "unit": "box", "stock": "521 box", "rate": 400, "uom": "box"},
          {"name": "Broom", "unit": "pcs", "stock": "397 pcs", "rate": 50, "uom": "pcs"},
          {"name": "Broom Stick", "unit": "pcs", "stock": "396 pcs", "rate": 25, "uom": "pcs"},
          {"name": "Cleaning Mat", "unit": "pcs", "stock": "491 pcs", "rate": 33, "uom": "pcs"},
          {"name": "Coconut", "unit": "pcs", "stock": "1040 pcs", "rate": 38, "uom": "pcs", "hasIcon": true},
          {"name": "Colin", "unit": "pcs", "stock": "445 pcs", "rate": 102.44, "uom": "pcs"},
          {"name": "Exo Powder", "unit": "kg", "stock": "443 kg", "rate": 26.34, "uom": "kg"},
          {"name": "Exo Soap", "unit": "pcs", "stock": "453 pcs", "rate": 27.7, "uom": "pcs"},
          {"name": "Finaoil", "unit": "lit", "stock": "491.9 lit", "rate": 380, "uom": "lit"},
          {"name": "Gas Cylinder", "unit": "nos", "stock": "342 nos", "rate": 2250, "uom": "nos", "hasIcon": true},
        ];
      default:
        return [];
    }
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
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E293B), foregroundColor: Colors.white),
          ),
          const SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.isEdit ? "Edit Section Consumption" : "Record Section Consumption", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              Text(widget.isEdit ? "Update material usage for this record" : "Record material usage for a specific section", style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          const Text("DATE & TIME: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF475569), fontSize: 14)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(border: Border.all(color: const Color(0xFFCBD5E1)), borderRadius: BorderRadius.circular(4)),
            child: Row(children: const [
              Text("19-05-2026 15:38", style: TextStyle(fontSize: 14, color: Colors.black87)),
              SizedBox(width: 40),
              Icon(Icons.calendar_month_outlined, size: 18, color: Colors.black87),
            ]),
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
              selectedSubCategory = _getSubCategories().first; 
            }),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isActive ? const Color(0xFF0D6EFD) : Colors.transparent, width: 2))),
              child: Row(children: [
                Text(categories[index], style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? const Color(0xFF0D6EFD) : Colors.grey, fontSize: 12)),
                if (isActive && widget.isEdit) ...[
                  const SizedBox(width: 8),
                  Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle), child: const Text("11", style: TextStyle(color: Colors.white, fontSize: 10))),
                ]
              ]),
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
        child: Row(children: subs.map((sub) {
          bool isSel = selectedSubCategory == sub;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () => setState(() => selectedSubCategory = sub),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: isSel ? const Color(0xFF1E293B) : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: isSel ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0))),
                child: Text(sub, style: TextStyle(color: isSel ? Colors.white : Colors.black87, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          );
        }).toList()),
      ),
    );
  }

  Widget _buildEntryGrid() {
    final currentItems = _getItems();
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
            child: currentItems.isEmpty 
            ? _buildEmptyState() 
            : ListView.separated(
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
                        Expanded(flex: 1, child: Text(item['stock'], style: TextStyle(color: item.containsKey('isNegative') ? Colors.red : Colors.green, fontWeight: FontWeight.bold))),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 60, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          Text("No raw materials are mapped specifically to this sub-section.", style: TextStyle(color: Colors.grey.shade500, fontSize: 14, fontStyle: FontStyle.italic)),
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
          _summaryBadge("ITEMS TO CONSUME:", widget.isEdit ? "11" : "0", Colors.amber),
          const SizedBox(width: 15),
          _summaryBadge("TOTAL AMOUNT:", widget.isEdit ? "₹ 16435.83" : "₹ 0.00", Colors.green),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(widget.isEdit ? Icons.update : Icons.save, size: 18),
            label: Text(widget.isEdit ? "Update Consumption" : "Save Consumption"),
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