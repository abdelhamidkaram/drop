import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/api/firestore_strings.dart';
import 'package:dropeg/core/map_services/location_helper.dart';
import 'package:dropeg/core/map_services/map_style.dart';
import 'package:dropeg/core/utils/components/custom_back_button.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/auth/presentation/screens/register/location/bloc/cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/register/location/bloc/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_string.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../main.dart';
import '../../../widgets/hello_there.dart';
import '../../../widgets/sign_up_btn.dart';
import '../../../../../../core/utils/components/custom_text_field.dart';
import '../../../../../../core/utils/constant.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  static LocationData? myPosition;
  Completer<GoogleMapController> _controller = Completer();

  @override
  initState() {
    super.initState();
    getMyCurrentLocation().whenComplete(() {
      getAddressFromLatLng(
              context, myPosition!.latitude!, myPosition!.longitude!)
          .whenComplete(() {
        setState(() {});
      });
    });
  }

  String? addresstext;
  var addressController = TextEditingController();

  Future<String?> getAddressFromLatLng(context, double lat, double lng) async {
    var response = await Dio().get(
        "https://maps.google.com/maps/api/geocode/json?key=${AppConstants.mapKey}&language=en&latlng=$lat,$lng");
    if (response.statusCode == 200) {
      Map data = response.data;
      String formattedAddress = data["results"][0]["formatted_address"];
      if (kDebugMode) {
        print("response ==== $formattedAddress");
      }
      addresstext = formattedAddress;
      addressController.text = formattedAddress;
      return formattedAddress;
    }
    return null;
  }

  Future<void> getMyCurrentLocation() async {
    myPosition = await LocationHelper().getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> locationTypes = [
      AppStrings.locationTypeHome,
      AppStrings.locationTypeOffice,
      AppStrings.locationTypeParking,
      AppStrings.locationTypeOther,
    ];
    List<String> states = [AppStrings.locationStateEgypt];
    List<String> cities = AppConstants.cities;
    var locationKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LocationCubit(),
      child: BlocConsumer<LocationCubit, LocationStates>(
        listener: (context, state) => LocationCubit(),
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.black87,
            body: SafeArea(
              child: Stack(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 380,
                        child: myPosition == null
                            ? const Center(child: CircularProgressIndicator())
                            : GoogleMap(
                                myLocationButtonEnabled: true,
                                myLocationEnabled: true,
                                zoomControlsEnabled: false,
                                mapToolbarEnabled: true,
                                liteModeEnabled: false,
                                mapType: MapType.normal,
                                onTap: (argument) {
                                  setState(() {
                                    getAddressFromLatLng(context,
                                        argument.latitude, argument.longitude);
                                  });
                                },
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(myPosition!.latitude!,
                                      myPosition!.longitude!),
                                  bearing: 0.0,
                                  zoom: 17,
                                ),
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                  controller.setMapStyle(MapStyle.dark);
                                },
                              ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CustomBackButton(),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 500,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                            )),
                        child: Form(
                          key: locationKey,
                          child: ListView(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: HelloThere(
                                  title: AppStrings.locationDetails,
                                  subtitle: AppStrings.locationSubtitle,
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              SizedBox(
                                  height: 75,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, AppRouteStrings.compounds);
                                    },
                                    child: Card(
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              AppStrings.registeredCompounds,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 17.0,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              const SizedBox(
                                height: 25,
                              ),
                              CustomDropDownField(
                                locationFieldType: LocationFieldType.type,
                                list: locationTypes,
                                hint: AppStrings.locationTypeHIT,
                                validateMSG: AppStrings.locationTypeEmptMSG,
                              ),
                              CustomDropDownField(
                                  locationFieldType: LocationFieldType.state,
                                  list: states,
                                  hint: AppStrings.stateLocationHIT,
                                  validateMSG: AppStrings.stateEmptuMSG),
                              CustomDropDownField(
                                  locationFieldType: LocationFieldType.city,
                                  list: cities,
                                  hint: AppStrings.cityLocationHIT,
                                  validateMSG: AppStrings.cityEmptuMSG),
                              CustomTextFormField(
                                hint: AppStrings.addressHIT,
                                controller: addressController,
                                validateEmptyMSG:
                                    AppStrings.emailAddressEmptyMSG,
                                type: TextInputType.streetAddress,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Center(
                                child: SignUpBTN(
                                  value: 0.3,
                                  onTap: () async {
                                    if (locationKey.currentState!.validate()) {
                                      AppToasts.loadingToast();
                                      LocationEntity location = LocationEntity(
                                        address: addressController.text,
                                        state: LocationCubit.get(context)
                                            .locationState,
                                        city: LocationCubit.get(context).city,
                                        type: LocationCubit.get(context)
                                            .locationType,
                                      );
                                      await FirebaseFirestore.instance
                                          .collection(FirebaseStrings.usersCollection)
                                          .doc(uId)
                                          .collection(FirebaseStrings.locationsCollection)
                                          .doc(addressController.text)
                                          .set(location.toJson())
                                          .then((value) {
                                        AppToasts.successToast(
                                            AppStrings.success);
                                        Navigator.of(context)
                                            .pushNamed(AppRouteStrings.addCar);
                                      });
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomDropDownField extends StatefulWidget {
  final LocationFieldType locationFieldType;
  final String hint;
  final String validateMSG;
  final List<String> list;

  const CustomDropDownField(
      {Key? key,
      required this.locationFieldType,
      required this.list,
      required this.hint,
      required this.validateMSG})
      : super(key: key);

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  @override
  Widget build(BuildContext context) {
    String? value;
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
    return Column(
      children: [
        SizedBox(
          height: 70,
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
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
