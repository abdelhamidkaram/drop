import 'package:dropeg/core/utils/app_string.dart';
import 'package:dropeg/core/utils/constant.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String hint ;

  final String validateEmptyMSG ;
  final TextEditingController controller ;
  final bool? isPassword;
  final bool? isPhone;
  final TextInputType type ;
  const CustomTextFormField({
    this.isPassword ,
    Key? key, required this.hint, required this.controller,required this.validateEmptyMSG, required this.type, this.isPhone,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: TextFormField(
              controller: widget.controller,
              validator: (value) {
                if(value == null || value.isEmpty){
                  return widget.validateEmptyMSG;
                }
                if(widget.isPhone == true && !value.contains(RegExp(AppConstants.phoneRegExp)) ){
                  return AppStrings.phoneNumberEmptyMSG2;
                }
                return null;
              },
              obscureText: (showPassword && widget.isPassword == true ),
              keyboardType: widget.type ,
              decoration:  InputDecoration(
                suffixIcon: (widget.isPassword != null && widget.isPassword == true ) ? GestureDetector(
                  onTap: (){
                   setState(() {
                     showPassword = !showPassword;
                   });
                  },
                  child: Icon(
                    showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: AppColors.grey,
                  ),
                ) : null,
                border: InputBorder.none ,
                hintText: widget.hint,
              ),
            ),
          ),
        ),
      ),
    );

  }
}