import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_data/database_user.dart';
import 'package:store_data/model_user.dart';
import 'package:store_data/signup.dart';
import 'package:store_data/update.dart';

class Show extends StatefulWidget {
  Show({Key? key}) : super(key: key);

  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {
  DatabaseUser databaseUser = DatabaseUser();
  Future<List<ModelUser>>? future_list;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadData();
  }

  void LoadData() async {
    databaseUser.initializeDatabase().then((value) {
      setState(() {
        future_list = databaseUser.GetAllRecord();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Records'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30),
          child: FutureBuilder(
            future: future_list,
            builder: (context, AsyncSnapshot<List<ModelUser>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length > 0) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Container(
                            // padding: EdgeInsets.all(15),
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text("${snapshot.data![index].email}\n"
                                  "${snapshot.data![index].email}"),
                              subtitle: Text("${snapshot.data![index].phone}"),
                              trailing: Container(
                                width: 80,
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment:
                                  //     CrossAxisAlignment.stretch,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        databaseUser.DeleteRecord(snapshot
                                                .data![index].id
                                                .toString())
                                            .then((value) {
                                          setState(() {
                                            future_list =
                                                databaseUser.GetAllRecord();
                                          });
                                        });
                                      },
                                      child: const Icon(Icons.delete),
                                    ),
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        bool isUpdate = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (builder) => Update(
                                              modelUser: snapshot.data![index],
                                            ),
                                          ),
                                        );

                                        if (isUpdate) {
                                          setState(() {
                                            future_list =
                                                databaseUser.GetAllRecord();
                                          });
                                        }
                                      },
                                      child: Icon(Icons.update),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                        // return Container(
                        //   child: Text("${snapshot.data![index].email}"),
                        // );
                      });
                } else {
                  return const Center(
                    child: Text("Sorry no record"),
                  );
                }

                // return Center(
                //   child: Text(
                //       "Total Storeed data : ${snapshot.data!.length.toString()}"),
                // );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
