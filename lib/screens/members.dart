import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  // List to store member emails
  List<String> members = [];

  // Method to add a member
  void _addMember(String email) {
    setState(() {
      members.add(email);
    });
  }

  // Method to handle greater-than icon press
  void _handleMoreOptions(String email) {
    // Show confirmation dialog
    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF0E6891),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Are you sure you want to delete this member?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF828282),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        members.remove(email); // Remove the member from the list
                      });
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFFBCD2F),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MemberInputField(onAddMember: _addMember),
            const SizedBox(height: 20),
            Expanded(
              child: members.isEmpty
                  ? const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Whoops!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 36,
                        color: Color(0xFF6A6767),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Looks like you have no members!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Color(0xFF6A6767),
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8), // Space between items
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFC6C6C6)), // Border color
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Adjusted padding for reduced height
                      title: Text(members[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.chevron_right), // Greater-than sign
                        onPressed: () => _handleMoreOptions(members[index]), // Handle press
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MemberInputField extends StatelessWidget {
  final void Function(String) onAddMember;

  const MemberInputField({super.key, required this.onAddMember});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    return TextFormField(
      style: const TextStyle(color: Color(0xFFC6C6C6)),
      decoration: InputDecoration(
        hintText: 'Enter member name',
        hintStyle: const TextStyle(color: Color(0xFF828282)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFC6C6C6)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF828282)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ElevatedButton(
            onPressed: () {
              Get.dialog(
                Dialog(
                  backgroundColor: const Color(0xFF0E6891),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Enter Member's Email",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18, // Reduced font size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12), // Reduced space between elements
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Enter email',
                                hintStyle: const TextStyle(color: Color(0xFF828282)),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Reduced padding
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFFC6C6C6)),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFF828282)),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16), // Reduced space before button
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  // Add the entered email to the list
                                  String email = emailController.text.trim();
                                  if (email.isNotEmpty) {
                                    onAddMember(email);
                                    Get.back();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color(0xFFFBCD2F),
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24), // Increased horizontal padding
                                  minimumSize: const Size(double.infinity, 40), // Set minimum width and height
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  'Add',
                                  style: TextStyle(fontSize: 14), // Reduced font size
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20, // Reduced size
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(7),
              backgroundColor: const Color(0xFF0E6891),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 18),
          ),
        ),
      ),
    );
  }
}
