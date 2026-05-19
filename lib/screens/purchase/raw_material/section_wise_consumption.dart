import 'package:flutter/material.dart';
import '../../components/app_sidebar.dart'; 
import 'subsidebar.dart'; 
import 'record_section_consumption.dart';

class SectionWiseConsumptionScreen extends StatefulWidget {
  const SectionWiseConsumptionScreen({Key? key}) : super(key: key);

  @override
  State<SectionWiseConsumptionScreen> createState() =>
      _SectionWiseConsumptionScreenState();
}

class _SectionWiseConsumptionScreenState extends State<SectionWiseConsumptionScreen> {
  DateTime? fromDate = DateTime.now();
  DateTime? toDate = DateTime.now();
  String? selectedSection;
  String? selectedSubSection;
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> tableData = [
    {"date": "19/05/2026", "time": "03:38 PM", "section": "KADALAI MITTAI", "sub": "-", "status": "Completed", "amount": "16435.83"},
    {"date": "19/05/2026", "time": "03:24 PM", "section": "KOLUKATTAI", "sub": "-", "status": "Completed", "amount": "7992.73"},
    {"date": "19/05/2026", "time": "03:19 PM", "section": "KITCHEN", "sub": "-", "status": "Completed", "amount": "8565.66"},
  ];

  // --- ACTIONS ---

  // IMAGE 2: VIEW BILL DETAILS DIALOG
  void _showViewDialog(BuildContext context, Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: 500,
          decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Consumption Bill Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.white70, size: 20)),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _billInfo("SECTION", data['section']),
                        _billInfo("SUB SECTION", data['sub']),
                        _billInfo("DATE & TIME", "${data['date']} ${data['time']}"),
                      ],
                    ),
                    const Divider(height: 30),
                    _billRow("Verkadalai", "₹178.00", "50.00 kg", "₹8900.00"),
                    _billRow("Mavu Vellam", "₹49.33", "11.00 kg", "₹542.63"),
                    _billRow("Vellam", "₹50.00", "15.00 kg", "₹750.00"),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFF0D6EFD), borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("TOTAL VALUE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text("₹${data['amount']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.print, color: Colors.white, size: 18),
                label: const Text("Print Thermal Receipt", style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20)),
              )
            ],
          ),
        ),
      ),
    );
  }

  // IMAGE 4: DELETE CONFIRMATION DIALOG
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.orangeAccent),
            const SizedBox(height: 20),
            const Text("Are you sure?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Deleting this will add the quantities back to your stock!", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEF4444), foregroundColor: Colors.white),
                  child: const Text("Yes, delete it!"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6), foregroundColor: Colors.white),
                  child: const Text("Cancel"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F9),
      body: Row(
        children: [
          const AppSidebar(activeMenu: "Raw Material"), 
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RawMaterialSubSidebar(activePage: 'Section Wise Consumption'),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPageHeader(),
                              const SizedBox(height: 20),
                              _buildFilterSection(),
                              const SizedBox(height: 20),
                              _buildDataTableGrid(),
                            ],
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

  // --- UI BUILDERS ---

  Widget _buildTopBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey, size: 20),
          const SizedBox(width: 15),
          const Text("Home", style: TextStyle(color: Colors.grey, fontSize: 13)),
          const Spacer(),
          Container(
            width: 300, height: 38,
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
            child: const TextField(decoration: InputDecoration(hintText: "Search menus ( Press / )", hintStyle: TextStyle(fontSize: 12, color: Colors.grey), prefixIcon: Icon(Icons.search, color: Colors.grey, size: 18), border: InputBorder.none, contentPadding: EdgeInsets.only(bottom: 10))),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(radius: 16, backgroundColor: Color(0xFF0D6EFD), child: Text("R", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
          const SizedBox(width: 8),
          const Text("RTS", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const Icon(Icons.arrow_drop_down, size: 18),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Section Wise Consumption', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF212529))),
            Text('Operational Material Usage Registry', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RecordSectionConsumptionScreen(isEdit: false))),
          icon: const Icon(Icons.add, size: 16),
          label: const Text('New Entry'),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D6EFD), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), elevation: 0),
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildField("FROM DATE", "19-05-2026", Icons.calendar_today)),
              const SizedBox(width: 15),
              Expanded(child: _buildField("TO DATE", "19-05-2026", Icons.calendar_today)),
              const SizedBox(width: 15),
              Expanded(child: _buildField("FILTER SECTIONS", "All Active Sections", Icons.keyboard_arrow_down)),
              const SizedBox(width: 15),
              Expanded(child: _buildField("FILTER SUB SECTIONS", "All Sub Sections", Icons.keyboard_arrow_down)),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(flex: 2, child: _buildField("SEARCH RECORDS", "Section, item, etc...", Icons.search)),
              const SizedBox(width: 15),
              ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E293B), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 19)), child: const Text("Filter")),
              const SizedBox(width: 10),
              IconButton(onPressed: () {}, icon: const Icon(Icons.refresh), style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6), side: BorderSide(color: Colors.grey.shade300)))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataTableGrid() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            color: const Color(0xFFF8FAFC),
            child: Row(
              children: [
                _tableHeaderText("DATE ↓", 1.5),
                _tableHeaderText("SECTION NAME ↑↓", 2),
                _tableHeaderText("SUB SECTION", 2),
                _tableHeaderText("STATUS", 1.5),
                _tableHeaderText("TOTAL AMOUNT ↑↓", 1.5),
                _tableHeaderText("ACTIONS", 1.5),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: tableData.length,
            separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey.shade100),
            itemBuilder: (context, index) {
              final item = tableData[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                child: Row(
                  children: [
                    Expanded(flex: 15, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item['date'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text(item['time'], style: const TextStyle(fontSize: 11, color: Colors.grey))])),
                    Expanded(flex: 20, child: Text(item['section'], style: const TextStyle(color: Color(0xFF0D6EFD), fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 20, child: Text(item['sub'])),
                    Expanded(flex: 15, child: _statusBadge(item['status'])),
                    Expanded(flex: 15, child: Text("₹${item['amount']}", style: const TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 15, child: Row(children: [
                      _actionIcon(Icons.visibility_outlined, Colors.grey, () => _showViewDialog(context, item)),
                      _actionIcon(Icons.edit_note_outlined, Colors.orange, () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecordSectionConsumptionScreen(isEdit: true, initialSection: item['section'])))),
                      _actionIcon(Icons.delete_outline, Colors.red, () => _showDeleteDialog(context)),
                      _actionIcon(Icons.print_outlined, Colors.blue, () {}),
                    ])),
                  ],
                ),
              );
            },
          ),
          _pagination()
        ],
      ),
    );
  }

  Widget _billInfo(String label, String value) => Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)), Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))]));
  Widget _billRow(String desc, String rate, String qty, String amt) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(flex: 2, child: Text(desc, style: const TextStyle(fontSize: 12))), Expanded(child: Text(rate, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12))), Expanded(child: Text(qty, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))), Expanded(child: Text(amt, textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)))]));
  Widget _statusBadge(String s) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(4)), child: Text(s, style: const TextStyle(fontSize: 10, color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)));
  Widget _actionIcon(IconData i, Color c, VoidCallback onTap) => InkWell(onTap: onTap, child: Container(margin: const EdgeInsets.only(right: 5), padding: const EdgeInsets.all(4), decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade200)), child: Icon(i, size: 16, color: i == Icons.visibility_outlined ? Colors.grey : c)));
  Widget _pagination() => Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Showing 1 to 3 of 3 entries", style: TextStyle(fontSize: 12, color: Colors.grey)), Row(children: [_pageBtn("Previous", false), const SizedBox(width: 5), _pageBtn("1", true), const SizedBox(width: 5), _pageBtn("Next", false)])]));
  Widget _pageBtn(String t, bool a) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: a ? const Color(0xFF0D6EFD) : Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)), child: Text(t, style: TextStyle(fontSize: 12, color: a ? Colors.white : Colors.black87)));
  Widget _tableHeaderText(String t, double f) => Expanded(flex: (f * 10).toInt(), child: Text(t, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B))));
  Widget _buildField(String l, String v, IconData i) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 8), Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(6)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(v, style: const TextStyle(fontSize: 13)), Icon(i, size: 14, color: Colors.grey)]))]);
}