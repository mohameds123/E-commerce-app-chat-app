import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/layout/social/social_layout.dart';
import 'package:flutter_nwesapp/shared/components/components.dart';
import 'package:flutter_nwesapp/shared/components/default_botton.dart';
import 'package:flutter_nwesapp/shared/components/defulte_text_formfeild.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class SocialRegisterScreen extends StatelessWidget {
  var form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialRegisterCubit,SocialRegisterState>(
      listener: (context,state) {
        if (state is SetDataRegisterSuccessState) {
          navigateAndFinish(
            context: context,
            widget: SocialLayOut(),
          );
        }
      },
      builder: (context,state)=> Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          leading:IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Container(
          height: double.infinity,
          color: Colors.grey[100],
          child: Padding(
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
                        controller: SocialRegisterCubit.get(context).emailAddressController,
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
                        controller: SocialRegisterCubit.get(context).passwordController,
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
                        prefix: Icons.person,
                        lable: 'Full Name',
                        controller: SocialRegisterCubit.get(context).nameController,
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
                        prefix: Icons.phone,
                        lable: 'Mobile Number',
                        controller: SocialRegisterCubit.get(context).mobileController,
                        type: TextInputType.phone
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
                        prefix: Icons.location_city,
                        lable: 'Address',
                        controller: SocialRegisterCubit.get(context).addressController,
                        type: TextInputType.emailAddress
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DefaultButton(
                      function: (){
                        if(form_key.currentState!.validate()){
                          SocialRegisterCubit.get(context).socialUserRegister(
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
      ),
    );
  }
}