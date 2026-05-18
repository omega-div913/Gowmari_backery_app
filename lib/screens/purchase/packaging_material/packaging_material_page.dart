import 'package:flutter/material.dart';
import '../../components/app_sidebar.dart'; 
import 'subsidebar.dart';
import 'purchase_entry.dart';
import 'purchase_order.dart';
import 'invoice_management.dart';

class PackagingMaterialPage extends StatefulWidget {
  const PackagingMaterialPage({super.key});

  @override
  State<PackagingMaterialPage> createState() => _PackagingMaterialPageState();
}

class _PackagingMaterialPageState extends State<PackagingMaterialPage> {
  // Main Tab State
  OperationTab _activeTab = OperationTab.purchaseEntry;
  
  // Track create/edit modes strictly to show correct Title in Appbar
  bool _isCreatingNew = false;
  bool _isEditing = false;

  void _onTabChanged(OperationTab tab) {
    setState(() {
      _activeTab = tab;
      _isCreatingNew = false;
      _isEditing = false;
    });
  }

  void _onModeChanged(bool creating, bool editing) {
    // We delay slightly to avoid rebuilding during a build
    Future.microtask(() {
      if(mounted) {
        setState(() {
          _isCreatingNew = creating;
          _isEditing = editing;
        });
      }
    });
  }

  String _getTitle() {
    if (_activeTab == OperationTab.purchaseEntry) {
      if (_isEditing) return "Edit Purchase Entry";
      return _isCreatingNew ? "New Purchase Entry" : "Packaging Material";
    } else if (_activeTab == OperationTab.purchaseOrder) {
      if (_isEditing) return "Edit Purchase Order";
      return _isCreatingNew ? "New Purchase Order" : "Packaging Orders";
    }
    return "Packaging Invoice Management";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1100;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      // FIX 1: Removed 'const' because AppSidebar() is likely not a constant.
      drawer: isMobile ? Drawer(child: AppSidebar()) : null,
      appBar: isMobile ? AppBar(
        backgroundColor: Colors.white, elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(_getTitle(), style: const TextStyle(color: Colors.black, fontSize: 16)),)
          : null,
      body: Row(
        children: [
          // FIX 2: Removed 'const' because AppSidebar() is likely not a constant.
          if (!isMobile) SizedBox(width: 260, child: AppSidebar()),
          Expanded(
            child: Column(
              children: [
                if (!isMobile) _buildTopBar(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PackagingSubSidebar(
                                activeTab: _activeTab,
                                onTabChanged: _onTabChanged,
                                isMobile: true,
                              ),
                              Expanded(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: _buildMainContent(),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PackagingSubSidebar(
                                activeTab: _activeTab,
                                onTabChanged: _onTabChanged,
                                isMobile: false,
                              ),
                              Expanded(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: _buildMainContent(),
                                ),
                              ),
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

  Widget _buildMainContent() {
    if (_activeTab == OperationTab.purchaseEntry) {
      return PurchaseEntryView(onModeChange: _onModeChanged);
    } else if (_activeTab == OperationTab.purchaseOrder) {
      return PurchaseOrderView(onModeChange: _onModeChanged);
    } else {
      // This is okay to be const if InvoiceManagementView has a const constructor
      return const InvoiceManagementView();
    }
  }

  Widget _buildTopBar() {
    String breadcrumb = "Home / Purchase Section / Packaging Material";
    if (_activeTab == OperationTab.purchaseOrder) {
      breadcrumb = "Home / Packaging Material / Packaging Orders";
    } else if (_activeTab == OperationTab.invoiceManagement) {
      breadcrumb = "Home / Packaging Material / Packaging Invoices";
    }

    return Container(
      height: 70, color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey),
          const SizedBox(width: 15),
          Text(breadcrumb, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const Spacer(),
          Container( width: 300, height: 38,
            decoration: BoxDecoration( color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
            // FIX 3: Removed 'const' because TextField is never a constant.
            child: TextField(
                decoration: InputDecoration( hintText: "Search menus...",
                    prefixIcon: Icon(Icons.search, size: 20),
                    border: InputBorder.none)),
          ),
          const SizedBox(width: 20),
          const CircleAvatar( radius: 18, backgroundColor: Colors.blue,
              child: Text("RTS", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}