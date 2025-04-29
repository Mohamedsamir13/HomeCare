import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homecare/Const/appColor.dart';
import 'package:homecare/Const/customButton.dart';
import 'package:homecare/Const/images.dart';
import 'package:homecare/Const/size.dart';
import 'package:homecare/Features/Booking/Controller/bookingController.dart';
import 'package:homecare/Features/Booking/View/splaishScreen.dart';
import 'package:intl/intl.dart';
import 'package:homecare/Const/appText.dart';

class AppointmentView extends GetView<AppointmentController> {
  const AppointmentView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AppointmentController());

    double height = displayHeight(context);
    double width = displayWidth(context);

    return Scaffold(
        appBar: AppBar(
            title: const AppText(
                text: 'Book Appointment',
                size: 20,
                fontWeight: FontWeight.bold)),
        body: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              color: Colors.grey[200],
              Images.wallPaper,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCalendar(context),
                SizedBox(height: height * 0.02),
                _buildTimeGrid(context),
                const Spacer(),
                _buildBookButton(context),
              ],
            ),
          ),
        ]));
  }

  Widget _buildCalendar(BuildContext context) {
    return Column(
      children: [
        _buildMonthHeader(context),
        SizedBox(height: displayHeight(context) * 0.03),
        _buildDaysGrid(context),
      ],
    );
  }

  Widget _buildMonthHeader(BuildContext context) {
    return Obx(() {
      final currentDate = controller.selectedDate.value;
      final months = List.generate(
          12, (index) => DateTime(currentDate.year, index + 1, 1));

      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: displayWidth(context) * 0.03),
        child: DropdownButton<DateTime>(
          value: DateTime(currentDate.year, currentDate.month, 1),
          underline: const SizedBox(),
          icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
          isExpanded: true,
          style: TextStyle(
              fontSize: displayWidth(context) * 0.045,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor),
          items: months.map((month) {
            return DropdownMenuItem<DateTime>(
              value: month,
              child: AppText(
                  text: DateFormat('MMMM').format(month),
                  size: displayWidth(context) * 0.04),
            );
          }).toList(),
          onChanged: (newMonth) {
            if (newMonth != null) {
              controller.selectDate(newMonth);
            }
          },
        ),
      );
    });
  }

  Widget _buildDaysGrid(BuildContext context) {
    return Obx(() {
      final firstDayOfMonth = DateTime(controller.selectedDate.value.year,
          controller.selectedDate.value.month, 1);
      final lastDayOfMonth = DateTime(controller.selectedDate.value.year,
          controller.selectedDate.value.month + 1, 0);

      // ضبط بداية الأسبوع من الاثنين
      final startingWeekday = (firstDayOfMonth.weekday + 6) % 7;
      final days = <DateTime?>[];

      for (int i = 0; i < startingWeekday; i++) {
        days.add(null);
      }
      for (int i = 1; i <= lastDayOfMonth.day; i++) {
        days.add(DateTime(firstDayOfMonth.year, firstDayOfMonth.month, i));
      }

      return Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: displayHeight(context) * 0.08),
            padding: EdgeInsets.only(
                top: displayHeight(context) * 0.02,
                bottom: displayHeight(context) * 0.01),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, mainAxisSpacing: 4, crossAxisSpacing: 4),
              itemCount: days.length,
              itemBuilder: (context, index) {
                final date = days[index];
                if (date == null) return const SizedBox();
                final isSelected = date == controller.selectedDate.value;
                return GestureDetector(
                  onTap: () => controller.selectDate(date),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: isSelected
                          ? Border.all(color: AppColors.primaryColor)
                          : null,
                    ),
                    child: Center(
                        child: AppText(
                            text: '${date.day}',
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            size: displayWidth(context) * 0.035)),
                  ),
                );
              },
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: displayHeight(context) * 0.08,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
                    .map((day) => Expanded(
                          child: Center(
                            child: Text(
                              day,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildTimeGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          text: 'Available Times:',
          size: displayWidth(context) * 0.045,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
        SizedBox(height: displayHeight(context) * 0.015),
        Obx(() => GridView.builder(
              // تأكد من وجود Obx هنا
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2.5,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: controller.filteredAvailableTimes.length,
              itemBuilder: (context, index) {
                final time = controller.filteredAvailableTimes[index];
                return _buildTimeButton(time, context);
              },
            )),
      ],
    );
  }

  Widget _buildTimeButton(TimeOfDay time, BuildContext context) {
    return Obx(() => ElevatedButton(
          onPressed: () => controller.selectTime(time),
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.selectedTime.value == time
                ? AppColors.primaryColor
                : AppColors.secondaryColor,
            foregroundColor: controller.selectedTime.value == time
                ? Colors.white
                : Colors.black,
          ),
          child: AppText(
              text: '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
              size: displayWidth(context) * 0.035),
        ));
  }

  Widget _buildBookButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: displayWidth(context) * 0.02),
      child: CustomButton(
        onPressed: () async {
          // Check if doctorName is provided and make the appointment accordingly
          if (controller.selectedDoctor.value != null) {
            // Pass the doctor's name to the DoctorAppointmentsController and make the appointment

            await controller.bookDoctorAppointment();
          } else {
            // Proceed with normal appointment logic
           await controller.bookAppointment();
          }
        },
        text: 'Confirm',
      ),
    );
  }
}
