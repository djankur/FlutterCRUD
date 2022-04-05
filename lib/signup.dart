import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_data/database_user.dart';
import 'package:store_data/model_user.dart';
import 'package:store_data/show.dart';
import 'package:store_data/update.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController phonecontroller = TextEditingController();
  DatabaseUser databaseUser = DatabaseUser();
  //bool isInitialize = false; //no1
  @override
  void initState() {
    super.initState();
    // databaseUser.initializeDatabase().then((value) {  //no1
    //   isInitialize = true;
    // });
    // emailcontroller.text = '';
    // phonecontroller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: emailcontroller,
            ),
            TextFormField(
              controller: phonecontroller,
            ),
            ElevatedButton(
              onPressed: () {
                String email = emailcontroller.text.toString();
                String phone = phonecontroller.text.toString();
                ModelUser modelUser =
                    ModelUser(id: 0, email: email, phone: phone);
                // if (isInitialize) {
                //   databaseUser.AddRecord(modelUser); //no 1
                // }

                databaseUser.initializeDatabase().then((value) {
                  databaseUser.AddRecord(modelUser);
                });
              },
              child: const Text('Add'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (builder) =>  Update(modelUser: ,),
            //       ),
            //     );
            //   },
            //   child: const Text('Update'),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => Show(),
                  ),
                );
              },
              child: const Text('Show'),
            ),
          ],
        ),
      ),
    );
  }
}
