import 'package:flutter/material.dart';

class DailyUsageManualBatchPage extends StatefulWidget {
  const DailyUsageManualBatchPage({super.key});

  @override
  State<DailyUsageManualBatchPage> createState() => _DailyUsageManualBatchPageState();
}

class _DailyUsageManualBatchPageState extends State<DailyUsageManualBatchPage> {
  String selectedCategory = "BAKERY";
  String selectedBatch = "Batch 01";

  final List<String> categories = [
    "BAKERY", "CHAT MATERIAL", "CLEANING MATERIAL", "PACKING MATERIAL", 
    "RAW MATERIAL", "SERVICE MATERIAL", "TEA COFFE MATERIAL", 
    "VADA MATERIAL", "VEGETABLES", "UNCATEGORIZED"
  ];

  final List<String> outlets = [
    "AINAAS", "PC", "ITI", "FOREST ROAD", "LPM", "GMB", "AL", "RN", 
    "SR PURAM", "AMBA", "MANDAPAM", "BODI-2", "TEST", "COVAI", 
    "N.R\n(PURCHASE)", "N.RESTAURANT", "N.RESTAURANT\n( ITI )", "NRT\nCAFE", "TESTING"
  ];

  // Exact Data Mapping for Tabs based on your images
  final Map<String, List<Map<String, dynamic>>> categoryData = {
    "BAKERY": [
      {"name": "50 - 50 BUSCUT", "stock": "", "price": "10", "unit": "Pcs", "hasPlus": false},
      {"name": "50-50 Sweet & Salt", "stock": "Stock: 825.03 pcs", "price": "10", "unit": "pcs", "hasPlus": false},
      {"name": "7- up Fizz", "stock": "Stock: 1763 nos", "price": "20", "unit": "nos", "hasPlus": true},
      {"name": "7- up Nimbooz", "stock": "Stock: 722 nos", "price": "10", "unit": "nos", "hasPlus": false},
      {"name": "Aachi Jam", "stock": "Stock: 15500 pcs", "price": "20", "unit": "pcs", "hasPlus": false},
      {"name": "Aqu 1 lit", "stock": "Stock: 924 pcs", "price": "20", "unit": "pcs", "hasPlus": false},
      {"name": "Aqu 2 lit", "stock": "Stock: 1275 pcs", "price": "35", "unit": "pcs", "hasPlus": false},
      {"name": "Aqu 500 lit", "stock": "Stock: 500 pcs", "price": "10", "unit": "pcs", "hasPlus": false},
      {"name": "Balloon 10 Pcs", "stock": "Stock: 1425 pcs", "price": "230", "unit": "pcs", "hasPlus": false},
      {"name": "Balloon 8 Pcs", "stock": "Stock: 1470 pcs", "price": "200", "unit": "pcs", "hasPlus": false},
      {"name": "Birthday Cap", "stock": "Stock: 1374 pcs", "price": "50", "unit": "pcs", "hasPlus": false},
      {"name": "biscutstest", "stock": "Stock: 123 Pcs", "price": "20", "unit": "Pcs", "hasPlus": false},
    ],
    "CHAT MATERIAL": [
      {"name": "Aashirvad Aatta", "stock": "Stock: 487 bag", "price": "560", "unit": "bag", "hasPlus": true},
      {"name": "AMUL DICED MOZZARELLA 12 -\n1Kg", "stock": "Stock: 3 nos", "price": "490.6", "unit": "nos", "hasPlus": false},
      {"name": "AnnasiPoo", "stock": "Stock: 499.8 kg", "price": "520", "unit": "kg", "hasPlus": true},
      {"name": "Arisi Mavu", "stock": "Stock: 348 kg", "price": "42", "unit": "kg", "hasPlus": true},
      {"name": "ATR Fish Boneless 1kg", "stock": "Stock: 10 nos", "price": "326", "unit": "nos", "hasPlus": false},
      {"name": "Black Salt", "stock": "Stock: 505 kg", "price": "62", "unit": "kg", "hasPlus": false},
      {"name": "Briyani Ilai", "stock": "Stock: 5499.95 kg", "price": "160.00", "unit": "kg", "hasPlus": false},
      {"name": "Briyani Masala", "stock": "Stock: 499 pkt", "price": "950", "unit": "pkt", "hasPlus": false},
      {"name": "Butter - Amul", "stock": "Stock: 693 pkt", "price": "274.8", "unit": "pkt", "hasPlus": true},
      {"name": "Butter - Milkymist", "stock": "Stock: 581 pcs", "price": "361.87", "unit": "pcs", "hasPlus": true},
      {"name": "Butter - Skc", "stock": "Stock: 174 pkt", "price": "283.5", "unit": "pkt", "hasPlus": false},
      {"name": "Cashew", "stock": "Stock: 500 kg", "price": "870.91", "unit": "kg", "hasPlus": true},
    ],
    "CLEANING MATERIAL": [
      {"name": "Broom", "stock": "Stock: 397 pcs", "price": "50", "unit": "pcs", "hasPlus": false},
      {"name": "Broom Stick", "stock": "Stock: 396 pcs", "price": "25", "unit": "pcs", "hasPlus": false},
      {"name": "Carbage Bag", "stock": "Stock: 641 pcs", "price": "16.8", "unit": "pcs", "hasPlus": true},
      {"name": "Cleaning Mat", "stock": "Stock: 491 pcs", "price": "33", "unit": "pcs", "hasPlus": false},
      {"name": "Colin", "stock": "Stock: 445 pcs", "price": "107.44", "unit": "pcs", "hasPlus": true},
      {"name": "Exo Powder", "stock": "Stock: 443 kg", "price": "26.34", "unit": "kg", "hasPlus": false},
      {"name": "Exo Soap", "stock": "Stock: 448 pcs", "price": "27.7", "unit": "pcs", "hasPlus": false},
      {"name": "Finaoil", "stock": "Stock: 491.9 lit", "price": "380", "unit": "lit", "hasPlus": false},
      {"name": "Harpic", "stock": "Stock: 495 pcs", "price": "91.62", "unit": "pcs", "hasPlus": false},
      {"name": "Lizal", "stock": "Stock: 514 pcs", "price": "113.17", "unit": "pcs", "hasPlus": true},
      {"name": "Medimix Handwash", "stock": "Stock: 500 lit", "price": "150", "unit": "lit", "hasPlus": false},
      {"name": "Mop", "stock": "Stock: 499 pcs", "price": "230", "unit": "pcs", "hasPlus": false},
    ],
    "PACKING MATERIAL": [
      {"name": "1 kg P.P Cover", "stock": "Stock: 549 kg", "price": "7", "unit": "kg", "hasPlus": true},
      {"name": "1 kg Birthday Cake Box", "stock": "Stock: 165 pcs", "price": "18.48", "unit": "pcs", "hasPlus": true},
      {"name": "1 kg Cake Bag", "stock": "Stock: 179 pcs", "price": "8.62", "unit": "pcs", "hasPlus": false},
      {"name": "1 kg Square Cake Bottom", "stock": "Stock: 74 pcs", "price": "8.79", "unit": "pcs", "hasPlus": false},
      {"name": "1 kg Sweet Box", "stock": "Stock: 220 pcs", "price": "16.80", "unit": "pcs", "hasPlus": false},
      {"name": "1 kg Sweet Container", "stock": "Stock: 219 pcs", "price": "17.5", "unit": "pcs", "hasPlus": false},
      {"name": "1 kg Sweet Sticker New (100\ngms = 19 Pcs)", "stock": "Stock: 500 pcs", "price": "2.46", "unit": "pcs", "hasPlus": false},
      {"name": "1.5 kg Square Cake Bottom", "stock": "Stock: 449 pcs", "price": "9.79", "unit": "pcs", "hasPlus": false},
      {"name": "1/2 kg Cake Bag", "stock": "Stock: 130 pcs", "price": "7.62", "unit": "pcs", "hasPlus": false},
      {"name": "1/2 kg Round Cake Bottom", "stock": "Stock: 350 pcs", "price": "5.02", "unit": "pcs", "hasPlus": false},
      {"name": "1/2 kg Square Cake Bottom", "stock": "Stock: 199 pcs", "price": "5.07", "unit": "pcs", "hasPlus": false},
      {"name": "10 kg Mudichu Covers", "stock": "Stock: 146 kg", "price": "146", "unit": "kg", "hasPlus": false},
    ],
    "RAW MATERIAL": [
      {"name": "12 No Cup Roll", "stock": "Stock: 482 per roll", "price": "100", "unit": "per roll", "hasPlus": false},
      {"name": "25 kg Liquid Glucose", "stock": "Stock: 488 pcs", "price": "1770", "unit": "pcs", "hasPlus": true},
      {"name": "250ml KINLEY CLUB SODA", "stock": "Stock: 1 nos", "price": "187", "unit": "nos", "hasPlus": false},
      {"name": "250ml SPRITE", "stock": "Stock: 1 nos", "price": "495", "unit": "nos", "hasPlus": false},
      {"name": "5 kg Liquid Glucose", "stock": "Stock: 499 pcs", "price": "600", "unit": "pcs", "hasPlus": false},
      {"name": "6 No Cup Roll", "stock": "Stock: 550 per roll", "price": "49", "unit": "per roll", "hasPlus": false},
      {"name": "A.S ARISI MAVU", "stock": "Stock: 376 kg", "price": "46", "unit": "kg", "hasPlus": false},
      {"name": "Aashirvad Aatta", "stock": "Stock: 487 bag", "price": "560", "unit": "bag", "hasPlus": true},
      {"name": "Akroot", "stock": "Stock: 519 pkt", "price": "305", "unit": "pkt", "hasPlus": true},
      {"name": "Amma Idiyapa Mavu", "stock": "Stock: 527 pkt", "price": "75", "unit": "pkt", "hasPlus": false},
      {"name": "Amoniya Powder", "stock": "Stock: 500 kg", "price": "55", "unit": "kg", "hasPlus": false},
      {"name": "Amul Freshh Cream", "stock": "Stock: 29 ltr", "price": "223.00", "unit": "ltr", "hasPlus": true},
    ],
    "SERVICE MATERIAL": [
      {"name": "1 Parcel Covers", "stock": "Stock: 510 pkt", "price": "71.4", "unit": "pkt", "hasPlus": true},
      {"name": "1/2 Parcel Cover", "stock": "Stock: 539 pkt", "price": "71.4", "unit": "pkt", "hasPlus": true},
      {"name": "2 Parcel Covers", "stock": "Stock: 497 pkt", "price": "100", "unit": "pkt", "hasPlus": true},
      {"name": "7*7 Butter Sheet", "stock": "Stock: 492 kg", "price": "160", "unit": "kg", "hasPlus": false},
      {"name": "Arica Plate", "stock": "Stock: 500 pcs", "price": "7", "unit": "pcs", "hasPlus": false},
      {"name": "B.Candle (Safty Matches)", "stock": "Stock: 3552 pcs", "price": "35", "unit": "pcs", "hasPlus": true},
      {"name": "BANANA LEAFS LUNCH", "stock": "Stock: 1100 pcs", "price": "3", "unit": "pcs", "hasPlus": false},
      {"name": "BANANA LEAFS PARCEL", "stock": "Stock: 1301 pcs", "price": "1.75", "unit": "pcs", "hasPlus": true},
      {"name": "BEEDA", "stock": "Stock: 275 pcs", "price": "8", "unit": "pcs", "hasPlus": true},
      {"name": "BIG ROUND BANANA LEAFS", "stock": "Stock: 501 pcs", "price": "2.5", "unit": "pcs", "hasPlus": false},
      {"name": "Bill Roll", "stock": "Stock: 710 pcs", "price": "47.2", "unit": "pcs", "hasPlus": true},
      {"name": "Bio Gloves", "stock": "Stock: 521 box", "price": "375.01", "unit": "box", "hasPlus": true},
    ],
    "TEA COFFE MATERIAL": [
      {"name": "Bhadam Powder", "stock": "Stock: 496 pkt", "price": "77", "unit": "pkt", "hasPlus": false},
      {"name": "Black Tea", "stock": "Stock: 485 pcs", "price": "282.61", "unit": "pcs", "hasPlus": false},
      {"name": "Booste Tea Pocket", "stock": "Stock: 228 pkt", "price": "4.58", "unit": "pkt", "hasPlus": false},
      {"name": "Chikkari", "stock": "Stock: 487.2 kg", "price": "220", "unit": "kg", "hasPlus": true},
      {"name": "Coffee Powder", "stock": "Stock: 414 kg", "price": "800", "unit": "kg", "hasPlus": false},
      {"name": "Green Tea", "stock": "Stock: 459 pkt", "price": "47.83", "unit": "pkt", "hasPlus": false},
      {"name": "Horlicks Tea pocket", "stock": "Stock: 1388 pkt", "price": "5", "unit": "pkt", "hasPlus": true},
      {"name": "Naatusakkarai", "stock": "Stock: 666 pkt", "price": "35", "unit": "pkt", "hasPlus": true},
      {"name": "Panangarkandu Powder", "stock": "Stock: 491 pkt", "price": "41", "unit": "pkt", "hasPlus": false},
      {"name": "Pocket Milk", "stock": "Stock: 61 ltr", "price": "78", "unit": "ltr", "hasPlus": true},
      {"name": "Sugar", "stock": "Stock: 5838.5 kg", "price": "49", "unit": "kg", "hasPlus": true},
      {"name": "Sukku Coffee", "stock": "Stock: 503 pkt", "price": "149", "unit": "pkt", "hasPlus": true},
    ],
    "VADA MATERIAL": [
      {"name": "Arisi Mavu", "stock": "Stock: 348 kg", "price": "42", "unit": "kg", "hasPlus": true},
      {"name": "Chicken Masala", "stock": "Stock: 5516 pkt", "price": "28.00", "unit": "pkt", "hasPlus": true},
      {"name": "Chilli Powder", "stock": "Stock: 487 pkt", "price": "136", "unit": "pkt", "hasPlus": true},
      {"name": "Coconut", "stock": "Stock: 1624 pcs", "price": "24.58", "unit": "pcs", "hasPlus": true},
      {"name": "Coriander Powder", "stock": "Stock: 506 pkt", "price": "111", "unit": "pkt", "hasPlus": true},
      {"name": "Corn Mavu Bakers", "stock": "Stock: 498 kg", "price": "80", "unit": "kg", "hasPlus": true},
      {"name": "Curry Masala", "stock": "Stock: 461 pkt", "price": "40", "unit": "pkt", "hasPlus": true},
      {"name": "Garam Masala", "stock": "Stock: 5524 pkt", "price": "21.75", "unit": "pkt", "hasPlus": true},
      {"name": "kadalai Mavu 1 kg", "stock": "Stock: 205 kg", "price": "82", "unit": "kg", "hasPlus": false},
      {"name": "Kaduku Ulunthu", "stock": "Stock: 499.45 kg", "price": "88", "unit": "kg", "hasPlus": false},
      {"name": "Kal Uppu", "stock": "Stock: 585 kg", "price": "8.8", "unit": "kg", "hasPlus": true},
      {"name": "Kili Maida", "stock": "Stock: 345 kg", "price": "52", "unit": "kg", "hasPlus": false},
    ],
    "VEGETABLES": [
      {"name": "Apple", "stock": "Stock: 2 kg", "price": "120", "unit": "kg", "hasPlus": false},
      {"name": "Avaraikai", "stock": "Stock: 2 kg", "price": "80", "unit": "kg", "hasPlus": false},
      {"name": "Banana", "stock": "Stock: 2 kg", "price": "40", "unit": "kg", "hasPlus": false},
      {"name": "Bangalore Tomoto", "stock": "Stock: 10 kg", "price": "60", "unit": "kg", "hasPlus": false},
      {"name": "Beens", "stock": "Stock: 29 kg", "price": "130", "unit": "kg", "hasPlus": true},
      {"name": "Beetroot", "stock": "Stock: 2 kg", "price": "50", "unit": "kg", "hasPlus": false},
      {"name": "Biiter Gourd - Paavakai", "stock": "Stock: 2 kg", "price": "70", "unit": "kg", "hasPlus": false},
      {"name": "Brinjal", "stock": "Stock: 23 kg", "price": "40", "unit": "kg", "hasPlus": true},
      {"name": "Butter Beens", "stock": "Stock: 2 kg", "price": "150", "unit": "kg", "hasPlus": true},
      {"name": "Carrot", "stock": "Stock: 46 kg", "price": "25", "unit": "kg", "hasPlus": true},
      {"name": "Celari", "stock": "Stock: 6 kg", "price": "45", "unit": "kg", "hasPlus": true},
      {"name": "Chilly", "stock": "Stock: 5.25 kg", "price": "60", "unit": "kg", "hasPlus": true},
    ],
    "UNCATEGORIZED": [
      {"name": "PB Super Moist Vanilla 5 kg", "stock": "Stock: 2 pkt", "price": "650", "unit": "pkt", "hasPlus": false},
    ]
  };

  @override
  Widget build(BuildContext context) {
    // Get the current list of materials based on the selected tab
    List<Map<String, dynamic>> currentMaterials = categoryData[selectedCategory] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          _buildTabs(),
          Expanded(
            child: _buildMatrixTable(currentMaterials),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          // Back Button
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.white, size: 14),
                  SizedBox(width: 6),
                  Text("Back", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          // Titles
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Daily Usage Manual Batch", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              Row(
                children: const [
                  Text("Create bulk transfers for ", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text("17-05-2026", style: TextStyle(fontSize: 12, color: Color(0xFF0D6EFD), fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Search Box
          Container(
            width: 250, height: 38,
            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade300)),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search materials globally...", hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                prefixIcon: Icon(Icons.search, size: 16, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.only(top: 6),
              ),
            ),
          ),
          const SizedBox(width: 15),
          // Date Field
          SizedBox(
            width: 130, height: 38,
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: "17-05-2026", hintStyle: const TextStyle(fontSize: 13, color: Colors.black87),
                suffixIcon: const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black54),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
              ),
            ),
          ),
          const SizedBox(width: 15),
          // Batch Dropdown
          Container(
            width: 130, height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedBatch,
                isExpanded: true,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
                icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                items: ["Batch 01", "Batch 02", "Batch 03", "Batch 4", "main test"].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                onChanged: (v) => setState(() => selectedBatch = v!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((cat) {
            bool isUncategorized = cat == "UNCATEGORIZED";
            bool isSelected = selectedCategory == cat;
            return InkWell(
              onTap: () => setState(() => selectedCategory = cat), // Update selected tab
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: isSelected ? const Color(0xFF0D6EFD) : Colors.transparent, width: 2))),
                child: Text(
                  cat,
                  style: TextStyle(
                    color: isUncategorized ? Colors.red : (isSelected ? const Color(0xFF0D6EFD) : const Color(0xFF475569)),
                    fontWeight: FontWeight.bold, fontSize: 11,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMatrixTable(List<Map<String, dynamic>> materials) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          headingRowHeight: 50,
          dataRowHeight: 70,
          columnSpacing: 20,
          headingRowColor: MaterialStateProperty.all(const Color(0xFFF8FAFC)),
          border: TableBorder(
            verticalInside: BorderSide(color: Colors.grey.shade200),
            horizontalInside: BorderSide(color: Colors.grey.shade200),
          ),
          columns: [
            const DataColumn(label: Text("MATERIAL NAME", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF475569)))),
            const DataColumn(label: Text("PRICE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF0D6EFD)))),
            const DataColumn(label: Text("UNIT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF475569)))),
            ...outlets.map((o) => DataColumn(label: Text(o, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 9, color: Color(0xFF475569))))).toList(),
            DataColumn(label: Container(color: const Color(0xFFF0F8FF), padding: const EdgeInsets.all(8), child: const Text("TOTAL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF0D6EFD))))),
            DataColumn(label: Container(color: const Color(0xFFF0FFF0), padding: const EdgeInsets.all(8), child: const Text("AMOUNT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Color(0xFF10B981))))),
          ],
          rows: materials.map((mat) {
            return DataRow(
              cells: [
                DataCell(
                  SizedBox(
                    width: 170, // Fixed width to ensure smooth layout
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(mat['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B)), maxLines: 2, overflow: TextOverflow.ellipsis),
                              if (mat['stock'].toString().isNotEmpty)
                                Text(mat['stock'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF10B981))),
                            ],
                          ),
                        ),
                        if (mat['hasPlus'] == true) const Icon(Icons.add_circle, color: Color(0xFF3B82F6), size: 18),
                      ],
                    ),
                  ),
                ),
                DataCell(Row(children: [const Text("₹ ", style: TextStyle(color: Colors.grey, fontSize: 10)), Text(mat['price'], style: const TextStyle(color: Color(0xFF0D6EFD), fontWeight: FontWeight.bold))])),
                DataCell(Text(mat['unit'], style: const TextStyle(fontSize: 12, color: Color(0xFF475569)))),
                ...outlets.map((o) => const DataCell(Center(child: Text("-", style: TextStyle(color: Colors.grey))))).toList(),
                DataCell(Container(color: const Color(0xFFF0F8FF), alignment: Alignment.center, child: const Text("-", style: TextStyle(color: Colors.grey)))),
                DataCell(Container(color: const Color(0xFFF0FFF0), alignment: Alignment.center, child: const Text("-", style: TextStyle(color: Colors.grey)))),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: const [
                Text("Outlets: ", style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text("20", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: const Color(0xFFECFDF5), border: Border.all(color: const Color(0xFF34D399)), borderRadius: BorderRadius.circular(6)),
            child: Row(
              children: const [
                Text("TOTAL ITEMS TRANSFERRING: ", style: TextStyle(color: Color(0xFF059669), fontSize: 12, fontWeight: FontWeight.bold)),
                Text("0", style: TextStyle(color: Color(0xFF059669), fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("GRAND TOTAL AMOUNT", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
              Text("₹ 0.00", style: TextStyle(color: Color(0xFF0D6EFD), fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(width: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.print, size: 18),
            label: const Text("Save & Print Bills"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6), foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
            ),
          ),
        ],
      ),
    );
  }
}