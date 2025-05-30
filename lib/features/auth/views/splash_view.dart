import 'package:flutter/material.dart';
import 'package:nti_r2/core/cache/cache_data.dart';
import 'package:nti_r2/core/cache/cache_helper.dart';
import 'package:nti_r2/core/cache/cache_keys.dart';
import 'package:nti_r2/core/constants/app_constants.dart';
import 'package:nti_r2/core/helper/my_navigator.dart';
import 'package:nti_r2/core/utils/app_assets.dart';
import 'package:nti_r2/core/utils/app_colors.dart';
import 'package:nti_r2/core/widgets/custom_svg.dart';
import 'package:nti_r2/features/auth/views/login_view.dart';
import 'package:nti_r2/features/home/cubit/user_cubit/user_cubit.dart';
import 'package:nti_r2/features/home/views/home_view.dart';

import 'get_start_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    navigate(context);
    super.initState();
  }
  void navigate(context)async
  {
 Future.delayed((Duration(milliseconds: 500)),
        ()
     {
       // navigate to lets start view
       CacheData.firstTime = CacheHelper.getData(key: CacheKeys.firstTime);
       if(CacheData.firstTime != null)
       {
         // check is logged in
         CacheData.accessToken = CacheHelper.getData(key: CacheKeys.accessToken);
         if(CacheData.accessToken != null)
         {
           UserCubit.get(context).getUserDataFromAPI()
               .then((bool result)
           {
             if(result) {
               MyNavigator.goTo(screen: ()=> HomeView(), isReplace: true);
             }
             else
             {
               MyNavigator.goTo(screen: ()=> LoginView(), isReplace: true);
             }
           });
         }
         else
         {
           // goto login
           MyNavigator.goTo(screen: ()=> LoginView(), isReplace: true);
         }
       }
       else// first time
           {
         MyNavigator.goTo(screen: ()=> GetStartView(), isReplace: true);
       }
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            // logo as svg
            CustomSvg(
              path: AppAssets.logo,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            SizedBox(height: 44,), // TODO: check MediaQuery

            // Text as app name
            Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: AppColors.primary
              ),
            )


          ],
        ),
      ),
    );
  }
}
