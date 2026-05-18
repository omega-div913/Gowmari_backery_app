import 'package:flutter/material.dart';
import 'package:gowmari_mobile/screens/components/app_sidebar.dart'; // Import sidebar from components

class MainLayout extends StatelessWidget {
  final Widget child;
  final String breadcrumb;
  
  const MainLayout({super.key, required this.child, required this.breadcrumb});

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
              title: Text(breadcrumb.split('/').last.trim(), 
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar shows only on large screens
          if (!isMobile) const SizedBox(width: 260, child: AppSidebar()),

          Expanded(
            child: Column(
              children: [
                if (!isMobile) AppTopbar(breadcrumb: breadcrumb),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- TOPBAR ---
class AppTopbar extends StatelessWidget {
  final String breadcrumb;
  const AppTopbar({super.key, required this.breadcrumb});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, color: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.grey),
          const SizedBox(width: 15),
          Text(breadcrumb, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600)),
          const Spacer(),
          Container(
            width: 300, height: 38, 
            decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(20)),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search menus...", 
                prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey), 
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10)
              )
            ),
          ),
          const SizedBox(width: 20),
          const CircleAvatar(radius: 18, backgroundColor: Color(0xFF0D6EFD), child: Text("R", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}