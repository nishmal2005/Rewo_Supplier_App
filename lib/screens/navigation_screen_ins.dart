import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewo_supplier/screens/home_screen.dart';
import 'package:rewo_supplier/screens/transporter/earnings_page.dart';
import 'package:rewo_supplier/screens/transporter/profile.dart';
import 'package:rewo_supplier/screens/transporter/transporter_list.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    OrdersListScreen(),            
     SupplierDetailsScreen (),     
    EarningsPage(),             
    TransporterProfileScreen(),             
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: OrdersListScreen.customGreen,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        iconSize: 20,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_sharp), label: "Transporter"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Earnings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
