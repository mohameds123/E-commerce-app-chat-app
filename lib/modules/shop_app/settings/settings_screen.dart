import 'package:flutter/material.dart';
import 'package:flutter_nwesapp/modules/shop_app/login/login_screen.dart';
import 'package:flutter_nwesapp/network/local/cache_helper.dart';
class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MaterialButton(
    onPressed: (){
      // CacheHelper.removeData(key: 'userToken').then((value){
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (BuildContext context)=>LoginScreen(),
      //     ),
      //   );
      // });
    },
    child: Container(
      width: double.infinity,
      decoration:BoxDecoration(
        color: Colors.blue,
      ),
        child: Text(
            'log Out',
          style: TextStyle(
            color: Colors.white,
          ),
        )
    ),
  );
  }
}

