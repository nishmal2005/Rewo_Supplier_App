
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rewo_supplier/configs/app_colors.dart';
import 'package:rewo_supplier/configs/dimensions.dart';
import 'package:rewo_supplier/controllers/implementations/transporter_controller.dart';
import 'package:rewo_supplier/screens/transporter/details_tab.dart';
import 'package:rewo_supplier/views/widgets/custom_text.dart';
import 'package:rewo_supplier/views/widgets/custom_text_form_field.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:rewo_store/configs/app_colors.dart';
// import 'package:rewo_store/configs/dimensions.dart';
// import 'package:rewo_store/controllers/implementations/user_controller.dart';
// import 'package:rewo_store/models/upload_documents_model.dart';
// import 'package:rewo_store/screens/details_tab.dart';
// import 'package:rewo_store/views/widgets/custom_text.dart';
// import 'package:rewo_store/views/widgets/custom_text_form_field.dart';
// import 'package:url_launcher/url_launcher.dart';

const Color customGreen = Color(0xFF557669);
const Color customGreenLight = Color(0xFF7D998A);

class CurvePainter extends CustomPainter {
  final Color color;

  CurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();
    path.moveTo(0, 30);
    path.quadraticBezierTo(
      size.width / 2 + 100,
      -80,
      size.width,
      30,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TransporterProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<TransporterController>(builder: (controller) {
            return Column(
              children: [
                InfoCard(
                  title: "Transporter Details",
                  content: "Name      : Bens George\n"
                      "Location  : Kochi\n"
                      "Contact   : 9985334744\n"
                      "Address   : vettupurakkal (H),\n"
                      "             kaduvakavala (P.O),\n"
                      "             656678",
                  values: [
                    ContentRow(
                        param: "Name", value: controller.userData?.name ?? ""),
                    ContentRow(
                        param: "Location",
                        value: controller.userData?.location?.address ?? ""),
                    ContentRow(
                        param: "Contact",
                        value: controller.userData?.contactNumber ?? ""),
                    ContentRow(
                        param: "Company Name",
                        value: controller.userData?.companyName ?? ""),
                    ContentRow(
                        param: "Owner Name",
                        value: controller.userData?.ownerName ?? ""),
                    ContentRow(
                        param: "Owner Contact",
                        value: controller.userData?.ownerContact ?? ""),
                  ],
                  ontap: () {
                    controller.transporterModel
                        .assignFromUserModel(controller.userData!);
                    controller.update();
                    controller.selectedTab.value = 0;
                    Get.to(() => DetailsTab(
                          edit: true,
                        ));
                        
                  },chips: controller.userData?.materials?.map((e) => e.name,).toList()??[],
                ),

                // InfoCard(
                //   title: "Bank Details",
                //   content: "Acc No: 6737635256\nBank: SBI",
                //   actions: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         SizedBox(
                //           width: (screenWidth - 112) / 2,
                //           child: OutlinedButton(
                //             onPressed: () {},
                //             style: OutlinedButton.styleFrom(
                //               side: BorderSide(color: Colors.white),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(10),
                //               ),
                //               foregroundColor: Colors.white,
                //               backgroundColor: customGreen,
                //               padding: EdgeInsets.symmetric(vertical: 12),
                //             ),
                //             child: CustomText(
                //               text: "Check Balance",
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //           width: (screenWidth - 112) / 2,
                //           child: OutlinedButton(
                //             onPressed: () {},
                //             style: OutlinedButton.styleFrom(
                //               side: BorderSide(color: Colors.white),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(10),
                //               ),
                //               foregroundColor: Colors.white,
                //               backgroundColor: customGreen,
                //               padding: EdgeInsets.symmetric(vertical: 12),
                //             ),
                //             child: CustomText(
                //               text: "Withdrawal",
                //             ),
                //           ),
                //         ),
                //       ],
                //     )
                //   ],
                // ),
                InfoCard(
                  ontap: () {
                    controller.vehicleModel
                        .assignFromUserModel(controller.userData!);
                    controller.update();
                    controller.selectedTab.value = 1;
                    Get.to(() => DetailsTab(
                          edit: true,
                        ));
                  },
                  title: "Vehicle Details",
                  content:
                      "Vehicle No: KL35X3223\nManufacturer: Tata\nModel: Tata 2518 Truck 2016\nLoad Capacity: 19,000 kg",
                  values: [
                    ContentRow(
                        param: "Vehicle No",
                        value: controller.userData?.vehicleNumber ?? ""),
                    ContentRow(
                        param: "Manufacturer",
                        value: controller.userData?.manufacturer ?? ""),
                    ContentRow(
                        param: "Model",
                        value: controller.userData?.model ?? ""),
                    ContentRow(
                        param: "Load capacity(Volume)",
                        value:
                            "${controller.userData?.loadCapacityVolume ?? ""} Cft"),
                    ContentRow(
                        param: "Load capacity(Weight)",
                        value:
                            "${controller.userData?.loadCapacityWeight ?? ""} Ton"),
                  ],
                ),
                DocumentGrid(
                  ontap:  () {
                      controller.vehicleModel
                        .assignFromUserModel(controller.userData!);
                    controller.update();
                    controller.selectedTab.value = 2;
                    Get.to(() => DetailsTab(
                          edit: true,
                        ));
                  },
                  medias: [
                    MediaWithHead(
                        head: "Rc",
                        url: controller.userData?.documents?.rcImage ?? ""),
                    MediaWithHead(
                        head: "Driving Licence",
                        url: controller
                                .userData?.documents?.drivingLicenceImage ??
                            ""),
                    MediaWithHead(
                        head: "Vehicle Front",
                        url:
                            controller.userData?.documents?.vehicleFrontImage ??
                                ""),
                    MediaWithHead(
                        head: "Vehicle Back",
                        url: controller.userData?.documents?.vehicleBackImage ??
                            ""),
                    MediaWithHead(
                        head: "Vehicle Right",
                        url:
                            controller.userData?.documents?.vehicleRightImage ??
                                ""),
                    MediaWithHead(
                        head: "Vehicle Left",
                        url: controller.userData?.documents?.vehicleLeftImage ??
                            ""),
                    MediaWithHead(
                        head: "Vehicle video",
                        url:
                            controller.userData?.documents?.vehicleVideo ?? ""),
                    MediaWithHead(
                        head: "Insurance",
                        url: controller.userData?.documents?.insuranceImage ??
                            "")
                  ],
                ),
                // MaterialToggleSection(),
                Container(padding: EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: AppColors.kPrimaryColor1),
                child:   Column(children: [  ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10,),
                itemCount: (controller.userData?.priceRanges??[]).length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                final priceRange=  (controller.userData?.priceRanges??[])[index];
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
                                hintText: priceRange.from
                                    .toString(),
                                labelText: 'From',

                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: CustomTextField(
                                keyboardType: TextInputType.name,
                                readOnly: true,
                                hintText: priceRange.to?.toString() ??
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
                                readOnly: true,
                                hintText: priceRange.price?.toString() ??
                                    "infinity",
                              ),
                            ),
                            SizedBox(width: 10.w),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                 Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 15,
              ),
              onPressed: (){
controller.assignFromPriceRanges();
                    
                    controller.selectedTab.value = 3;
                    Get.to(() => DetailsTab(
                          edit: true,
                        ));
              },
            ),
          ),
                ],)
           
          
                )
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final Function()? ontap;
final  List<ContentRow> values;
final List<String>chips;
  InfoCard(
      {required this.title,
      required this.content,
      this.values = const [], this.chips=const[],
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.kPrimaryColor1,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            fontSize: Dimensions.fontSize15,
            fontWeight: FontWeight.bold,
            fontColor: Colors.white,
          ),
          SizedBox(height: 8),
          ListView.builder(
            itemCount: values.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    flex: 1,
                    child: CustomText(
                      text: values[index].param,
                      fontSize: Dimensions.fontSize12,
                      fontWeight: FontWeight.w300,
                      fontColor: Colors.white,
                    )),
                CustomText(
                  text: "  :   ",
                  fontSize: Dimensions.fontSize12,
                  fontWeight: FontWeight.w500,
                  fontColor: Colors.white,
                ),
                Expanded(
                    flex: 2,
                    child: CustomText(
                      text: values[index].value,
                      fontSize: Dimensions.fontSize12,
                      fontWeight: FontWeight.w500,
                      fontColor: Colors.white,
                    ))
              ],
            ),
          ),
          Wrap(children:List.generate(chips.length, (index) => Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2),borderRadius: BorderRadius.circular(10)),child: CustomText(text: chips[index],fontColor: Colors.white
            ,),),),),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 15,
              ),
              onPressed: ontap,
            ),
          ),
        ],
      ),
    );
  }
}

class ContentRow {
  final String param;
  final String value;

  ContentRow({required this.param, required this.value});
}

class DocumentGrid extends StatelessWidget {
  final List<MediaWithHead> medias;
  
  final Function()? ontap;
  final List<String> docs = [
    "RC",
    "Driving License",
    "Vehicle Front",
    "Vehicle Left",
    "Insurance",
    "Vehicle Video",
    "Vehicle Back",
    "Vehicle Right"
  ];

  DocumentGrid({super.key, required this.medias,this.ontap});

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 4 : 3;
    return Card(
      color: customGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Documents",
                ),
                SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: medias
                      .where(
                        (element) => element.url.isNotEmpty,
                      )
                      .length,
                  itemBuilder: (context, index) {
                    final media = medias
                        .where(
                          (element) => element.url.isNotEmpty,
                        )
                        .toList()[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            if (await canLaunchUrl(Uri.parse(media.url))) {
                              await launchUrl(Uri.parse(media.url));
                            } else {
                              throw 'Could not open the map.';
                            }
                          },
                          child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: media.head.contains("video")
                                    ? Colors.black
                                    : Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: media.head.contains("video")
                                  ? null
                                  : Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.network(
                                        media.url,
                                        cacheHeight: 80,
                                        cacheWidth: 80,
                                        fit: BoxFit.cover,
                                      ))),
                        ),
                        SizedBox(height: 4),
                        CustomText(
                          text: media.head,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: ontap,
              ),
            )
          ],
        ),
      ),
    ).paddingAll(10);
  }
}

class MaterialToggleSection extends StatelessWidget {
  final List<Map<String, dynamic>> materials = [
    {
      'label': 'Sand',
      'image': 'assets/images/sand.jpg',
      'subItems': ['m-sand', 'g-sand'],
    },
    {
      'label': 'Stone',
      'image': 'assets/images/stone.jpg',
      'subItems': ['6mm', '12mm', '20mm', '40mm'],
    },
    {
      'label': 'Cement',
      'image': 'assets/images/cement.jpeg',
      'subItems': ['Acc Cement'],
    },
    {
      'label': 'Bricks',
      'image': 'assets/images/bricks.jpg',
      'subItems': ['Solid', 'AAC', 'Red'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width * 0.35;
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 3 : 2;

    return Card(
      color: customGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Available Toggle",
                ),
                SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: materials.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2, // less wide, more height room
                  ),
                  itemBuilder: (context, index) {
                    final material = materials[index];
                    return Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              material['image'],
                              width: itemWidth * 0.4,
                              height: itemWidth * 0.4,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  material['label'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Flexible(
                                  child: SingleChildScrollView(
                                    physics: NeverScrollableScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: material['subItems']
                                          .map<Widget>((item) => Text(
                                                item,
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final Color customGreen = Color(0xFF557669);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: customGreen,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
      currentIndex: 3,
      onTap: (index) {},
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), label: "Orders"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet), label: "Earnings"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}

class MediaWithHead {
  final String head;
  final String url;

  MediaWithHead({required this.head, required this.url});
}
