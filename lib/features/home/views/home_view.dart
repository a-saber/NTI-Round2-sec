import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nti_r2/core/translation/app_strings.dart';
import 'package:nti_r2/core/utils/app_assets.dart';
import 'package:nti_r2/core/utils/app_colors.dart';
import 'package:nti_r2/core/utils/app_paddings.dart';
import 'package:nti_r2/core/widgets/custom_svg.dart';

import 'widgets/task_item_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.viewPadding,
          child: ListView(
            children:
            [
              Row(
                children:
                [
                  Container(
                    margin: EdgeInsetsDirectional.only(end: 16),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey,
                        image: DecorationImage(
                            image: AssetImage(AppAssets.logo),
                            fit: BoxFit.cover
                        )
                    ),
                    // child: Image.asset(AppAssets.logo),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          AppStrings.hello,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: AppColors.black),
                        ),
                        SizedBox(height: 4,),
                        Text(
                          "Ahmed Saber",
                          maxLines: 1,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                              color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: (){},
                      icon: CustomSvg(path: AppAssets.addIcon)
                  )

                ],
              ),
              SizedBox(height: 50,),

              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, int index){
                    return TaskItemBuilder();
                  },
                  separatorBuilder: (context, int index)=> SizedBox(height: 5,),
                  itemCount: 6
              ),

            ],
          ),
        ),
      ),
    );
  }
}

