import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email,String password)async{
    try{
      Response response  = await post(
        Uri.parse('https://reqres.in/api/register'),
        body: {
          'email': email,
          'password': password
        }
      );

      if(response.statusCode ==200){
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('account created successfully!!');

      }
      else{
        print('failed!!');
      }
    }
    catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: "password",
              ),
              
            ),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(),passwordController.text.toString());

              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: const Center(
                  child: Text('Sign up'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}