import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/layout/shopapp/shopapp_layout.dart';
import 'package:flutter_nwesapp/modules/shop_app/register/cubit/cubit.dart';
import 'package:flutter_nwesapp/network/local/cache_helper.dart';
import 'package:flutter_nwesapp/network/remote/dio_helper.dart';
import 'package:flutter_nwesapp/network/remote/dio_helper_news.dart';
import 'package:flutter_nwesapp/observe.dart';
import 'package:flutter_nwesapp/shared/components/components.dart';
import 'george.dart';
import 'layout/shopapp/cubit/cubit.dart';
import 'layout/social/cubit/cubit.dart';
import 'modules/social_app/social_login_screen/cubit/cubit.dart';
import 'modules/social_app/social_register_screen/cubit/cubit.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => {
    print('firebase initialized successfully')
  }).catchError((error){
    print('firebase initialized error=>${error.toString()}');
  });
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  DioHelperNews.init();
  await CacheHelper.init();
  bool onBoarding =CacheHelper.getData(key: 'onBoarding');
  user=FirebaseAuth.instance.currentUser;
  if(user!=null)print(user!.uid);
   String? token = CacheHelper.getData(key: 'token');
  runApp(MyApp(
    onBoarding: onBoarding,
    token:token,
    user: user,
  ));
}
class MyApp extends StatelessWidget {
  bool?onBoarding;
  String?token;
  User?user;
  MyApp({
    required this.onBoarding,
    required this.token,
    required this.user,
});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoriteData(),
        ),

        BlocProvider(create: (BuildContext context) => RegisterCubit(),
        ),
        BlocProvider(create: (BuildContext context) => SocialRegisterCubit(),
    ),
        BlocProvider(create: (BuildContext context) => SocialLoginCubit(),
        ),
        BlocProvider(create: (BuildContext context) => SocialCubit()..getUsers()..getUserDataRealTime(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:CreateAccount(),
        // localizationsDelegates: [
        // AppLocale.delegate ,
        // GlobalMaterialLocalizations.delegate ,
        // GlobalWidgetsLocalizations.delegate
        // ],
        // supportedLocales: [
        //   Locale('en',''),
        //   Locale('ar',''),
        // ],
        // locale: Locale("ar" , ""),
        // localeResolutionCallback:( currentLang , supportLang ){
        //   if (currentLang != null) {
        //     for (Locale locale in supportLang) {
        //       if (locale.languageCode == currentLang.languageCode) {
        //         return currentLang ;
        //       }
        //     }
        //   }
        //   return supportLang.first ;
        // } ,
        //SocialLoginScreen(),
        //token!=null?ShopLayout():LoginScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
        ),
      ),
    );
  }
}