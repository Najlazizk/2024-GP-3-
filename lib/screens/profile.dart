import 'package:electech/Controllers/firebase_data_controller.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(FirebaseDataController.instance.user.value.name),
            Text(FirebaseDataController.instance.user.value.email),
            Text(FirebaseDataController.instance.user.value.userId),
          ],
        ),
      ),
    );
  }
}
