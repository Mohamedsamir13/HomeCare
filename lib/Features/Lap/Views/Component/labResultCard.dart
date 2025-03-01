import 'package:flutter/material.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Features/Admin/Model/labResult.dart';
import 'package:intl/intl.dart';

class LabResultCard extends StatelessWidget {
  final LabResult labResult;
  final VoidCallback onDownload;

  const LabResultCard({
    super.key,
    required this.labResult,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visit Number: ${labResult.visitNumber}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Visit Date: ${DateFormat('dd-MM-yyyy').format(labResult.visitDate)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: onDownload,
                  icon: const Icon(Icons.download),
                  label: const Text('Download'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),

            const Divider(height: 24, thickness: 1),

            // Test Results Section
            _buildTestResult('CEA (Carcinoembryonic Antigen)'),
            const Divider(height: 24, thickness: 1),
            _buildTestResult('AFP (Alpha-Fetoprotein)'),
            const Divider(height: 24, thickness: 1),
            _buildTestResult('CBC (Complete Blood Picture)'),

            const SizedBox(height: 16),

            // Status Chip
            Align(
              alignment: Alignment.centerRight,
              child: Chip(
                backgroundColor: labResult.isCompleted
                    ? Colors.green[100]
                    : Colors.orange[100],
                label: Text(
                  labResult.isCompleted ? 'Completed' : 'In Progress',
                  style: TextStyle(
                    color: labResult.isCompleted
                        ? Colors.green[800]
                        : Colors.orange[800],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestResult(String testName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          testName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Icon(Icons.check_circle, color: Colors.green),
      ],
    );
  }
}