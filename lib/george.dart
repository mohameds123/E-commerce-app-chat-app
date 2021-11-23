

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';
import 'package:flutter_nwesapp/shared/components/defulte_text_formfeild.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: const Offset(0, 7), // changes position of shadow
                  ),
                ],
              ),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    // TextFormField(
                    //   controller: emailController,
                    //   validator: (val) {
                    //     if(val!.isEmpty || val.length < 4) {
                    //       return 'Please enter valid account';
                    //     }
                    //     return null;
                    //   },
                    //   decoration: const InputDecoration(
                    //       labelText: 'e-mail'
                    //   ),
                    // ),
                    DefaultFormField(
                      prefix: Icons.person,
                    lable: 'E-mail',
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validator: (val) {
                      if (val!.isEmpty || val.length < 6) {
                        return 'Please enter at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  DefaultFormField(prefix: Icons.lock,
                    lable: 'Password',
                    controller: emailController,
                    type: TextInputType.visiblePassword,
                    validator: (val) {
                      if (val!.isEmpty || val.length < 6) {
                        return 'Please enter at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  // TextFormField(
                  //   controller: passwordController,
                  //   validator: (val) {
                  //     if (val!.isEmpty || val.length < 6) {
                  //       return 'Please enter at least 6 characters';
                  //     }
                  //     return null;
                  //   },
                  //   decoration: const InputDecoration(
                  //       labelText: 'password'
                  //   ),
                  //   obscureText: true,
                  // ),
                  const SizedBox(height: 20,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const Text('already have an account? '),

            ],
          ),
          const SizedBox(height: 20,),
          // MaterialButton(
          //   textColor: Colors.blue,
          //   child: const Text(
          //     'Sign Up', style: TextStyle(fontSize: 20),),
          //   onPressed: () {
          //     if (_formKey.currentState!.validate()) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(content: Text('Wait...'),));
          //       FirebaseAuth.instance.createUserWithEmailAndPassword(
          //         email: emailController.text,
          //         password: passwordController.text,
          //       ).then((value) {
          //         setData(
          //           uId: value.user!.uid,
          //         );
          //       }).catchError((error) {
          //         print(error);
          //       });
          //       Navigator.pushReplacement(context, MaterialPageRoute(
          //           builder: (context) => SignIn()));
          //     } else {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(
          //             content: Text('something wrong'),));
          //     }
          //   },
          // ),
          ],
        ),
      ),
    ),
    ),
    ),
    ),
    );
  }

  void setData({required String uId}) {
    UserModel userModel = UserModel(
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .set(userModel.toMap())
        .then((value) {});
  }

}

class UserModel {
  String? uId;

  UserModel({
    this.uId,
  });

  UserModel.fromMap(Map<String, dynamic>jason){
    uId = jason['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
    };
  }
}