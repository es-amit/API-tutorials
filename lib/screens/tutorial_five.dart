import 'dart:convert';

import 'package:api_tutorials/Models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFive extends StatefulWidget {
  const ExampleFive({super.key});

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {

  Future<ProductModel> getProductAPI() async{
    final response= await http.get(Uri.parse('https://webhook.site/269d5628-c3d4-4bbb-b5c6-2c6e1d0f8b1a'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProductModel.fromJson(data);
    }else{
      return ProductModel.fromJson(data);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api tutorial'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductModel>(
            future: getProductAPI(), 
            builder: (context,AsyncSnapshot<ProductModel> snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context,index){
                  return Column(
                    children: [Text(index.toString())],
                  ); 
                });
              }else{
                return const Text('Loading');
              }
              
            }))
        ],
      ),
    );
  }
}