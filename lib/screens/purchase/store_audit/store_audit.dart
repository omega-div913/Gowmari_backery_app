import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// FIXED: Using the absolute package path so it always finds the sidebar correctly
import 'package:gowmari_mobile/screens/components/app_sidebar.dart';

class StoreAuditPage extends StatefulWidget {
  const StoreAuditPage({super.key});

  @override
  State<StoreAuditPage> createState() => _StoreAuditPageState();
}

class _StoreAuditPageState extends State<StoreAuditPage> {
  // State to manage the current active step
  int _currentStep = 1;
  // State to manage the toggle between Mouse and Keyboard mode
  bool _isMouseMode = true;

  // Dummy data for the product list
  final List<Map<String, String>> _products = [
    {"name": "1 kg P.P Cover", "stock": "549.00"},
    {"name": "1 kg Birthday Cake Box", "stock": "165.00"},
    {"name": "1 kg Cake Bag", "stock": "179.00"},
    {"name": "1 kg Square Cake Bottom", "stock": "74.00"},
    {"name": "1 kg Sweet Box", "stock": "220.00"},
    {"name": "1 kg Sweet Container", "stock": "219.00"},
    {"name": "1 kg Sweet Sticker New (100 gms = 19 Pcs)", "stock": "500.00"},
    {"name": "1 Parcel Covers", "stock": "510.00"},
    {"name": "1.5 kg Square Cake Bottom", "stock": "449.00"},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F9),
      body: Row(
        children: [
          const AppSidebar(activeMenu: "Store Audit"),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        _buildPageTitleBar(),
                        const SizedBox(height: 30),
                        _buildStepper(),
                        const SizedBox(height: 30),
                        // Conditionally build the view based on the current step
                        _buildStepContent(),
                      ],
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

  // --- HEADER ---
  Widget _buildHeader() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Color(0xFF64748B), size: 20),
          const SizedBox(width: 20),
          const Text(
            "Home / Purchase Section / Inventory Audit Entry",
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
          ),
          const Spacer(),
          Container(
            width: 300,
            height: 38,
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search menus ( Press / )",
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 6),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFF0D6EFD),
            child: Text("R", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          const Text("RTS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const Icon(Icons.arrow_drop_down, size: 20),
        ],
      ),
    );
  }

  // --- PAGE TITLE BAR ---
  Widget _buildPageTitleBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFF0D6EFD), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.inventory_2_outlined, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Physical Inventory Audit", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
              const SizedBox(height: 4),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(text: "Audit for ", style: TextStyle(fontFamily:'Roboto', color: Colors.grey, fontSize: 13)),
                    TextSpan(text: "Purchase", style: TextStyle(fontFamily:'Roboto', color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold)),
                    TextSpan(text: " | Date: ", style: TextStyle(fontFamily:'Roboto', color: Colors.grey, fontSize: 13)),
                    TextSpan(text: "18 May 2026", style: TextStyle(fontFamily:'Roboto', color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text("Refresh", style: TextStyle(fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black87,
              side: BorderSide(color: Colors.grey.shade300),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(width: 15),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.send, size: 16),
            label: const Text("SUBMIT AUDIT (0)", style: TextStyle(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  // --- STEPPER ---
  Widget _buildStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepItem("1. Setup", "(Alt+1)", 1),
        const SizedBox(width: 15),
        _buildStepItem("2. Data Entry", "(Alt+2)", 2),
        const SizedBox(width: 15),
        _buildStepItem("3. Audit Status", "(Alt+3)", 3),
      ],
    );
  }

  Widget _buildStepItem(String title, String shortcut, int stepIndex) {
    bool isActive = _currentStep == stepIndex;
    return InkWell(
      onTap: () => setState(() => _currentStep = stepIndex),
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0D6EFD) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: isActive ? null : Border.all(color: Colors.grey.shade300),
          boxShadow: isActive ? [BoxShadow(color: const Color(0xFF0D6EFD).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : null,
        ),
        child: Row(
          children: [
            Icon(
              stepIndex == 1 ? Icons.settings_outlined : stepIndex == 2 ? Icons.edit_note_outlined : Icons.checklist_rtl_outlined,
              color: isActive ? Colors.white : Colors.grey, size: 16),
            const SizedBox(width: 8),
            Text(title, style: TextStyle(color: isActive ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(width: 6),
            Text(shortcut, style: TextStyle(color: isActive ? Colors.white70 : Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
  
  // --- CONDITIONAL CONTENT WIDGET ---
  Widget _buildStepContent() {
    switch (_currentStep) {
      case 1:
        return _buildAuditConfigurationCard();
      case 2:
        return _buildDataEntryView();
      case 3:
        return _buildAuditStatusView(); // <-- NEW VIEW ADDED HERE
      default:
        return _buildAuditConfigurationCard();
    }
  }

  // --- STEP 1: AUDIT CONFIGURATION CARD ---
  Widget _buildAuditConfigurationCard() {
    return Container(
      width: 700,
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          const Text("Audit Configuration", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0D6EFD))),
          const SizedBox(height: 25),
          const Text("SELECT AUDIT DATE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2)),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "18-05-2026",
              hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.black87),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: const [
                      Text("0", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87)),
                      SizedBox(height: 5),
                      Text("AUDITED TODAY", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: const [
                      Text("766", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFFDC2626))),
                      SizedBox(height: 5),
                      Text("PENDING ITEMS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 35),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => setState(() => _currentStep = 2),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D6EFD),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                elevation: 4,
                shadowColor: const Color(0xFF0D6EFD).withOpacity(0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("PROCEED TO DATA ENTRY", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- STEP 2: DATA ENTRY VIEW (Main container for both modes) ---
  Widget _buildDataEntryView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildModeButton("Mouse Mode", Icons.mouse_outlined, _isMouseMode),
            const SizedBox(width: 10),
            _buildModeButton("Keyboard Mode", Icons.keyboard_alt_outlined, !_isMouseMode),
          ],
        ),
        const SizedBox(height: 20),
        _isMouseMode ? _buildMouseModeView() : _buildKeyboardModeView(),
      ],
    );
  }

  Widget _buildModeButton(String text, IconData icon, bool isActive){
    return ElevatedButton.icon(
      onPressed: (){
        if(text.contains("Mouse")){
          setState(() => _isMouseMode = true);
        } else {
          setState(() => _isMouseMode = false);
        }
      },
      icon: Icon(icon, size: 16, color: isActive ? Colors.white : const Color(0xFF0D6EFD)),
      label: Text(text, style: TextStyle(color: isActive ? Colors.white : const Color(0xFF0D6EFD), fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? const Color(0xFF0D6EFD) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: isActive ? Colors.transparent : const Color(0xFF0D6EFD))
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        elevation: isActive ? 2 : 0,
      ),
    );
  }

  Widget _buildMouseModeView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Container(
            height: 600,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type name to search... (Alt+S)",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300)
                      ),
                       enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300)
                      ),
                       focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF0D6EFD))
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10)
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.flash_on, color: Colors.orange, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "QUICK ADD (REMAINING)",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Color(0xFFE2E8F0)),
                Expanded(
                  child: ListView.separated(
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return ListTile(
                        leading: InkWell(
                          onTap: (){},
                          child: const CircleAvatar(
                            backgroundColor: Color(0xFFF1F5F9),
                            child: Icon(Icons.add, color: Color(0xFF64748B), size: 20)
                          ),
                        ),
                        title: Text(product['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        subtitle: Text("System: ${product['stock']!} Units", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        trailing: IconButton(
                          icon: const Icon(Icons.add_shopping_cart_outlined, color: Color(0xFF64748B)),
                          onPressed: () {},
                        ),
                      );
                    },
                     separatorBuilder: (context, index) => const Divider(indent: 70, height: 1, color: Color(0xFFF1F5F9)),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          flex: 7,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: const BoxDecoration(
                    color: Color(0xFF212529),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 18),
                      const SizedBox(width: 10),
                      const Text("AUDIT CART", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      const Text("Ready to submit: 0 items", style: TextStyle(color: Colors.white70, fontSize: 12)),
                      const Spacer(),
                        Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC107),
                          borderRadius: BorderRadius.circular(12)
                        ),
                          child: const Text("0", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
                        )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                        Expanded(flex: 4, child: Text("PRODUCT DETAILS", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold))),
                        Expanded(flex: 2, child: Text("SYSTEM STOCK", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold))),
                        Expanded(flex: 2, child: Text("PHYSICAL COUNT", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold))),
                        Expanded(flex: 1, child: Text("VARIANCE", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_basket_outlined, size: 60, color: Colors.grey.shade300),
                      const SizedBox(height: 20),
                      const Text("Your Audit Sheet is Empty", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
                      const SizedBox(height: 8),
                      const Text("Search and add products to start.", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
      ],
    );
  }

  Widget _buildKeyboardModeView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF212529),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("SEARCH PRODUCT (Enter to select first)", style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    TextField(
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: "Type product name... (Alt+S)",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide.none),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              const SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("QTY", style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "0",
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide.none),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: const Icon(Icons.add, weight: 900),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                height: 520,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      child: Text(
                        "REMAINING TO AUDIT",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    Expanded(
                      child: ListView.separated(
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          return ListTile(
                            title: Text(product['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            subtitle: Text("System Stock: ${product['stock']!} Units", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                             trailing: InkWell(
                              onTap: (){},
                              child: const CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xFFF1F5F9),
                                child: Icon(Icons.add, color: Color(0xFF64748B), size: 18)
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(indent: 16, endIndent: 16, height: 1, color: Color(0xFFF1F5F9)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              flex: 7,
              child: Container(
                height: 520,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                        border: Border(bottom: BorderSide(color: Color(0xFFDEE2E6)))
                      ),
                      child: Row(
                        children: [
                          const Text("CURRENT AUDIT CART", style: TextStyle(color: Color(0xFF495057), fontWeight: FontWeight.bold)),
                          const Spacer(),
                           Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFC107),
                              borderRadius: BorderRadius.circular(12)
                            ),
                             child: const Text("0 items", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                           )
                        ],
                      ),
                    ),
                     const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                           Expanded(flex: 4, child: Text("Item", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold))),
                           Expanded(flex: 2, child: Text("System", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold))),
                           Expanded(flex: 2, child: Text("Physical", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold))),
                           Expanded(flex: 1, child: Text("Variance", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    const Expanded(
                      child: Center(
                        child: Text("Empty", style: TextStyle(color: Colors.grey, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  // --- STEP 3: AUDIT STATUS VIEW ---
  Widget _buildAuditStatusView() {
    return Column(
      children: [
        // Search Bar
        TextField(
          decoration: InputDecoration(
            hintText: "Search across Pending, Submitted, and Finalized... (Alt+S)",
            hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
            prefixIcon: const Icon(Icons.search, size: 20, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
          ),
        ),
        const SizedBox(height: 25),
        // 3-Column Layout
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. PENDING Column
            Expanded(
              child: _buildStatusColumn(
                title: "1. PENDING",
                count: "766",
                icon: Icons.history_toggle_off,
                color: Colors.red,
                child: Expanded(
                  child: ListView.separated(
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        title: Text(product['name']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        subtitle: Text("Sys: ${product['stock']}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        trailing: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red.shade200)
                          ),
                          child: const Icon(Icons.add, color: Colors.red, size: 18),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
                  ),
                )
              )
            ),
            const SizedBox(width: 25),
            // 2. SUBMITTED Column
            Expanded(
              child: _buildStatusColumn(
                title: "2. SUBMITTED",
                count: "0",
                icon: Icons.send_outlined,
                color: Colors.blue,
                leftBorderColor: Colors.blue.shade100,
                child: const Expanded(
                  child: Center(
                    child: Text("No submitted items found.", style: TextStyle(color: Colors.grey)),
                  ),
                )
              ),
            ),
            const SizedBox(width: 25),
            // 3. FINALIZED Column
            Expanded(
              child: _buildStatusColumn(
                title: "3. FINALIZED",
                count: "0",
                icon: Icons.check_circle_outline,
                color: Colors.green,
                leftBorderColor: Colors.green.shade100,
                child: const Expanded(
                  child: Center(
                    child: Text("No finalized items found.", style: TextStyle(color: Colors.grey)),
                  ),
                )
              ),
            ),
          ],
        )
      ],
    );
  }

  // Helper widget for building each status column
  Widget _buildStatusColumn({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
    required Widget child,
    Color? leftBorderColor,
  }) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: leftBorderColor ?? Colors.transparent, width: 4),
        ),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          // Column Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 8),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Text(count, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
                )
              ],
            ),
          ),
          const Divider(height: 1),
          // Column Content
          child,
        ],
      ),
    );
  }
}