import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_nwesapp/layout/shopapp/shopapp_layout.dart';
import 'package:flutter_nwesapp/modules/shop_app/register/register_screen.dart';
import 'package:flutter_nwesapp/shared/components/default_botton.dart';
import 'package:flutter_nwesapp/shared/components/defulte_text_formfeild.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
class LoginScreen extends StatelessWidget {
  var _formkey =GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>LoginCubit(),
      child: BlocConsumer <LoginCubit , LoginState>(
        listener: (context , state){
          if(state is LoginSuccessState){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context)=>ShopLayout(),
              ),
            );
          }
        },
        builder: (context , state)=> Scaffold(
          body: SingleChildScrollView(
            child: Container(
              color: Colors.grey[99],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Image.asset(
                            'images/chatlogo.jpg',
                            fit: BoxFit.cover,
                            height: 120,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Text(
                          'Log in to your account !',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      DefaultFormField(
                        prefix: Icons.email_outlined,
                        lable: 'Email Address',
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      DefaultFormField(
                        prefix: Icons.lock_outline,
                        lable: 'Password',
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validator: (value){
                          if(value==null || value.isEmpty){
                            print("Please enter some text");
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text(
                          'Forget Password?',
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      if(state is!LoadingLoginState)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child:Center(
                            child: Container(
                              height: 50,
                              width: 200.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: HexColor('0148A3'),
                              ),
                              child: MaterialButton(
                                onPressed: (){
                                  LoginCubit.get(context).UserLogin(
                                      email: emailController.text,
                                      password:passwordController.text
                                  );
                                },
                                child: Text(
                                  'LOG IN',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if(state is LoadingLoginState)
                        Center(child: CircularProgressIndicator()),
                      SizedBox(
                        height: 16.0,
                      ),
                      Center(
                        child: Text(
                          'Or connect using',
                          style: TextStyle(
                              color: Colors.grey
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150.0,
                            decoration: (
                                BoxDecoration(
                                    color: HexColor('FE5656'),
                                    borderRadius: BorderRadius.circular(20.0)
                                )
                            ),
                            child: MaterialButton(
                              onPressed:(){
                                //LoginCubit.get(context).googleSignIn();
                              },
                              child: Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: HexColor('385C8D'),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: MaterialButton(
                              onPressed:(){
                                //SocialLoginCubit.get(context).facebookSignIn();
                              },
                              child: Icon(
                                FontAwesomeIcons.facebookF,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don`t have an account?',
                          ),
                          TextButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context)=>RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

