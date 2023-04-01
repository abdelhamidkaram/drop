import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manger.dart';
import 'onboarding_model.dart';

class OnBoardingBuildItem extends StatelessWidget {
  const OnBoardingBuildItem({
    Key? key,
    required this.screensDetails, required this.index,
  }) : super(key: key);

  final List<OnBoardingScreenDetails> screensDetails;
  final int  index ;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Image.asset(ImagesManger.logo, height: 35,),
          ),
          SizedBox(
            height: 560.h ,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 380.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.asset(screensDetails[index].imgPath ,  ).image,
                      fit: BoxFit.fitWidth
                    )
                  ),

                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Text(
                              screensDetails[index].title,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              screensDetails[index].subTitle,
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            const SizedBox(height: 16,),
                            Center(child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:List.generate(4, (dotIndex) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: dotIndex == index ? AppColors.primaryColor : AppColors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: dotIndex == index ? 7 : 5 ,
                                  width: dotIndex == index ? 16 : 12,
                                ),
                              )),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],

            ),
          ),
        ],
      ),
    );
  }
}