import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/enums.dart';
import '../screens/register/location/bloc/cubit.dart';

class CustomDropDownField extends StatefulWidget {
  final LocationFieldType locationFieldType;
  final String hint;
  final String validateMSG;
  final List<String> list;
  final String? value;

  const CustomDropDownField(
      {Key? key,
        required this.locationFieldType,
        required this.list,
        required this.hint,
        required this.validateMSG,
        this.value})
      : super(key: key);

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  @override
  Widget build(BuildContext context) {
    String? value = widget.value;
    if (value == null ) {
      switch (widget.locationFieldType) {
        case LocationFieldType.city:
          value = LocationCubit.get(context).city;
          break;
        case LocationFieldType.state:
          value = LocationCubit.get(context).locationState;
          break;
        case LocationFieldType.type:
          value = LocationCubit.get(context).locationType;
      }
    }
    return Column(
      children: [
        SizedBox(
          height:60.h,
          child: Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonFormField(
                  validator: (value) {
                    if (value == null) {
                      return widget.validateMSG;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  dropdownColor: Colors.white,
                  value: value,
                  hint: Text(widget.hint),
                  onChanged: (newValue) {
                    setState(() {
                      switch (widget.locationFieldType) {
                        case LocationFieldType.city:
                          LocationCubit.get(context).city =
                              newValue!.toString();
                          break;
                        case LocationFieldType.state:
                          LocationCubit.get(context).locationState =
                              newValue!.toString();
                          break;
                        case LocationFieldType.type:
                          LocationCubit.get(context).locationType =
                              newValue!.toString();
                      }
                    });
                  },
                  icon: Icon(Icons.keyboard_arrow_down),
                  items:
                  widget.list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                ),
              
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
