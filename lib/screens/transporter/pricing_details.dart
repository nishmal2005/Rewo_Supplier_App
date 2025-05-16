import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rewo_supplier/controllers/implementations/user_controller.dart';
import 'package:rewo_supplier/views/widgets/custom_text_form_field.dart';


class PricingDetails extends StatelessWidget {
  PricingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Column(
        children: [
          Text(
            "Pricing",
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
          GetBuilder<UserController>(builder: (controller) {
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10,),
                itemCount: controller.createPricingModels.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                keyboardType: TextInputType.name,
                                readOnly: true,
                                hintText: controller
                                    .createPricingModels[index].from
                                    .toString(),
                                labelText: 'From',
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: CustomTextField(
                                keyboardType: TextInputType.name,
                                readOnly: true,
                                hintText: controller.createPricingModels[index].to
                                        ?.toString() ??
                                    "infinity",
                                labelText: 'To',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                keyboardType: TextInputType.phone,
                                labelText: 'Price',
                                controller: controller
                                    .createPricingModels[index].priceController,
                              ),
                            ),
                            SizedBox(width: 10.w),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }),
        
        ],
      ),
    );
  }
}
