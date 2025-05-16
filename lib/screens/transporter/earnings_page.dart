
import 'package:flutter/material.dart';

class EarningsPage extends StatelessWidget {
  static const Color customGreen = Color(0xFF557669);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildEarningsSection(),
            Expanded(child: _buildTransactionList()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey[400],
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle, // Circular background
            ),
            child: IconButton(
              icon:  Icon(Icons.tune, color: Colors.grey[500]),
              onPressed: () {},
            ),
          )

        ],
      ),
    );
  }

  // Earnings Section with Separate Containers
  Widget _buildEarningsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          // Total Earnings
          Container(
            width: double.infinity, // Full width
            padding: const EdgeInsets.all(16),
            height: 120, // Increased height
            decoration: BoxDecoration(
              color: customGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center, // Centers content
              children: [
                const Text(
                  "Total Earnings",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 8),
                const Text(
                  "₹15,000",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _earningsDetail("₹5,000", "This Month", Icons.account_balance_wallet),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _earningsDetail("₹5,000", "Withdrawals", Icons.account_balance),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _earningsDetail(String amount, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green[100],
            radius: 16,
            child: Icon(icon, color: customGreen, size: 18),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    List<Map<String, dynamic>> transactions = [
      {"id": "Order ID #4563564", "date": "24/3/2025", "amount": "+5000", "color": customGreen},
      {"id": "Order ID #4563564", "date": "24/3/2025", "amount": "-5000", "color": Colors.red},
      {"id": "Order ID #4563564", "date": "24/3/2025", "amount": "-5000", "color": Colors.red},
      {"id": "Order ID #4563534", "date": "24/3/2025", "amount": "+2800", "color": customGreen},
      {"id": "Order ID #4563525", "date": "24/3/2025", "amount": "+4500", "color": customGreen},
      {"id": "Order ID #4563245", "date": "24/3/2025", "amount": "+3400", "color": customGreen},
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(12),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                "Transaction Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return _buildTransactionItem(transactions[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> txn) {
    return Card(
      color: Colors.grey[350],
      margin: const EdgeInsets.only(bottom: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[400],
          radius: 18,
          child: const Icon(Icons.receipt, color: Colors.black, size: 16),
        ),
        title: Text(txn['id'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        subtitle: Text(txn['date'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Text(
          txn['amount'],
          style: TextStyle(color: txn['color'], fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: customGreen,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      iconSize: 20,
      currentIndex: 2,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_sharp), label: "Order"),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Earnings"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
