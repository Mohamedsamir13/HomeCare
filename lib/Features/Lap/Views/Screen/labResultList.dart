import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Features/Admin/Model/labResult.dart';
import 'package:homecare/Features/Lap/Controller/lapController.dart';
import 'package:intl/intl.dart';

class LabResultPage extends StatelessWidget {
  final LabResultController controller = Get.put(LabResultController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab Results')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.latestLabResult.isNull) {
            return const Center(child: Text('No lab results available'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(controller.latestLabResult.value),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildLabTestItem("CFA (Carcinoembryonic Antigen)", true),
                    _buildLabTestItem("AFP (Alpha-Fetoprotein)", true),
                    _buildLabTestItem("CBC (Complete Blood Picture)", true),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildInfoCard(LabResult? labResult) {
    if (labResult == null) {
      return const Center(child: Text("No Lab Results Available"));
    }

    return Card(
      color: AppColors.secondaryColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow(Icons.receipt, "Visit Number",
                labResult.visitNumber.toString()),
            _infoRow(Icons.date_range, "Visit Date",
                DateFormat('dd-MM-yyyy').format(labResult.visitDate)),
            Row(
              children: [

                Text(
                  "Completed",
                  style: TextStyle(
                      color:Colors.green, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildButton("Pay",AppColors.primaryColor, () {}),
                const SizedBox(width: 10),
                _buildButton("Download Results", AppColors.primaryColor, () {
                  // تنفيذ عملية التنزيل هنا
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabTestItem(String testName, bool isCompleted) {
    return Card(
      color: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.science, color: AppColors.primaryColor),
        title: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: testName.split('(')[0],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    testName.contains('(') ? " (${testName.split('(')[1]}" : '',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        trailing: Text(
          isCompleted ? "Completed" : "Pending",
          style: TextStyle(color: isCompleted ? Colors.green : Colors.orange),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor),
          const SizedBox(width: 8),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
