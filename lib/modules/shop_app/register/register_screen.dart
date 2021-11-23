import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/modules/shop_app/login/login_screen.dart';
import 'package:flutter_nwesapp/modules/shop_app/register/cubit/cubit.dart';
import 'package:flutter_nwesapp/modules/shop_app/register/cubit/states.dart';
import 'package:flutter_nwesapp/shared/components/default_botton.dart';
import 'package:flutter_nwesapp/shared/components/defulte_text_formfeild.dart';
class RegisterScreen extends StatelessWidget {
  var form_key = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterStates>(
    listener: (context,state){
      if(state is RegisterSuccess){
        showDialog(
            context: context,
            builder:(context){
              return AlertDialog(
                content: Text('your register successed'),
                actions: [
                  FlatButton(
                    child: Text('ok'),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (BuildContext context)=>LoginScreen(),
                        ),
                        );
                      },
                  ),
                ],
              );
            }
        );
      }
      if(state is RegisterUnsuccess){
        showDialog(
            context: context,
            builder:(context){
              return AlertDialog(
                content: Text('Something is wrong'),
                actions: [
                  FlatButton(
                    child: Text('ok'),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }
        );
      }
    },
      builder: (context,state)=> Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading:IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: form_key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Let`s Get Started',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        'Register now to browse our hot offers',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    DefaultFormField(
                        validator:(value){
                          if(value!.isEmpty) {
                            return 'please enter any text';
                          }
                          return null;
                        },
                        prefix: Icons.account_circle_outlined,
                        lable: 'User Name',
                        controller: userNameController,
                        type: TextInputType.name
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DefaultFormField(
                        validator:(value){
                          if(value!.isEmpty) {
                            return 'please enter any text';
                          }
                          return null;
                        },
                        prefix: Icons.email,
                        lable: 'Email Address',
                        controller: emailAddressController,
                        type: TextInputType.emailAddress
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DefaultFormField(
                        validator:(value){
                          if(value!.isEmpty) {
                            return 'please enter any text';
                          }
                          return null;
                        },
                        prefix: Icons.lock_outline,
                        lable: 'Password',
                        controller: passwordController,
                        type: TextInputType.visiblePassword
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DefaultFormField(
                        validator:(value){
                          if(value!.isEmpty) {
                            return 'please enter any text';
                          }
                          return null;
                        },
                        prefix: Icons.phone,
                        lable: 'Phone',
                        controller: phoneController,
                        type: TextInputType.phone
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DefaultButton(
                      function: (){
                        if(form_key.currentState!.validate()){
                          RegisterCubit.get(context).userRegister(
                            emailAddress: emailAddressController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                            userName: userNameController.text,
                          );
                        }
                      },
                      text: 'REGISTER',
                      height: 50.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
}
}
