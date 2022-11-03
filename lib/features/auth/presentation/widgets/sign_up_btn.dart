import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/components/app_buttons.dart';
import '../screens/register/location/bloc/cubit.dart';

class SignUpBTN extends StatelessWidget {
  final double value ;
  final VoidCallback? onTap ;
  final VoidCallback editOnPressed ;
  final bool isEdit ;
  final String? locationId ;
  const SignUpBTN({Key? key, required this.value, required this.onTap,  this.isEdit = false, this.locationId, required this.editOnPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  isEdit ?   Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: AppButtonBlue(
            text: AppStrings.editLocation,
            onTap: editOnPressed,
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          child: AppButtonRed(
              text: AppStrings.cancel,
              onTap: () {
                Navigator.of(context).pop();
              }),
        ),
        SizedBox(
          width: 5.w,
        ),
        InkWell(
          onTap: (){
            LocationCubit.get(context).deleteLocation(locationId!).then((value){
              Navigator.pop(context);
            });
          },
          child: Text(AppStrings.deleteLocation , style: Theme.of(context).textTheme.headline6!.copyWith(
              color: AppColors.red
          ),),
        )

      ],
    ) : GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 80,
        width: 80,
        child: Stack(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                color:const Color(0xFFE3E3E3),
                strokeWidth: 5,
                backgroundColor: AppColors.primaryColor,
                value: value,
              ),
            ),
             Center(
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle
                ),
                child:  Icon(value == 0.0 ? Icons.check_rounded : Icons.arrow_forward_rounded , color: AppColors.white, size: value == 0.0 ? 50 : null, ),
              ),
            )
          ],
        ),
      ),
    );
  }
}