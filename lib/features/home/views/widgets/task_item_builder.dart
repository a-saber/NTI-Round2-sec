import 'package:flutter/material.dart';
import 'package:nti_r2/core/utils/app_colors.dart';
import 'package:nti_r2/core/utils/app_text_styles.dart';

class TaskItemBuilder extends StatelessWidget {
  const TaskItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryLight,
        boxShadow: 
        [
          BoxShadow(
            color: AppColors.black.withAlpha(64),
            blurRadius: 4,
            spreadRadius: 0
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
               children:
               [
                 Text('My First Take My First Take My First Take My First Take',
                  style: AppTextStyles.taskTitleData,
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                 ),
                 SizedBox(height: 13,),
                 Text(
                   "Improve my English skills by trying to speek",
                   style: TextStyle(
                     color: AppColors.black,
                     fontWeight: FontWeight.w300,
                     fontSize: 14
                   ),
                 )
               ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('11/03/2025 5:00PM'.split(" ").first,
                  style: AppTextStyles.taskTitleData,
                ),
                Text('11/03/2025 05:00PM'.split(" ")[1],
                  style: AppTextStyles.taskTitleData,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
