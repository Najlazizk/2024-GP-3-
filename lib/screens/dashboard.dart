import 'package:electech/features/authentication/controllers/auth_controller.dart';
import 'package:electech/Controllers/firebase_data_controller.dart';
import 'package:electech/utiles/Widgets/home_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../utiles/Constant/strings.dart';
import '../utiles/Widgets/water_heater_widget.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homePageAppBareTitle),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () {
                  AuthController.instance.logOut();
                },
                child: const Icon(
                  Icons.logout,
                  size: 30,
                ))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const header(),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 50.0),
                    child: Text(
                      DeviceText,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Obx(
                    ()=> Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0 ,vertical: 20),
                    child: FirebaseDataController
                            .instance.user.value.devices.isNotEmpty
                        ? GridView.builder(
                            padding: const EdgeInsets.all(10.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // Number of columns
                                    crossAxisSpacing:
                                        20, // Horizontal space between items
                                    mainAxisSpacing:
                                        20, // Vertical space between items
                                    childAspectRatio: 1.1),
                            itemCount: FirebaseDataController
                                .instance.user.value.devices.length,
                            itemBuilder: (context, index) {
                              int row = index ~/ 2;
                              int column = index % 2;

                              // Determine the color based on the binary pattern
                              Color color = (row % 2 == 0)
                                  ? (column == 0
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.surface)
                                  : (column == 0
                                      ? Theme.of(context).colorScheme.surface
                                      : Theme.of(context).colorScheme.primary);

                              Color textColor = (row % 2 == 0)
                                  ? (column == 0
                                      ? Theme.of(context).colorScheme.surface
                                      : Theme.of(context).colorScheme.tertiary)
                                  : (column == 0
                                      ? Theme.of(context).colorScheme.tertiary
                                      : Theme.of(context).colorScheme.surface);

                              return WaterHeater(
                                device:FirebaseDataController
                                    .instance.user.value.devices[index],
                                color: color,
                                textColor: textColor,

                              );
                            })
                        : const Center(
                            child: Text(
                              'No devices configured yet ',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
