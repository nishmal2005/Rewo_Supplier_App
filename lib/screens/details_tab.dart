import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewo_supplier/controllers/implementations/user_controller.dart';
import 'package:rewo_supplier/screens/materilas.dart';
import 'package:rewo_supplier/screens/register_supplier.dart';
import 'package:rewo_supplier/screens/supplier_upload_documents.dart';
import 'package:rewo_supplier/screens/bank_details.dart';
import 'package:rewo_supplier/views/widgets/custom_registration.dart';

import '../configs/app_colors.dart';

class DetailsTab extends StatelessWidget {
  DetailsTab({super.key});
  final controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              EasyStepper(
                showTitle: false,
                activeStep: controller.selectedTab.value,
                lineStyle: LineStyle(
                  finishedLineColor: AppColors.kPrimaryColor1,
                  activeLineColor: Colors.grey,
                  lineLength: 60,
                  lineType: LineType.normal,
                  lineThickness: 1,
                  lineSpace: 3,
                  lineWidth: 4,
                  unreachedLineType: LineType.dashed,
                ),
                stepShape: StepShape.rRectangle,
                stepBorderRadius: 0,
                borderThickness: 0,
                internalPadding: 10,
                // padding:
                //     const EdgeInsetsDirectional.only(start: 20, end: 20),
                stepRadius: 15,
                finishedStepBorderColor: Colors.white,
                finishedStepTextColor: Colors.white,
                finishedStepBackgroundColor: Colors.white,
                activeStepIconColor: Colors.white,
                activeStepBorderColor: Colors.white,
                unreachedStepBorderColor: Colors.white,
                showLoadingAnimation: false,
                steps: List.generate(
                  4,
                  (index) => EasyStep(
                    customStep: CircleAvatar(
                      backgroundColor: controller.selectedTab.value >= index
                          ? Color(0xff557669)
                          : Colors.grey.shade300,
                      child: controller.selectedTab.value >= index
                          ? controller.selectedTab.value == index
                              ? const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 6,
                                )
                              : const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.white,
                                )
                          : null,
                    ),
                  ),
                ),
                onStepReached: (index) {},
              ),
              [
                RegisterTransporter(),
              
                BankDetailsScreen(),
                  MaterialScreen(),
                UploadDocuments(),
                
              ][controller.selectedTab.value],
              GestureDetector(
                onTap: () {
                  controller.uploadRgistration();
                },
                child: CustomRegistration(
                  buttonText: "Register",
                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      )),
    );
  }
}
