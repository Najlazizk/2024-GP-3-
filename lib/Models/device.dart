// ignore_for_file: non_constant_identifier_names

class Device {
  final String name;
  final int factor2;
  final int factor1;
  final int power1;
  final int power2;
  String relay1;
  String relay2;
  final String status;
   String switch1state;
   String switch2state;
  final int today;
  final int total;
  final  totalStartTime;
  final int voltage;
  final int yesterday;
  final String deviceID;
  final double  temperature_C ;
   double  temperature_limit;
   int notification_time_in_sec;

  Device({
    required this.notification_time_in_sec,
    required this.temperature_C,
    required this.name,
    required this.deviceID,
    required this.factor1,
    required this.factor2,
    required this.power1,
    required this.power2,
    required this.relay1,
    required this.relay2,
    required this.status,
    required this.switch1state,
    required this.switch2state,
    required this.today,
    required this.total,
    required this.totalStartTime,
    required this.voltage,
    required this.yesterday,
    required this.temperature_limit,
  });

  factory Device.fromJson(json, String device_id) {
    return Device(
      notification_time_in_sec: json['notification_time_in_sec']?? 0 ,
      temperature_limit: (json['temperature_limit'] !=null ?json['temperature_limit'] is double? json['temperature_limit'] :json['temperature_limit'] .toDouble()    : 0.0 )   ,
      temperature_C: json['temperature_C'] !=null?  json['temperature_C'] is double ? json['temperature_C']:json['temperature_C'].toDouble()   :  0.0 ,
      name: json['name'] ?? "",
      factor1: json['factor1'] ?? 0,
      factor2: json['factor2'] ?? 0,
      power1: json['power1'] ?? 0,
      power2: json['power2'] ?? 0,
      relay1: json['relay1'] ?? "",
      relay2: json['relay2'] ?? "",
      status: json['status'] ?? "",
      switch1state: json['switch1state'] ?? "",
      switch2state: json['switch2state'] ?? "",
      today: json['today'] ?? 0,
      total: json['total'] ?? 0,
      totalStartTime: json['totalStartTime'] ?? "",
      voltage: json['voltage'] ?? 0,
      yesterday: json['yesterday'] ?? 0,
      deviceID: device_id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      name:name,
      // 'factor1': factor1,
      // 'factor2': factor2,
      // 'power1': power1,
      // 'power2': power2,
     // 'relay1': relay1,
     // 'relay2': relay2,
      // 'status': status,
       'switch1state': switch1state,
       'switch2state': switch2state,
      'temperature_limit': temperature_limit,
      'notification_time_in_sec':notification_time_in_sec
      // 'today': today,
      // 'total': total,
      // 'totalStartTime': totalStartTime.toIso8601String(),
      // 'voltage': voltage,
      // 'yesterday': yesterday,
      // 'deviceID': deviceID,
    };
  }

   toggle(){
    if(switch1state=='OFF'){
      switch1state='ON';
    }else{
      switch1state='OFF';
    }
    if(switch2state=='OFF'){
      switch2state='ON';
    }else{
      switch2state='OFF';
    }
    // switch1state=switch1state=='OFF'?'ON':'OFF';
    // switch1state=switch1state=='OFF'?'ON':'OFF';

   }



  bool isDeviceOn(){
      return switch1state=='ON' &&switch2state=='ON';
   }

    void setTemperatureLimit(double  tem){
    temperature_limit=tem;
    }

     void setNotificationTime( int seconds){
       notification_time_in_sec=seconds;
     }
  @override
  String toString() {
    return 'Device{name: $name, factor2: $factor2, factor1: $factor1, power1: $power1, power2: $power2, relay1: $relay1, relay2: $relay2, status: $status, switch1State: $switch1state, switch2State: $switch2state, today: $today, total: $total, totalStartTime: $totalStartTime, voltage: $voltage, yesterday: $yesterday, deviceID: $deviceID}';
  }
}
