
import '../Controllers/firebase_data_controller.dart';
import 'device.dart'; // Import Firebase package

class User {
  final String userId;
  final String name;
  final String email;
   List<String> devicesIds;
  List<Device> devices = [];

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.devicesIds,
  });

  factory User.fromJson(Map<dynamic, dynamic> json,var userId) {
    List<String> d = [];
    if (json['devices'] != null) {
      for (Object? key in json['devices'].keys) {
        d.add(json['devices'][key]);
      }
    }

    final user = User(
      userId: userId,
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      devicesIds: d,
    );

    //user.fetchDevicesData(); // Call fetchDevicesData method
    return user;
  }
  factory User.dummy() {
    return User(
      userId: "",
      name: "",
      email: "",
      devicesIds: [],
    );
  }
  void clearDevicesData() {
    devices = [];
  }
  fetchDevicesData() async {
    List<String> updatedDevicesIds = []; // Temporary list to hold updated device IDs
    for (String deviceId in devicesIds) {
      final deviceData = await FirebaseDataController.instance.fetchDeviceData(deviceId);
      if (deviceData != null) {
       // print('device fount at $deviceId');
        devices.add(deviceData);
        updatedDevicesIds.add(deviceId); // Add the device ID to the updated list
      }else{
        print('device data is not fetched at deviceid $deviceId');
      }
    }
   devicesIds= updatedDevicesIds;
    // Return a new User object with the updated devicesIds list
    // return User(
    //   userId: userId,
    //   name: name,
    //   email: email,
    //   devices: devices,
    //   devicesIds: updatedDevicesIds, // Use the updated list
    // );
  }
}
