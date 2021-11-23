import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
class SocialLayOut extends StatefulWidget {
  @override
  _SocialLayOutState createState() => _SocialLayOutState();
}

class _SocialLayOutState extends State<SocialLayOut> with WidgetsBindingObserver {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus('online');
  }
  void setStatus(String status)async{
    _firebase.collection('users').doc(user!.uid).update({
      'status':status,
    });
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    if(state==AppLifecycleState.resumed){
      //online
      setStatus('online');
    }else
      //offline
    setStatus('offline');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state)=>Scaffold(
        body:SocialCubit.get(context).widget[SocialCubit.get(context).currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          onTap: (int index){
            SocialCubit.get(context).changeNavigation(index);
          },
          currentIndex: SocialCubit.get(context).currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Users',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}


