import 'package:flutter/material.dart';
import 'package:nti_r2/core/cache/cache_helper.dart';
import 'package:nti_r2/core/cache/cache_keys.dart';
import 'package:nti_r2/core/helper/my_navigator.dart';
import 'package:nti_r2/core/translation/translation_keys.dart';
import 'package:nti_r2/core/utils/app_assets.dart';
import 'package:nti_r2/core/utils/app_colors.dart';
import 'package:nti_r2/core/widgets/custom_filled_btn.dart';
import 'package:nti_r2/core/widgets/custom_svg.dart';
import 'package:nti_r2/features/auth/views/register_view.dart';

class GetStartView extends StatelessWidget {
  const GetStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Padding(
          padding:  EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.045,
            right: 22,
            left: 22
          ),

          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
              [
                // svg image
                CustomSvg(
                  path: AppAssets.getStart,
                  width: MediaQuery.of(context).size.width*0.8,
                ),

                // welcome text
                Text(TranslationKeys.welcomeToDoIt,
                  textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black
                ),),

                // text
                Text(TranslationKeys.readyToConquer,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey
                  ),),

                // get started button
                CustomFilledBtn(
                  text: TranslationKeys.letStart,
                  onPressed: () async
                  {
                    await CacheHelper.saveData(key: CacheKeys.firstTime, value: false);
                    MyNavigator.goTo(screen: ()=> RegisterView());
                  },
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
