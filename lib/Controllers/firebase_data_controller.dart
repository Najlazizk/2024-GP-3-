import 'package:electech/utiles/Widgets/alert_messages_dailog.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../Models/device.dart';
import '../Models/user.dart';

class FirebaseDataController extends GetxController {
  final currentUserId = auth.FirebaseAuth.instance.currentUser!.uid;
  final currentUser = auth.FirebaseAuth.instance.currentUser;
  static final FirebaseDataController instance = Get.find();
  Rx<User> user = User.dummy().obs;
  final fb = FirebaseDatabase.instance.ref();

  Rx<int> bottomNavigationCurrentIndex = 0.obs;

  set setIndex(int index) {
    bottomNavigationCurrentIndex.value = index;
  }

  @override
  void onInit() {
    fetchUserData(currentUserId).then((value) {
      user.value = value;

      user.value.fetchDevicesData().then((v) {
        addListonerToUser(currentUserId).then((value) {});
      });
    });

    super.onInit();
  }

  Future<void> addListonerToUser(var userId) async {
    fb.child('users/$currentUserId').onValue.listen((event) async {
      if (event.snapshot.exists) {
        //  print('lister is called for change in user detected');
        var u = User.fromJson(event.snapshot.value as Map, userId);

        await u.fetchDevicesData().then((value) {});
        user.value = u;
        await addListonerToAllDevices();

        // await addListonerToAllDevices();
      } else {
        print('somehow event is empty ');
      }
    });
  }

  Future<void> addListonerToAllDevices() async {
    // Iterate over the devicesIds list to fetch and listen for each device
    for (String deviceId in user.value.devicesIds) {
      fb.child('devices/$deviceId').onValue.listen((event) async {
        // Fetch the device data from Firebase
      //  print('listerern is called at device :$deviceId');
        Device? fetchedDevice =
            await FirebaseDataController.instance.fetchDeviceData(deviceId);

        if (fetchedDevice != null) {
          // Update the local devices list with the fetched device data
          // Find and replace the device in the local devices list
          int index = user.value.devices
              .indexWhere((device) => device.deviceID == deviceId);
          if (index != -1) {
            user.update((val) {
              val!.devices[index] = fetchedDevice;
            });

            //user.value.devices[index] = fetchedDevice;
          } else {
            // If the device doesn't exist, add it to the list (optional)
            user.value.devices.add(fetchedDevice);
          }
        } else {
          //if device is delete then delete from modal

          // Find and and delete  in the local devices list
          int index = user.value.devices
              .indexWhere((device) => device.deviceID == deviceId);
          if (index != -1) {
            user.update((val) {
              val!.devices.removeAt(index);
            });

            //user.value.devices[index] = fetchedDevice;
          } else {
            // // If the device doesn't exist, add it to the list (optional)
            // user.value.devices.add(fetchedDevice);
          }
        }
      });
    }
  }

  // Inside your FirebaseDataController class

  Future<User> fetchUserData(String userId) async {
    try {
      final snapshot = await fb.child('users/$userId').get();
      final userData = snapshot.value;
      if (userData != null && userData is Map) {
        var u = User.fromJson(userData, userId);

        return u;
      }
    } catch (e) {
      // Handle error gracefully
    }
    return User.dummy();
  }

  Future<Device?> fetchDeviceData(String deviceId) async {
    try {
      final snapshot = await fb.child('/devices/$deviceId').get();
      final deviceData = snapshot.value;

      if (deviceData != null && deviceData is Map) {
        return Device.fromJson(deviceData, deviceId);
      } else {
        print('device not exist on /devices/$deviceId');
      }
    } catch (e) {
      print(e);
      // Handle error gracefully
    }
    return null;
  }

/////////////////////////////////////////////////////////////////////////

  Future<void> removeDeviceFromUser(String deviceId) async {
    try {
      // Update local user object
      // user.update((val) {
      //   val!.devices.removeWhere((element) => element.deviceID == deviceId);
      // });
      await fb.child('users/$currentUserId/devices/$deviceId').remove();
    } catch (e) {
      // Handle error gracefully
    }
  }

  Future<void> setDevice(String deviceId) async {
    try {
      // Find the device in the user.value.devices list
      Device? device = user.value.devices.firstWhere(
        (device) => device.deviceID == deviceId,
      );

      // Call toJson on the found device and update the Firebase database
      //print('set device state $deviceId current swtich state is ${device.switch2state}');
      // print('updateding firebase data');
      // print(device.switch2state);
      await fb.child('devices/$deviceId').update(device.toJson());
     // print('updated firebase data has been completeed');
      // print(device.switch2state);
    } catch (e) {
      // Handle error gracefully
      print('Failed to update device data: $e');
    }
  }

  Future<void> addNewDeviceToUser(String newDeviceId) async {
    try {
      final userDevicesRef =
          FirebaseDatabase.instance.ref().child('users/$currentUserId/devices');

      final deviceExists = await userDevicesRef
          .orderByValue()
          .equalTo(newDeviceId)
          .once()
          .then((DatabaseEvent event) => event.snapshot.exists);

      if (deviceExists) {
        print('device already added ');
        AlertMessagesDialog.errorMessageDialog('device already added ');
        return;
      } else {
        final deviceSnapshot = await fb.child('devices/$newDeviceId').get();

        if (deviceSnapshot.exists) {
          await fb
              .child('/users/$currentUserId/devices')
              .push()
              .set(newDeviceId);
        } else {
          // // await fb.child('devices').push().set(newDeviceId);
          //  await fb
          //      .child('/users/$currentUserId/devices')
          //      .push()
          //      .set(newDeviceId);
          AlertMessagesDialog.errorMessageDialog(
              'device is not exist in database');
        }
      }
    } catch (e) {
      return;
    }
  }

  void resetValues() {
    user = User.dummy().obs;
    user.value.clearDevicesData();
  }
}
