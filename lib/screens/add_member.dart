import 'package:flutter/material.dart';

class MemberSearchPage extends StatelessWidget {
  const MemberSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child:  TextFormField(
                    maxLength: 20,
                    decoration: InputDecoration(
                      hintText: 'Enter text here',
                      helperText: 'Helper text',
                      suffixIcon: Padding(
                       padding: const EdgeInsets.only(right: 5.0),
                        child: Container(
                          height: 5,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Define the functionality you want here
                              print('Icon button pressed!');
                            },
                          )

                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  )


                ),
                const SizedBox(width: 10),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
