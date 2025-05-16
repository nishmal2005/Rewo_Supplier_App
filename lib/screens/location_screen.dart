import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rewo_supplier/configs/app_colors.dart';
import 'package:rewo_supplier/configs/assets.dart';
import 'package:rewo_supplier/configs/dimensions.dart';
import 'package:rewo_supplier/configs/enums.dart';
import 'package:rewo_supplier/controllers/implementations/location_controller.dart';
import 'package:rewo_supplier/controllers/implementations/user_controller.dart';
import 'package:rewo_supplier/views/widgets/custom_text.dart';
import 'package:rewo_supplier/views/widgets/custom_text_form_field.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with WidgetsBindingObserver {
  final locationControler = Get.put(LocationController());

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      locationControler.onGetLocation(
          requestPermission: false, requestService: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (controler) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          title: CustomText(
            text: "Select a Location",
            fontSize: Dimensions.fontSize15,
            fontColor: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: AppColors.kPrimaryColor1,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
                onChanged: (value) {
                  controler.onGetSuggetions();
                },
                controller: controler.controller,
                hintText: "Search Location",
                prefixText: "",
                labelText: "",
                keyboardType: TextInputType.text,
                
                hideText: false),
            if (controler.controller.text.isNotEmpty)
              if (controler.getSuggestedLocationState == BasicState.done)
                Expanded(
                  child: ListView.separated(
                    itemCount: controler.suggessions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          controler.onSuggessionClick(index);
                        },
                        title: CustomText(
                            fontColor: AppColors.kPrimaryColor1,
                            text: controler.suggessions[index].description),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      indent: 15,
                      endIndent: 15,
                      color: AppColors.kPrimaryColor1,
                    ),
                  ),
                )
              else
                Expanded(
                    child: Center(
                  child: Lottie.asset(
                    Assets.loader,
                    height: 50.h,
                    delegates: LottieDelegates(
                      values: [
                        ValueDelegate.color(
                          const [
                            '**'
                          ], // Use ['**'] to match all elements, or specify exact path
                          value: AppColors.kPrimaryColor1,
                        ),
                      ],
                    ),
                  ),
                ))
            else
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_searching,
                            size: Dimensions.width24,
                            color: AppColors.kPrimaryColor1,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          if (controler.getCurrentLocationState ==
                              BasicState.done)
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  Get.find<UserController>().updateLocation(
                                      controler.currentLocation);
                                       Get.back();
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Use Current Address",
                                      fontColor: AppColors.kPrimaryColor1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: Dimensions.fontSize12,
                                    ),
                                    CustomText(
                                      text:
                                          controler.currentLocation?.address ??
                                              "",
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.fontSize12,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else if (controler.getCurrentLocationState ==
                              BasicState.error)
                            InkWell(
                              onTap: () {
                                controler.onGetLocation();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(text: "Retry"),
                                  Icon(Icons.restore)
                                ],
                              ),
                            )
                          else
                            Expanded(
                              child: Lottie.asset(
                                Assets.loader,
                                height: 50.h,
                                delegates: LottieDelegates(
                                  values: [
                                    ValueDelegate.color(
                                      const [
                                        '**'
                                      ], // Use ['**'] to match all elements, or specify exact path
                                      value: AppColors.kPrimaryColor1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
        bottomSheet: ((!controler.permissionEnabled ||
                !controler.serviceEnabled))
            ? Container(
                width: 400.w,
                decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor1,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!controler.serviceEnabled)
                      ListTile(
                        leading: Icon(
                          Icons.gps_fixed,
                          color: Colors.white,
                        ),
                        title: CustomText(
                          text: "Service Not Enabled",
                          fontSize: Dimensions.fontSize14,
                          fontColor: Colors.white,
                        ),
                        subtitle: CustomText(
                          text: "Please Enable service from Settings",
                          fontSize: Dimensions.fontSize12,
                          fontColor: Colors.white,
                        ),
                        trailing: InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            locationControler.onGetLocation(
                                requestPermission: false);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white)),
                            child: CustomText(
                              text: "Open",
                              fontColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    if (!controler.permissionEnabled)
                      ListTile(
                        leading: Icon(
                          Icons.gps_fixed,
                          color: Colors.white,
                        ),
                        title: CustomText(
                          text: "Permission Not Enabled",
                          fontSize: Dimensions.fontSize14,
                          fontColor: Colors.white,
                        ),
                        subtitle: CustomText(
                          text: "Please Enable Permission from Settings",
                          fontSize: Dimensions.fontSize12,
                          fontColor: Colors.white,
                        ),
                        trailing: InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            AppSettings.openAppSettings();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white)),
                            child: CustomText(
                              text: "Allow",
                              fontColor: Colors.white,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor1,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.gps_fixed,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: "Selected Address",
                            fontColor: AppColors.kWhite,
                            fontWeight: FontWeight.w600,
                            fontSize: Dimensions.fontSize12,
                          ),
                          GetBuilder<UserController>(builder: (userController) {
                            return CustomText(
                              text: userController
                                      .transporterModel.location?.address ??
                                  "No Selected Address",
                              fontColor: AppColors.kWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimensions.fontSize12,
                            );
                          }),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: CustomText(text: "Continue"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      );
    });
  }
}
