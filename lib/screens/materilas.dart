import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rewo_supplier/configs/app_colors.dart';
import 'package:rewo_supplier/configs/assets.dart';
import 'package:rewo_supplier/configs/enums.dart';
import 'package:rewo_supplier/controllers/implementations/material_controller.dart';
import 'package:rewo_supplier/controllers/implementations/user_controller.dart';
import 'package:rewo_supplier/models/material_add_model.dart';
import 'package:rewo_supplier/views/widgets/custom_text.dart';
import '../views/widgets/custom_text_form_field.dart';

class MaterialScreen extends StatelessWidget {
  MaterialScreen({super.key});

  final materialController = Get.put(MaterialController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Text(
            "Materials",
            style: TextStyle(
              color: Color(0xff557669),
              fontSize: 42.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Details",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 22.h),
          GetBuilder<MaterialController>(builder: (materialController) {
            return Column(
              children: [
                GetBuilder<UserController>(
                  builder: (user) {
                    return CustomTextField(
                      suffixIcon: Icons.arrow_drop_down,
                      keyboardType: TextInputType.name,
                      hideText: "Bricks,Sand,Stone,etc",
                      labelText: 'Material',
                      hintText: user.materilas.map((e) => e.name??"",).toString().replaceFirst("(", "").replaceFirst(")", ""),
                      
                      readOnly: true,
                      ontap: () {
                        materialController.materialClicked =
                            !materialController.materialClicked;
                        materialController.update();
                      },
                    );
                  }
                ),
                if (materialController.materialClicked)
                  if (materialController.getMaterialState == BasicState.done)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: materialController.materials.length,
                      itemBuilder: (context, index) {
                        final material = materialController.materials[index];

                        return GetBuilder<UserController>(
                            builder: (userController) {
                          final isSelected = userController.materilas.any(
                              (element) =>
                                  element.id == material.materialTypesId);

                          final materialSelected = userController.materilas
                              .firstWhereOrNull((element) =>
                                  element.id == material.materialTypesId);
                          return Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors
                                        .white, // for unchecked box border
                                    checkboxTheme: CheckboxThemeData(
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        return Colors.white; // check color
                                      }),
                                      checkColor: MaterialStateProperty.all(
                                          Colors.green), // check icon fill
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    title: Text(
                                      "${material.materialName ?? ""}-${material.typesName ?? ""}",
                                      style: TextStyle(
                                          color: AppColors.kPrimaryColor1),
                                    ),
                                    value: isSelected,

                                    onChanged: (bool? value) {
                                      if (value == true) {
                                        userController.materilas.add(
                                            MaterialAddModel(
                                              name: (material.materialName ?? "") +
                                          (material.typesName ?? ""),
                                                id: material.materialTypesId));
                                      } else {
                                        userController.materilas.removeWhere(
                                            (element) =>
                                                element.id ==
                                                material.materialTypesId);
                                      }
                                      userController.update();
                                    },
                                    activeColor: AppColors
                                        .kPrimaryColor1, // check mark color
                                    checkColor: AppColors
                                        .kWhite, // background of the checkmark
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ),
                              ),
                              if (isSelected && materialSelected != null)
                                Expanded(
                                    flex: 2,
                                    child: CustomTextField(
                                      keyboardType: TextInputType.number,
                                      labelText: "Price",
                                      controller: materialSelected
                                          .textEditingController,
                                    ))
                            ],
                          );
                        });
                      },
                    )
                  else if (materialController.getMaterialState ==
                      BasicState.error)
                    InkWell(
                      onTap: () {
                        materialController.onGetMaterials();
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
        ],
      ),
    );
  }
}
