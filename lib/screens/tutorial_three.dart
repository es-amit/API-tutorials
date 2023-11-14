import 'dart:convert';

import 'package:api_tutorials/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {

  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map<String,dynamic> i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API tutorial'),
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(), 
            builder: ((context, AsyncSnapshot<List<UserModel>> snapshot) {
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context,index){
                  if(snapshot.hasData){
                    return  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                      
                        children: [
                          ReusableRow(title: 'Name', value: snapshot.data![index].name.toString()),
                          ReusableRow(title: 'Email', value: snapshot.data![index].email.toString()),
                          ReusableRow(title: 'Address', value: snapshot.data![index].address!.geo!.lat.toString()),
                        ],
                      ),
                    ),
                  );
                  }
                  else{
                    return const Text('loading');
                  }
                });
            })))
        ],
      ),
    );
  }
}
// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title,value;

  ReusableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(title),
            Text(value),
            ],
    );
  }
}