import 'package:flutter/material.dart';
import 'package:store_data/database_user.dart';
import 'package:store_data/model_user.dart';

class Update extends StatefulWidget {
  final ModelUser modelUser;
  const Update({required this.modelUser});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  TextEditingController idcontroller = TextEditingController();

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController phonecontroller = TextEditingController();
  DatabaseUser databaseUser = DatabaseUser();
  @override
  void initState() {
    super.initState();
    idcontroller.text = widget.modelUser.id.toString();
    emailcontroller.text = widget.modelUser.email;
    phonecontroller.text = widget.modelUser.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextFormField(
                controller: idcontroller,
                enabled: false,
              ),
              TextFormField(
                controller: emailcontroller,
              ),
              TextFormField(
                controller: phonecontroller,
              ),
              ElevatedButton(
                onPressed: () {
                  int id = int.parse(idcontroller.text.toString());
                  String email = emailcontroller.text.toString();
                  String phone = phonecontroller.text.toString();
                  ModelUser modelUser =
                      ModelUser(id: id, email: email, phone: phone);
                  // if (isInitialize) {
                  //   databaseUser.AddRecord(modelUser); //no 1
                  // }

                  databaseUser.initializeDatabase().then((value) {
                    databaseUser.UpdateRecord(modelUser);
                    Navigator.pop(context, true);
                  });
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
