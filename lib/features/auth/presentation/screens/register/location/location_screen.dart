import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dropeg/config/route/app_route.dart';
import 'package:dropeg/core/map_services/location_helper.dart';
import 'package:dropeg/core/map_services/map_style.dart';
import 'package:dropeg/core/utils/components/custom_back_button.dart';
import 'package:dropeg/core/utils/toasts.dart';
import 'package:dropeg/features/auth/domain/entities/location.dart';
import 'package:dropeg/features/auth/presentation/screens/profile/bloc/cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/register/location/bloc/cubit.dart';
import 'package:dropeg/features/auth/presentation/screens/register/location/bloc/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';
import '../../../../../../config/route/app_route_arguments.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_string.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../widgets/custom_drop_down_field.dart';
import '../../../widgets/hello_there.dart';
import '../../../widgets/sign_up_btn.dart';
import '../../../../../../core/utils/components/custom_text_field.dart';
import '../../../../../../core/utils/constant.dart';


class LocationScreen extends StatefulWidget {
  final bool formProfileScreen;
  final LocationEntity? locationEntity;

  const LocationScreen(
      {Key? key, this.formProfileScreen = false, required this.locationEntity})
      : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  static LocationData? myPosition;
  final Completer<GoogleMapController> _controller = Completer();

  @override
  initState() {
    super.initState();
    getMyCurrentLocation().whenComplete(() {
      getAddressFromLatLng(
          context, myPosition?.latitude ?? 30.005493,
          myPosition?.longitude ?? 31.477898)
          .whenComplete(() {
        setState(() {});
      });
    });
  }

  String? addresstext;
  var addressController = TextEditingController();

  Future<String?> getAddressFromLatLng(context, double lat, double lng) async {
    var response = await Dio().get(
        "https://maps.google.com/maps/api/geocode/json?key=${AppConstants
            .mapKey}&language=en&latlng=$lat,$lng");
    if (response.statusCode == 200) {
      Map data = response.data;
      String formattedAddress = data["results"][0]["formatted_address"];
      if (kDebugMode) {
        print("response ==== $formattedAddress");
      }
      if (widget.locationEntity == null) {
        addresstext = formattedAddress;
        addressController.text = formattedAddress;
      } else {
        addresstext = widget.locationEntity!.address!;
        addressController.text = widget.locationEntity!.address!;
      }
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

    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (context) => LocationCubit(),),
      ],
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
                        height: 340.h,
                        child: myPosition == null
                            ? const Center(
                            child: CircularProgressIndicator.adaptive())
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
                        height: 410.h,
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
                            physics: const BouncingScrollPhysics(),
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: HelloThere(
                                  title: AppStrings.locationDetails,
                                  subtitle: AppStrings.locationSubtitle,
                                ),
                              ),
                              SizedBox(
                                  height: 73.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context, AppRouteStrings.compounds,
                                        arguments: CompoundsViewArgs(
                                            toAddCarScreen: !widget
                                                .formProfileScreen),
                                      );
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
                                              style: Theme
                                                  .of(context)
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
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomDropDownField(
                                locationFieldType: LocationFieldType.type,
                                list: locationTypes,
                                hint: AppStrings.locationTypeHIT,
                                validateMSG: AppStrings.locationTypeEmptMSG,
                                value: widget.locationEntity?.type,
                              ),
                              CustomDropDownField(
                                  locationFieldType: LocationFieldType.state,
                                  list: states,
                                  hint: AppStrings.stateLocationHIT,
                                  validateMSG: AppStrings.stateEmptuMSG,
                                  value: widget.locationEntity?.state),
                              CustomDropDownField(
                                locationFieldType: LocationFieldType.city,
                                list: cities,
                                hint: AppStrings.cityLocationHIT,
                                validateMSG: AppStrings.cityEmptuMSG,
                                value: widget.locationEntity?.city,
                              ),
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
                                  locationId: widget.locationEntity?.id ?? "",
                                  value: widget.formProfileScreen ? 0.0 : 0.3,
                                  onTap: () async {
                                    if (locationKey.currentState!.validate()) {
                                      AppToasts.loadingToast();
                                      LocationEntity location = LocationEntity(
                                        address: addressController.text,
                                        state: LocationCubit
                                            .get(context)
                                            .locationState,
                                        city: LocationCubit
                                            .get(context)
                                            .city,
                                        type: LocationCubit
                                            .get(context)
                                            .locationType,
                                        id: const Uuid().v4(),
                                      );
                                      await LocationCubit.get(context)
                                          .addLocation(
                                          context, widget.formProfileScreen,
                                          location)
                                          .then((value) async {
                                        await ProfileCubit.get(context)
                                            .getLocations(isRefresh: true);
                                      });
                                    }
                                  },
                                  editOnPressed: () {
                                    LocationEntity location = LocationEntity(
                                      address: addressController.text,
                                      state: LocationCubit
                                          .get(context)
                                          .locationState ??
                                          widget.locationEntity!.state,
                                      city: LocationCubit
                                          .get(context)
                                          .city ?? widget.locationEntity!.city,
                                      type: LocationCubit
                                          .get(context)
                                          .locationType ??
                                          widget.locationEntity!.type,
                                      id: widget.locationEntity!.id,
                                    );
                                    LocationCubit.get(context).editLocation(
                                        widget.locationEntity!, location).then((
                                        value) {
                                      ProfileCubit.get(context).getLocations(
                                          isRefresh: true).then((value) {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                            AppRouteStrings.account);
                                      }).catchError((err) {
                                        if (kDebugMode) {
                                          print(err.toString());
                                        }
                                      });
                                    }).catchError((err) {
                                      if (kDebugMode) {
                                        print(err.toString());
                                      }
                                    });
                                  },
                                  isEdit: widget.locationEntity != null,
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

