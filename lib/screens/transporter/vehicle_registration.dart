import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rewo_supplier/configs/app_colors.dart';
import 'package:rewo_supplier/configs/assets.dart';
import 'package:rewo_supplier/configs/enums.dart';
import 'package:rewo_supplier/controllers/implementations/material_controller.dart';
import 'package:rewo_supplier/controllers/implementations/transporter_controller.dart';
import 'package:rewo_supplier/views/widgets/custom_text.dart';
import 'package:rewo_supplier/views/widgets/custom_text_form_field.dart';


class VehicleRegistration extends StatelessWidget {
  VehicleRegistration({super.key});
  final materialController = Get.put(MaterialController());
  final controller = Get.find<TransporterController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        Text(
          "Register",
          style: TextStyle(
              color: Color(0xff557669),
              fontSize: 42.dg,
              fontWeight: FontWeight.w600),
        ),
        Text(
          "Vehicle",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 24.dg,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
          keyboardType: TextInputType.name,
          
          controller: controller.vehicleModel.vehicleNumberController,
          hideText: "-------",
          labelText: 'Vehicle Number',
          
          
        ),
        CustomTextField(
          hideText: "-------",
          keyboardType: TextInputType.name,
          
          controller: controller.vehicleModel.vehiclemanufacturerController,
          labelText: 'Vehicle Manufacturer',
          
          
        ),
        CustomTextField(
          keyboardType: TextInputType.name,
          hideText: "-------",
          
          controller: controller.vehicleModel.modelController,
          labelText: 'Model',
          
          
        ),
        CustomTextField(
          keyboardType: TextInputType.number,
          hideText: Text(
            "Volume in m³ or cft and Weight in Tons",
            style: TextStyle(color: Colors.grey),
          ),
          controller: controller.vehicleModel.loadVolumeControler,
          labelText: 'Load Capacity(Volume)',
          
          
        ),
        CustomTextField(
          keyboardType: TextInputType.number,
          hideText: Text(
            "Volume in m³ or cft and Weight in Tons",
            style: TextStyle(color: Colors.grey),
          ),
          controller: controller.vehicleModel.loadWeightController,
          labelText: 'Load Capacity(Weight)',
          
          
        ),
        GetBuilder<MaterialController>(builder: (materialController) {
          return Column(
            children: [
              CustomTextField(
                suffixIcon: Icons.arrow_drop_down,
                keyboardType: TextInputType.name,
                hideText: "Bricks,Sand,Stone,etc",
                
                labelText: 'Material',
                
                
                readOnly: true,
                ontap: () {
                  materialController.materialClicked =
                      !materialController.materialClicked;
                  materialController.update();
                },
              ),
              if (materialController.materialClicked)
                if (materialController.getMaterialState == BasicState.done)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: materialController.transporterMaterials.length,
                    itemBuilder: (context, index) {
                      final material = materialController.transporterMaterials[index];
             
      
                    return GetBuilder<TransporterController>(builder: (userController) {
        final isSelected = userController.vehicleModel.selectedMaterialTypes
        .any((element) => element.id == material.id);
      
        return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.white, // for unchecked box border
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) {
            return Colors.white; // check color
          }),
          checkColor: MaterialStateProperty.all(Colors.green), // check icon fill
        ),
      ),
      child: CheckboxListTile(
        title: Text(
          material.name,
          style:  TextStyle(color: AppColors.kPrimaryColor1),
        ),
        value: isSelected,
        onChanged: (bool? value) {
          if (value == true) {
            userController.vehicleModel.selectedMaterialTypes.add(material);
          } else {
            userController.vehicleModel.selectedMaterialTypes
                .removeWhere((element) => element.id == material.id);
          }
          userController.update();
        },
        activeColor: AppColors.kPrimaryColor1, // check mark color
        checkColor: AppColors.kWhite, // background of the checkmark
        controlAffinity: ListTileControlAffinity.leading,
      ),
        );
      });
      
                    },
                  )
                else if (materialController.getMaterialState == BasicState.error)
                  InkWell(
                    onTap: () {
                      materialController.onGetMaterials();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [CustomText(text: "Retry"), Icon(Icons.restore)],
                    ),
                  )
                else
                  Lottie.asset(
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
            ],
          );
        }),
      ]),
    );
  }
}
