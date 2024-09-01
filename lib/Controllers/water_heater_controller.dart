import 'package:electech/Controllers/firebase_data_controller.dart';
import 'package:get/get.dart';
import 'dart:async';
class WaterHeaterController extends GetxController {
  WaterHeaterController({
    required this.controllerId,
  });
  int deviceIndex=0;
  final String controllerId;
  // Reactive variable to hold the temperature value value will update accroding firebase in ready function;
  var setTemperature =0.0.obs;
  // static final WaterHeaterController whc=Get.find();
  var selectedDuration = 0.obs; // Selected duration in seconds value will update according to firebase in ready funciton,
  var currentTime = 0.obs; // Current time in seconds
  var percentage = 0.0.obs; // Percentage for circular indicator
  var isTimerRunning = false.obs; // To track if the timer is running
  var selectedTimerOption = 0.obs;
  var totalTime = 600; // 10 minutes fix time for timer
  Timer? timer;

  void selectDuration(int duration, optionNumber) {
    selectedDuration.value = duration;
    // currentTime.value = duration;
    percentage.value = selectedDuration / totalTime;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isTimerRunning.value) {
        percentage.value = 0.0;
      }
      timer.cancel();
    });
    //percentage.value=0.0;
    selectedTimerOption.value = optionNumber;

    FirebaseDataController.instance.user.value.devices[deviceIndex].notification_time_in_sec=duration;
    FirebaseDataController.instance.setDevice(controllerId);

  }

  void toggleTimer() {
    if (isTimerRunning.value) {
      //Todo 2 also add values in history

      stopTimer();
    } else {
      // Todo 3 also add values in history
      startTimer();
    }
  }

  void startTimer() {
    if (setTemperature.value >=
        FirebaseDataController
            .instance.user.value.devices[deviceIndex].temperature_C) {

      isTimerRunning.value = true;
        FirebaseDataController.instance.user.value.devices[deviceIndex].toggle();
      FirebaseDataController.instance.setDevice(FirebaseDataController.instance.user.value.devices[deviceIndex].deviceID);
      //  currentTime.value = 0; // Reset to the selected duration
      waterHeaterLogic();
    }else
      {
        // Todo 7 show temperuret is on over limit so device dident on.
      }
  }

  void waterHeaterLogic() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      if (setTemperature.value >=
          FirebaseDataController
              .instance.user.value.devices[deviceIndex].temperature_C) {
        if (currentTime.value < totalTime) {
          if (currentTime.value == selectedDuration.value) {
            //firebase notificaiton
            //Todo firebase notificaiton
          }

          currentTime.value++;
          percentage.value = currentTime.value / totalTime;
        } else {
          // Todo 5 timer is completed show message
          stopTimer();
        }
      } else {
        //Todo 4 send notificaiton adn also show message in app temperature is over

        stopTimer();
      }
    });
  }
  // Method to update the temperature value
  void updateTemperature(double value) {
    setTemperature.value = value;
    FirebaseDataController.instance.user.value.devices[deviceIndex].setTemperatureLimit(value);
    FirebaseDataController.instance.setDevice(FirebaseDataController.instance.user.value.devices[deviceIndex].deviceID);
  }

  void stopTimer() {
    timer?.cancel();
    currentTime.value = 0;
    percentage.value = 0.0;
    isTimerRunning.value = false;
    //update on firebase also switch button off
    FirebaseDataController.instance.user.value.devices[deviceIndex].toggle();
    FirebaseDataController.instance.setDevice(FirebaseDataController.instance.user.value.devices[deviceIndex].deviceID);
    // print('${currentTime.value}');

    // currentTime.value=0;
  }

  String formatTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secs';
  }

  @override
  void onReady() {
    super.onReady();
    deviceIndex =
        FirebaseDataController.instance.user.value.devices.indexWhere((device) {
          return device.deviceID == controllerId;
        });

    setTemperature.value=FirebaseDataController.instance.user.value.devices[deviceIndex].temperature_limit.toDouble();
    int notiTime=FirebaseDataController.instance.user.value.devices[deviceIndex].notification_time_in_sec;
    selectedDuration.value=notiTime;
  int  optionGuss= notiTime~/60;
  if(optionGuss==1){
    selectedTimerOption.value=0;
  }else if(optionGuss==2){
    selectedTimerOption.value=1;
  }else if(optionGuss==3){
    selectedTimerOption.value=2;

  }else{
    selectedTimerOption.value=0;
  }
  }


  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
