import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 190.h,bottom: 10.h),
              height: 200.h,
              width: 200.w,
              child: Image.asset('assets/logos/logo1.png',fit: BoxFit.fill,),
            ),
            Text("Rewo Store",style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 34.dg,
            ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text("Hello !",style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 35.dg,
                color: Color(0xff58A184)
            ),
            ),
            Text("Let’s get started.",style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20.dg,
                color: Colors.black87
            ),
            ),
          ],
        ),
      ) ,
      ),
    );
  }
}
