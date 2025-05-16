import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewo_supplier/screens/transporter/transporter_list.dart';


class OrdersListScreen extends StatelessWidget {
  final ValueNotifier<bool> isOnline = ValueNotifier<bool>(true);
  final ValueNotifier<int> selectedTabIndex = ValueNotifier<int>(0);
  static const Color customGreen = Color(0xFF557669);

  OrdersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: _buildBottomNavBar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Orders List", style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,color: Colors.grey,)
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // ✅ Row with Hamburger and Notification Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ✅ Box for Menu Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Light Grey Background
                    borderRadius: BorderRadius.circular(8), // Rounded Corners
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black),
                    onPressed: () {},
                  ),
                ),

                // ✅ Box for Notification Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Light Grey Background
                    borderRadius: BorderRadius.circular(8), // Rounded Corners
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.notifications_none_outlined, color: Colors.black),
                    onPressed: () {},
                  ),
                ),
              ],
            ),


            const SizedBox(height: 8),

            // ✅ Welcome Text
            const Text("Hi, Subair", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 8),
            _buildOnlineToggle(),
            const SizedBox(height: 10),
            _buildTabs(),
            const SizedBox(height: 10),
            Expanded(child: SingleChildScrollView(child: _buildOrderCard())),
          ],
        ),
      ),
    );
  }

  // ✅ Online Toggle
  Widget _buildOnlineToggle() {
    return ValueListenableBuilder<bool>(
      valueListenable: isOnline,
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: customGreen,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Online", style: TextStyle(fontSize: 16, color: Colors.white,)),
              Switch(
                value: value,
                onChanged: (newValue) => isOnline.value = newValue,
                activeColor: customGreen,
              ),
            ],
          ),
        );
      },
    );
  }

  // ✅ Tabs for Pending, Active Orders, Completed
  Widget _buildTabs() {
    return ValueListenableBuilder<int>(
      valueListenable: selectedTabIndex,
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white, // Background color
            border: Border.all(color: Colors.grey.shade300, width: 1), // Light Grey Border
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow Color
                blurRadius: 6,
                offset: const Offset(0, 3), // Shadow Position
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _tabItem("Pending", 0, value),
              _tabItem("Active Orders", 1, value),
              _tabItem("Completed", 2, value),
            ],
          ),
        );
      },
    );
  }


  Widget _tabItem(String text, int index, int selectedIndex) {
    bool isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => selectedTabIndex.value = index,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          border: isSelected ? const Border(bottom: BorderSide(color: customGreen, width: 2)) : null,
        ),
        child: Text(text, style: TextStyle(color: isSelected ? Colors.black : Colors.grey)),
      ),
    );
  }

  // ✅ Order Card with Date/Time
  Widget _buildOrderCard() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: BorderRadius.circular(10), // Rounded corners
          border: Border.all(color: customGreen, width: 2), // Green border
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Soft shadow
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0, // No elevation since we use BoxShadow in Container
          color: Colors.transparent, // Make Card background transparent
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Order Title & Date-Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Cement Bag",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: customGreen),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        const Text("12-03-2025", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(width: 8),
                        const Icon(Icons.access_time, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        const Text("8:00 am", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoRow("Supplier Name", "Pritam Lal"),
                          _infoRow("Company Name", "Lal Logistics"),
                          _infoRow("Distance", "5km away"),
                        ],
                      ),
                    ),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(8),
                    //   child: Image.asset(
                    //     "assets/images/cement.jpeg",
                    //     width: 80,
                    //     height: 80,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  ],
                ),
                const Divider(),
                _infoRow("Buyer Name", "Sheetal Raj"),
                _infoRow("Distance", "3km from Supplier"),
                _infoRow("Pickup", "Lal Supplies"),
                _infoRow("Drop Off", "XYZ Construction"),
                const Divider(),
                _infoRow("Amount", "₹90,000"),
                _infoRow("Detail", "6 loads"),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildButton("Accept", customGreen, Colors.white),
                    _buildButton("Decline", Colors.white, customGreen),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text("$title :", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(width: 6),
          Text(value, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color bgColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 40,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: customGreen),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
  // Widget _buildBottomNavBar() {
  //   return BottomNavigationBar(
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: customGreen,
  //     selectedItemColor: Colors.white,
  //     unselectedItemColor: Colors.white70,
  //     iconSize: 20,
  //     currentIndex: 0,
  //     onTap: (value) {
  //       Get.to(()=>SupplierDetailsScreen());
  //     },
  //     items: const [
  //       BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
  //       BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_sharp), label: "Transporter"),
  //       BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Earnings"),
  //       BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  //     ],
  //   );
  // }
}
