
import 'package:electech/Controllers/firebase_data_controller.dart';
import 'package:electech/Models/device.dart';
import 'package:electech/screens/temperature_setter_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../Controllers/water_heater_controller.dart';
import '../utiles/Widgets/set_timer_duration_button.dart';
import '../utiles/Constant/strings.dart';

class WaterHeaterSettingScreen extends StatelessWidget {
  const WaterHeaterSettingScreen(
      {required this.device, required this.controller, super.key});

  final Device device;
  final WaterHeaterController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme
        .of(context)
        .colorScheme;
    final size = MediaQuery
        .of(context)
        .size;
    //  double screenWidth = size.width;
    double screenHeight = size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          WaterHeaterPageName,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(() =>
                CircularPercentIndicator(
                  radius: 120,
                  lineWidth: 18,
                  percent: controller.percentage.value,
                  center: Text(
                    controller.formatTime(controller.currentTime.value),
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  progressColor: theme.primary,
                  backgroundColor: Colors.blue.shade200,
                )),
          ),
          Obx(() =>
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SizedBox(
                  width:double.infinity,
                  height: MediaQuery.sizeOf(context).height*0.07,
                  child: ElevatedButton(
                    onPressed: controller.toggleTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isTimerRunning.value
                          ? Colors.red
                          : Colors.green,
                    ),
                    child: Text(controller.isTimerRunning.value
                        ? 'Stop Timer'
                        : 'Start Timer',style:  TextStyle(color: Theme.of(context).colorScheme.tertiary,fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                ),
              ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: screenHeight * 0.39,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black87,
                          offset: Offset(2, 2),
                          blurRadius: 4)
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        decoration:  BoxDecoration(color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              shadule,
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(
                              width: 70,
                            ),
                            const Text(
                              time,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => TemperatureSetterScreen(device: device));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .surface,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.thermostat,
                                    color: Theme
                                        .of(context)
                                        .primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    temp,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),

                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Obx(() =>
                                      Text(
                                        'Limit :${controller.setTemperature
                                            .value.round()}°C',
                                        style: const TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )),

                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Icon(
                                    Icons.circle,
                                    color: Colors.yellow,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Obx(() {
                                    var d = FirebaseDataController
                                        .instance.user.value.devices[
                                    FirebaseDataController
                                        .instance.user.value.devices
                                        .indexWhere((d) =>
                                    d.deviceID == device.deviceID)];
                                    return Text(
                                      '${d.temperature_C}°C',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30.0, left: 20),
                      child: Row(
                        children: [
                          Text(
                            setTime,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Obx(
                            () =>
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SetTimerDurationButton(
                                  controller: controller,
                                  optionNumber: 0,
                                  color: controller.selectedTimerOption.value ==
                                      0
                                      ? theme.surfaceDim
                                      : theme.surface,
                                  name: '1 Min',
                                  duration: 60,
                                  // 1 minute in seconds
                                  buttonCallBack: controller.selectDuration,
                                ),
                                SetTimerDurationButton(
                                  controller: controller,
                                  color: controller.selectedTimerOption.value ==
                                      1
                                      ? theme.surfaceDim
                                      : theme.surface,
                                  name: '2 Min',
                                  duration: 120,
                                  // 2 minutes in seconds
                                  optionNumber: 1,
                                  buttonCallBack: controller.selectDuration,
                                ),
                                SetTimerDurationButton(
                                  controller: controller,
                                  optionNumber: 2,
                                  color: controller.selectedTimerOption.value ==
                                      2
                                      ? theme.surfaceDim
                                      : theme.surface,
                                  name: '3 Min',
                                  duration: 180,
                                  // 3 minutes in seconds
                                  buttonCallBack: controller.selectDuration,
                                ),
                              ],
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
