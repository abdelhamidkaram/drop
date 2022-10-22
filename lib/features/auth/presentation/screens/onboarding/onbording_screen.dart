import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/utils/app_colors.dart';
import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/assets_manger.dart';
import 'package:flutter/material.dart';
import 'package:dropeg/core/shared_prefs/app_prefs.dart';
import 'onboarding_build_item.dart';
import 'onboarding_model.dart';
import 'package:dropeg/injection_container.dart' as di;
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int pageIndex = 0 ;
  List<OnBoardingScreenDetails> screensDetails = [
    OnBoardingScreenDetails(
        title: AppStrings.obBoarding1Title,
        subTitle: AppStrings.obBoarding1SubTitle,
        imgPath: ImagesManger.onBoarding1),
    OnBoardingScreenDetails(
        title: AppStrings.obBoarding2Title,
        subTitle: AppStrings.obBoarding2SubTitle,
        imgPath: ImagesManger.onBoarding2),
    OnBoardingScreenDetails(
        title: AppStrings.obBoarding3Title,
        subTitle: AppStrings.obBoarding3SubTitle,
        imgPath: ImagesManger.onBoarding3),
    OnBoardingScreenDetails(
        title: AppStrings.obBoarding4Title,
        subTitle: AppStrings.obBoarding4SubTitle,
        imgPath: ImagesManger.onBoarding4),
  ];

  @override
  void initState() {
    AppPreferences(di.sl()).setOnBoardingScreenViewed().then((value) => null);
    super.initState();
  }
var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: PageView(
              controller: pageController,
          onPageChanged: (value) {

            setState(() {
              pageIndex = value ;
            });
          },
          physics: const BouncingScrollPhysics(),
          children: List.generate(
              screensDetails.length,
              (index) => OnBoardingBuildItem(screensDetails: screensDetails , index: index,)),
        )),
      ),
     bottomNavigationBar:  Padding(
       padding: const EdgeInsets.only(bottom:  16.0 , right: 20 ,top: 3 , left: 20),
       child: Row(
         children: [
           GestureDetector(
             onTap: (){
               Navigator.of(context).pushReplacementNamed(AppRouteStrings.home);
             },
             child: Card(
               elevation: 15,
               child: SizedBox(
                   height: 43,
                   width: 86,
                   child: Center(child: Text(AppStrings.skip , style: Theme.of(context).textTheme.headline5!.copyWith(
                     color: AppColors.grey,
                   ), ))),
             ),
           ),
           const Spacer(),
           GestureDetector(
             onTap: (){
               if(pageIndex == 3){
                 Navigator.of(context).pushReplacementNamed(AppRouteStrings.home);
               }else {
                 pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInToLinear);
               }
             },
             child: Container(

               height: 43,
               width: pageIndex == 3  ? 150 :  86,
               decoration: BoxDecoration(
                 color: AppColors.primaryColor,
                 borderRadius: BorderRadius.circular(12),
               ),
               child:  Center(child: Text(pageIndex == 3 ?AppStrings.goToHome :">" , style: Theme.of(context).textTheme.headline5!.copyWith(
                 color: AppColors.white,
               ),)),
             ),
           )
         ],
       ),
     ),
    );
  }
}



