import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/water_heater_controller.dart';
import '../../Models/device.dart';
import '../../screens/water_heater_setting_screen.dart';


class WaterHeater extends StatelessWidget {
 const   WaterHeater({required this.device, required this.color, required   this.textColor, super.key});
  final Color textColor;
  final Color color;
  final Device device;


 // bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    final  controller= Get.put(WaterHeaterController( controllerId:device.deviceID),tag: device.deviceID,);
    //double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    return  GestureDetector(
      onTap: ()=>Get.to(WaterHeaterSettingScreen(controller: controller,device: device)),
      child:Container(
      // width: screenWidth * 0.06,
      // height: screenHeight * 0.01,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(color: Colors.black87, offset: Offset(2, 3), blurRadius: 4)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         Text(
              device.name,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),


             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.online_prediction_outlined)),

                 Obx(
                   ()=> CupertinoSwitch(
                      value:   controller.isTimerRunning.value,
                      onChanged: (bool value) {
                        controller.toggleTimer();

                       // device.toggle();
                        //print(' switch state: before tongle ${device.switch1state } : ${device.switch2state}');

                       // print(' switch state: after tongle ${device.switch1state } : ${device.switch2state}');

                        //controller.toggleTimer();

                          //FirebaseDataController.instance.setDevice(device.deviceID);
                      },
                      activeColor: Colors.yellow,
                      trackColor: Theme.of(context).colorScheme.surfaceDim,
                    ),
                 ),

              ],
            ),

        ],
      ),
    ),);
  }
}
