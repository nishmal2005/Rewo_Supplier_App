import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewo_supplier/controllers/implementations/transporter_controller.dart';
import 'package:rewo_supplier/screens/transporter/details_tab.dart';
class SupplierDetailsScreen extends StatelessWidget {
 SupplierDetailsScreen({super.key});
final TransporterController userController=Get.put(TransporterController());
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=>DetailsTab());
        },
        backgroundColor: const Color(0xFF4CAF83),
        child: const Icon(Icons.add),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 40, bottom: 50),
            child: TransporterDetailsCard(),
          ),
        ),
      ),
    );
  }
}

class TransporterDetailsCard extends StatelessWidget {
  const TransporterDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) =>  TransporterApp()),
      //   );},
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        color: const Color(0xFF4CAF83),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Transporter Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                buildInfoRow('Name', 'Bens George'),
                buildInfoRow('Location', 'Kochi'),
                buildInfoRow('Contact', '9985334744'),
                buildInfoRow('Address', 'vettapurakkal (H)\nkaduvakavala (P.O)\n656678'),
                const SizedBox(height: 16),
                const Text(
                  'Vehicle Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                buildInfoRow('Vehicle No', 'KL35X3223'),
                buildInfoRow('Manufacturer', 'Tata'),
                buildInfoRow('Model', 'Tata 2518 Truck 2016'),
                buildInfoRow('Load Capacity', '19,000 kg'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
