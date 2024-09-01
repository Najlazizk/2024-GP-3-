import 'package:electech/screens/dashboard.dart';
import 'package:electech/screens/members.dart';
import 'package:electech/screens/profile.dart';
import 'package:electech/screens/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/firebase_data_controller.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  final List<Widget> screens = [const Dashboard(),
    const MembersScreen(),
    const ProfileScreen(),

  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Dashboard();

  @override
  void initState() {

    super.initState();
    Get.put(FirebaseDataController());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: PageStorage(bucket: bucket, child: currentScreen),
        bottomNavigationBar: BottomAppBar(
            color: Colors.white70,
            notchMargin: 10,
            shape: const CircularNotchedRectangle(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //color: Colors.red
              ),
             // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = const Dashboard();
                            currentTab = 0;
                          });
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Icon(
      
                                   currentTab == 0
                                      ? Icons.home
                                      : Icons.home_outlined,
      
                                  color:currentTab==0? theme.colorScheme.tertiary:theme.colorScheme.surfaceDim
      
                              ),
                            ),
                       Expanded(
                         child: Text(
                                  'Home',
                                  style: TextStyle(
      
                                      color:currentTab==0? theme.colorScheme.tertiary:theme.colorScheme.surfaceDim),
                                ),
                       ),
      
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = const StatusScreen();
                            currentTab = 1;
                          });
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Icon(      currentTab == 1
                                  ? Icons.bar_chart_sharp
                                  : Icons.bar_chart_outlined,
      
                                  color:currentTab==1? theme.colorScheme.tertiary:theme.colorScheme.surfaceDim),
                            ),
                            Expanded(
                              child: Text(
                                'Status',
                                style: TextStyle(
                                    color:currentTab==1? theme.colorScheme.tertiary:theme.colorScheme.surfaceDim),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
      
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = const MembersScreen();
                            currentTab = 2;
                          });
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Icon(      currentTab == 2
                                  ? Icons.people_alt_rounded
                                  : Icons.people_alt_outlined,
      
                                  color:currentTab==2? theme.colorScheme.tertiary:theme.colorScheme.surfaceDim),
                            ),
                            Expanded(
                              child: Text(
                                'members',
                                style: TextStyle(
                                    color:currentTab==2? theme.colorScheme.tertiary:theme.colorScheme.surfaceDim),
                              ),
                            )
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = const ProfileScreen();
                            currentTab = 3;
                          });
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Icon(
      
                                  currentTab == 3
                                      ? Icons.settings
                                      : Icons.settings_outlined,
      
                                  color:currentTab==3? theme.colorScheme.tertiary:theme.colorScheme.surfaceDim
      
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Profile',
                                style: TextStyle(
      
                                    color:currentTab==3? theme.colorScheme.tertiary:theme.colorScheme.surfaceDim),
                              ),
                            ),
      
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          // shape: CircleBorder(),
          shape: BeveledRectangleBorder(

              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2.0,
                  style: BorderStyle.solid)),
          backgroundColor: Theme.of(context).colorScheme.surfaceDim,
          onPressed: () {
              showAddDeviceDialog(context);
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }



  void showAddDeviceDialog(BuildContext context, ) {
    final theme = Theme.of(context);
    TextEditingController deviceIdTextController=TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('Add New Device'),
        content: TextField(
          controller: deviceIdTextController,
          autofocus: true,
          decoration: InputDecoration(
            label: Text(
              'Enter Device Id',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.secondary),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              FirebaseDataController.instance.addNewDeviceToUser(deviceIdTextController.text.trim());
            },
            style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.secondary),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }



}
