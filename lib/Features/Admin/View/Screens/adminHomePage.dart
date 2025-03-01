import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homecare/Features/Admin/Controller/adminController.dart';
import 'package:homecare/Features/Admin/View/Screens/addDoctorPage.dart';
import 'package:homecare/Features/Admin/View/Screens/addLapResut.dart';

class AdminHomePage extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Buttons Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 10, // Spacing between buttons
                  runSpacing: 10, // Spacing when wrapping
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.to(() => AddDoctorPage()),
                      child: Text('Add Doctor'),
                    ),
                    ElevatedButton(
                      onPressed: () => Get.to(() => AddLabResultPage()),
                      child: Text('Add Lab Result'),
                    ),
                  ],
                ),
              ),

              // Bookings Table Section
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: controller.fetchBookings(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError || snapshot.data == null) {
                      return Center(child: Text('Failed to load bookings'));
                    }
                    final bookings = snapshot.data!;
                    if (bookings.isEmpty) {
                      return Center(child: Text('No bookings found'));
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // Horizontal scroll for wide tables
                      child: SingleChildScrollView(
                        child: DataTable(
                          border: TableBorder.all(),
                          columns: [
                            DataColumn(label: Text('User ID')),
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Time')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: bookings.map((booking) {
                            return DataRow(cells: [
                              DataCell(Text(booking['userId'])),
                              DataCell(Text(booking['date'])),
                              DataCell(Text(booking['time'])),
                              DataCell(Text(booking['status'])),
                            ]);
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
