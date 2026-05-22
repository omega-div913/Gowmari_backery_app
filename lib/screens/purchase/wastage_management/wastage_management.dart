import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/components/app_sidebar.dart';

class WastageItemData {
  final String name;
  final double stock;
  final String unit;
  double wastageCount;
  String reason;

  WastageItemData({
    required this.name,
    required this.stock,
    required this.unit,
    this.wastageCount = 0.00,
    this.reason = 'Damage',
  });
}

class ExpiredItemData {
  final String name;
  final String batchNo;
  final String purchaseDate;
  final String expiryDate;
  final int availableQty;
  final String unit;

  ExpiredItemData({
    required this.name,
    required this.batchNo,
    required this.purchaseDate,
    required this.expiryDate,
    required this.availableQty,
    required this.unit,
  });
}

class OutletReturnData {
  final String date;
  final String outletName;
  final String rawMaterial;
  final String quantity;
  final String status;

  OutletReturnData({
    required this.date,
    required this.outletName,
    required this.rawMaterial,
    required this.quantity,
    required this.status,
  });
}

class WastageManagementPage extends StatefulWidget {
  const WastageManagementPage({super.key});

  @override
  State<WastageManagementPage> createState() => _WastageManagementPageState();
}

class _WastageManagementPageState extends State<WastageManagementPage> {
  int _selectedTabIndex = 0;

  // Filters for Outlet RM Returns
  String _selectedOutlet = 'All Outlets';
  String _selectedStatus = 'All Statuses';

  final List<String> _outlets = [
    'All Outlets', 'BODI-1', 'NAINAAS', 'PC', 'ITI', 'FOREST ROAD', 'LPM', 'GMB',
    'AL', 'RN', 'SR PURAM', 'AMBA', 'MANDAPAM', 'BODI-2', 'TEST', 'COVAI',
    'N.R (PURCHASE)', 'N.RESTAURANT', 'N.RESTAURANT ( ITI )'
  ];

  final List<String> _statuses = [
    'All Statuses', 'Pending Factory', 'Received', 'Reconsumed', 'Pending Admin Dispose', 'Disposed'
  ];

  // Mock Data for Tab 0: Manual Wastage Entry
  final List<WastageItemData> _items = [
    WastageItemData(name: "1 kg P.P Cover", stock: 549.00, unit: "Units"),
    WastageItemData(name: "1 kg Birthday Cake Box", stock: 165.00, unit: "Units"),
    WastageItemData(name: "1 kg Cake Bag", stock: 179.00, unit: "Units"),
    WastageItemData(name: "1 kg Square Cake Bottom", stock: 0.00, unit: "Units"),
    WastageItemData(name: "1 kg Sweet Box", stock: 220.00, unit: "Units"),
    WastageItemData(name: "1 kg Sweet Container", stock: 219.00, unit: "Units"),
    WastageItemData(name: "1 kg Sweet Sticker New (100 gms = 19 Pcs)", stock: 500.00, unit: "Units"),
  ];

  // Mock Data for Tab 1: Detected Expired Items
  final List<ExpiredItemData> _expiredItems = [
    ExpiredItemData(name: "7- up Fizz", batchNo: "RB260415-01-1036", purchaseDate: "15 Apr 2026", expiryDate: "22 Apr 2026", availableQty: 6, unit: "nos"),
    ExpiredItemData(name: "Karuda Dates Black - 200 gms", batchNo: "RB260423-01-1032", purchaseDate: "23 Apr 2026", expiryDate: "24 Apr 2026", availableQty: 10, unit: "nos"),
    ExpiredItemData(name: "7- up Fizz", batchNo: "RB260424-03-1036", purchaseDate: "24 Apr 2026", expiryDate: "25 Apr 2026", availableQty: 5, unit: "nos"),
    ExpiredItemData(name: "TESTP1", batchNo: "RB260430-01-993", purchaseDate: "30 Apr 2026", expiryDate: "01 May 2026", availableQty: 7, unit: "box"),
    ExpiredItemData(name: "TESTP1", batchNo: "RB260504-01-993-0", purchaseDate: "04 May 2026", expiryDate: "05 May 2026", availableQty: 1, unit: "box"),
    ExpiredItemData(name: "TESTP1", batchNo: "RB260504-02-993-0", purchaseDate: "04 May 2026", expiryDate: "05 May 2026", availableQty: 1, unit: "box"),
  ];

  // Mock Data for Tab 2: Outlet RM Returns
  final List<OutletReturnData> _outletReturns = [
    OutletReturnData(date: "26 Apr 2026", outletName: "TEST", rawMaterial: "Sugar", quantity: "10.000 kg", status: "Pending Factory Receive"),
    OutletReturnData(date: "26 Apr 2026", outletName: "TEST", rawMaterial: "Chocolate Powder", quantity: "10.000 kg", status: "Pending Factory Receive"),
    OutletReturnData(date: "26 Apr 2026", outletName: "TEST", rawMaterial: "Milk Powder", quantity: "10.000 kg", status: "Pending Factory Receive"),
    OutletReturnData(date: "26 Apr 2026", outletName: "TEST", rawMaterial: "Fruit Jam Can", quantity: "10.000 pcs", status: "Pending Factory Receive"),
  ];

  @override
  Widget build(BuildContext context) {
    int currentItemCount = _selectedTabIndex == 0
        ? _items.length
        : (_selectedTabIndex == 1 ? _expiredItems.length : _outletReturns.length);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          const AppSidebar(activeMenu: "Wastage Management"),
          Expanded(
            child: Column(
              children: [
                _buildTopBreadcrumb(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildPageHeader(),
                          _buildTabs(),
                          _buildSearchBarAndFilters(currentItemCount),
                          _buildTableHeaders(),
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                              itemCount: currentItemCount,
                              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                              itemBuilder: (context, index) {
                                if (_selectedTabIndex == 0) {
                                  return _WastageRowItem(item: _items[index]);
                                } else if (_selectedTabIndex == 1) {
                                  return _ExpiredRowItem(
                                    item: _expiredItems[index],
                                    onConfirm: () => _showConfirmDialog(_expiredItems[index]),
                                  );
                                } else if (_selectedTabIndex == 2) {
                                  return _OutletReturnRowItem(
                                    item: _outletReturns[index],
                                    onReceive: () => _showReceiveConfirmDialog(),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
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

  Widget _buildTopBreadcrumb() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Color(0xFF64748B)),
          const SizedBox(width: 16),
          const Text("Home / Purchase Section / ", style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
          const Text("Wastage Management", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 14)),
          const Spacer(),
          Container(
            width: 250,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search menus ( Press / )",
                hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                prefixIcon: Icon(Icons.search, size: 18, color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF0D6EFD),
            child: Text("R", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          const Text("RTS", style: TextStyle(fontWeight: FontWeight.bold)),
          const Icon(Icons.arrow_drop_down, color: Color(0xFF64748B)),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF3FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 14, color: Color(0xFF0D6EFD)),
                    SizedBox(width: 6),
                    Text("Purchase Module", style: TextStyle(color: Color(0xFF0D6EFD), fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text("Raw Material Wastage", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 4),
              const Text("Report manual wastage or clear expired items from your inventory.", style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
            ],
          ),
          Row(
            children: [
              _buildActionButton(Icons.picture_as_pdf_outlined, "PDF", Colors.redAccent),
              const SizedBox(width: 12),
              _buildActionButton(Icons.table_view_outlined, "Excel", Colors.green),
              const SizedBox(width: 12),
              _buildActionButton(Icons.refresh, "Refresh", Colors.black87),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16, color: color),
      label: Text(label, style: const TextStyle(color: Color(0xFF475569))),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))),
      child: Row(
        children: [
          _buildTabItem(0, "Manual Wastage Entry", Icons.list_alt_outlined),
          _buildTabItem(1, "Detected Expired Items", Icons.warning_amber_rounded, badge: "6"),
          _buildTabItem(2, "Outlet RM Returns", Icons.storefront_outlined),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String title, IconData icon, {String? badge}) {
    bool isSelected = _selectedTabIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: isSelected ? const Color(0xFF0D6EFD) : Colors.transparent, width: 2),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? const Color(0xFF0D6EFD) : const Color(0xFF94A3B8)),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? const Color(0xFF0D6EFD) : const Color(0xFF64748B),
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: const Color(0xFFDC3545), borderRadius: BorderRadius.circular(10)),
                child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBarAndFilters(int count) {
    if (_selectedTabIndex == 2) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search items...",
                  hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF0D6EFD))),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildFilterDropdown(
                          value: _selectedOutlet,
                          items: _outlets,
                          onChanged: (val) => setState(() => _selectedOutlet = val!),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildFilterDropdown(
                          value: _selectedStatus,
                          items: _statuses,
                          onChanged: (val) => setState(() => _selectedStatus = val!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildDatePicker("dd-05-2026"),
                  const SizedBox(height: 8),
                  _buildDatePicker("22-05-2026"),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                    child: const Text("Reset", style: TextStyle(color: Color(0xFF475569))),
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search items...",
                  hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF0D6EFD))),
                ),
              ),
            ),
            Text("Showing $count item(s)", style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600, fontSize: 13)),
          ],
        ),
      );
    }
  }

  Widget _buildFilterDropdown({required String value, required List<String> items, required ValueChanged<String?> onChanged}) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF64748B)),
          style: const TextStyle(color: Color(0xFF475569), fontSize: 13),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(value: val, child: Text(val, overflow: TextOverflow.ellipsis));
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDatePicker(String hintText) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hintText, style: const TextStyle(color: Color(0xFF475569), fontSize: 13)),
          const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF64748B)),
        ],
      ),
    );
  }

  Widget _buildTableHeaders() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0)), bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: _selectedTabIndex == 0
            ? const [
                Expanded(flex: 3, child: Text("PRODUCT DETAILS", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text("SYSTEM STOCK", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text("WASTAGE COUNT", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text("REASON", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text("ACTION", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
              ]
            : _selectedTabIndex == 1
                ? const [
                    Expanded(flex: 3, child: Text("ITEM DETAILS", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                    Expanded(flex: 3, child: Text("BATCH INFO", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text("EXPIRY DATE", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text("AVAILABLE QTY", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text("ACTION", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                  ]
                : const [
                    Expanded(flex: 2, child: Text("DATE", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text("OUTLET NAME", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                    Expanded(flex: 3, child: Text("RAW MATERIAL", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text("QUANTITY", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                    Expanded(flex: 3, child: Text("STATUS", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text("FACTORY ACTION", style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold))),
                  ],
      ),
    );
  }

  void _showConfirmDialog(ExpiredItemData item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 480,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Color(0xFF0D6EFD), size: 24),
                    const SizedBox(width: 12),
                    const Text("Confirm Expired Item", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                    const Spacer(),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: Color(0xFF94A3B8), size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Are you sure you want to declare this expired batch as wastage? This will reduce the stock immediately.",
                  style: TextStyle(color: Color(0xFF475569), fontSize: 14, height: 1.5),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Item:", style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                          Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B), fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Batch:", style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                          Text(item.batchNo, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B), fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text("ACTUAL WASTAGE QTY", style: TextStyle(color: Color(0xFF475569), fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextField(
                            controller: TextEditingController(text: item.availableQty.toString()),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF0D6EFD), width: 2)),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text("Max Available: ${item.availableQty}", style: const TextStyle(color: Color(0xFF0D6EFD), fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(item.unit, style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("REMARKS (OPTIONAL)", style: TextStyle(color: Color(0xFF475569), fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Note down any specifics...",
                    hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                    contentPadding: const EdgeInsets.all(16),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF0D6EFD))),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: const BorderSide(color: Color(0xFFE2E8F0))),
                      ),
                      child: const Text("Cancel", style: TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D6EFD),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text("Confirm Reduction", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showReceiveConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFCBD5E1), width: 2),
                  ),
                  child: const Center(
                    child: Text("?", style: TextStyle(fontSize: 36, color: Color(0xFF94A3B8), fontWeight: FontWeight.w300)),
                  ),
                ),
                const SizedBox(height: 24),
                const Text("Confirm Action", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                const SizedBox(height: 12),
                const Text("Receive this RM Expiry?", style: TextStyle(color: Color(0xFF475569), fontSize: 15)),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D6EFD),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Text("Yes, Receive", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF64748B),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// -------------------------------------------------------------
// ROW ITEM FOR TAB 0 (Manual Wastage Entry)
// -------------------------------------------------------------
class _WastageRowItem extends StatefulWidget {
  final WastageItemData item;
  const _WastageRowItem({required this.item});
  @override
  State<_WastageRowItem> createState() => _WastageRowItemState();
}

class _WastageRowItemState extends State<_WastageRowItem> {
  late TextEditingController _countController;
  late String _selectedReason;
  final List<String> _reasons = ['Damage', 'Spoilage', 'Spillage', 'Theft', 'Other'];

  @override
  void initState() {
    super.initState();
    _countController = TextEditingController(text: widget.item.wastageCount.toStringAsFixed(2));
    _selectedReason = widget.item.reason;
  }

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF0D6EFD), size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.item.name, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                      const SizedBox(height: 2),
                      Text("Unit: ${widget.item.unit}", style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 2, child: Text(widget.item.stock.toStringAsFixed(2), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1E293B)))),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 38,
                  decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    controller: _countController,
                    textAlign: TextAlign.center,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(bottom: 12)),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 8),
                Text(widget.item.unit, style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFE2E8F0)), borderRadius: BorderRadius.circular(6)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedReason,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xFF94A3B8)),
                    style: const TextStyle(color: Color(0xFF475569), fontSize: 14),
                    onChanged: (String? newValue) {
                      if (newValue != null) setState(() => _selectedReason = newValue);
                    },
                    items: _reasons.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 140,
                height: 38,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send_outlined, size: 16, color: Colors.white),
                  label: const Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6DA0FF), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// ROW ITEM FOR TAB 1 (Detected Expired Items)
// -------------------------------------------------------------
class _ExpiredRowItem extends StatelessWidget {
  final ExpiredItemData item;
  final VoidCallback onConfirm;

  const _ExpiredRowItem({required this.item, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E293B)))),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.batchNo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1E293B))),
                const SizedBox(height: 4),
                Text("Purchased: ${item.purchaseDate}", style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFF64748B))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFF0D6EFD), borderRadius: BorderRadius.circular(16)),
                child: Text(item.expiryDate, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: RichText(
              text: TextSpan(
                text: "${item.availableQty} ",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0D6EFD)),
                children: [
                  TextSpan(text: item.unit, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Color(0xFF64748B))),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 150,
                height: 38,
                child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                  child: const Text("Confirm Wastage", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// ROW ITEM FOR TAB 2 (Outlet RM Returns)
// -------------------------------------------------------------
class _OutletReturnRowItem extends StatelessWidget {
  final OutletReturnData item;
  final VoidCallback onReceive;

  const _OutletReturnRowItem({required this.item, required this.onReceive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(item.date, style: const TextStyle(color: Color(0xFF475569), fontSize: 13, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 2,
            child: Text(item.outletName, style: const TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          Expanded(
            flex: 3,
            child: Text(item.rawMaterial, style: const TextStyle(color: Color(0xFF0D6EFD), fontWeight: FontWeight.w600, fontSize: 13)),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFF6B7280), borderRadius: BorderRadius.circular(24)),
                child: Text(item.quantity, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          // MODIFIED: Single solid color status pill to match exact second image
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107), // Amber/Yellow
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  item.status,
                  style: const TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // MODIFIED: Solid blue action button to match exact second image
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 36,
                width: 120,
                child: ElevatedButton.icon(
                  onPressed: onReceive,
                  icon: const Icon(Icons.download_outlined, size: 16, color: Colors.white),
                  label: const Text("Receive", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D6EFD),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}