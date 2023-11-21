import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:getwidget/getwidget.dart';

import '../theme/custom_theme.dart';
import '../utils/const/app_urls.dart';
import '../utils/const/appbar_widget.dart';
import '../utils/const/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _MyProfileState();
}

class _MyProfileState extends State<ProfileScreen> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  TextEditingController askQController = TextEditingController();
  String userId = 'guest';
  String userName = 'guest';
  String userEmail = 'guest';
  String userPhone = 'guest';
  String profileImg = '';

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    fetchLocal();
    _initPackageInfo();
    super.initState();
  }

  Widget infoTile(String title) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: CustomTheme.white),
    );
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  Widget rowText(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontFamily: Constants.fontsFamily,
                color: Colors.black,
                fontSize: 13),
          ),
          Text(
            value,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: Constants.fontsFamily,
                color: Colors.grey,
                fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget circleIcon(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GFButton(
        onPressed: () {},
        text: text,
        color: color,
        type: GFButtonType.outline,
      ),
    );
  }

  Widget columnVersionText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Version",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15, color: Colors.grey),
        ),
        height(0.03),
        infoTile(packageInfo.version),
      ],
    );
  }

  void fetchLocal() async {
   // SharedPreferences sharedPreferences = await prefs;

      if ((GetStorage(Constants.userId) != null) &&
          GetStorage().read(Constants.userId) != 'guest' ) {
        userId = GetStorage().read(Constants.userId).toString();
        userName = GetStorage().read(Constants.usernamekey).toString();
        userEmail = GetStorage().read(Constants.usernamekey).toString();
        userPhone = GetStorage().read(Constants.phonekey).toString();
        profileImg = GetStorage().read(Constants.profileUrl).toString();
      }
     else {
      userId = 'guest';
      userName = 'guest';
      userEmail = 'guest';
      userPhone = 'guest';
    }
    setState(() {});
  }

  Widget profileView() {
    return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // height(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 35,
                        width: 35,
                        child: FloatingActionButton(
                          heroTag: UniqueKey(),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                const SizedBox(
                                  height: 75,
                                  width: 75,
                                ),
                                // Container(
                                //   decoration: const BoxDecoration(
                                //       shape: BoxShape.circle),
                                //   child: iconWidget('user_vec', 50, 50),
                                // )
                                // CircleAvatar(
                                //   radius: 48.0,
                                //   backgroundImage:
                                //       AssetImage('assets/images/user_vec.png'),
                                // )
                                imgLoadWid(AppUrls.imagesRootUrl + profileImg,
                                    userVec, 70, 70, BoxFit.cover, 100)
                                // CachedNetworkImage(
                                //   imageUrl:
                                //       AppConfig.imagesRootUrl + profileImg,
                                //   imageBuilder: (context, imageProvider) =>
                                //       Container(
                                //     width: 70,
                                //     height: 70,
                                //     decoration: BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       image: DecorationImage(
                                //           image: imageProvider,
                                //           fit: BoxFit.cover),
                                //     ),
                                //   ),
                                //   placeholder: (context, url) => loading(),
                                //   errorWidget: (context, url, error) =>
                                //       const CircleAvatar(
                                //     radius: 48.0,
                                //     backgroundImage: AssetImage(
                                //         'assets/images/user_vec.png'),
                                //   ),
                                // ),
                              ],
                            ),
                            Text(
                              userName,
                              style: TextStyle(
                                  fontFamily: Constants.fontsFamily,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              'Phone :$userPhone',
                              style: TextStyle(
                                  fontFamily: Constants.fontsFamily,
                                  color: Colors.black,
                                  fontSize: 13),
                            ),
                            Text(
                              'Email : $userEmail',
                              style: TextStyle(
                                  fontFamily: Constants.fontsFamily,
                                  color: Colors.black,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        width: 35,
                        child: FloatingActionButton(
                          heroTag: UniqueKey(),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            AppUrls.alertDialog(
                                context, 'LOG OUT', '* Do you want Logout *');
                          },
                          child: const Icon(
                            Icons.exit_to_app_rounded,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //height(15),
                ]),
          ),
        ));
  }

  // Widget expandItemFaq(String image, String title) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 5),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         iconWidget(image, 30, 30),
  //         width(30),
  //         Text(
  //           title,
  //           style: TextStyle(fontFamily: Constants.fontsFamily, fontSize: 16),
  //         ),
  //         const Spacer(),
  //         IconButton(
  //             onPressed: () {
  //               Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => const FaqScreen()));
  //             },
  //             icon: const Icon(
  //               Icons.arrow_right_rounded,
  //               size: 30,
  //               color: Colors.grey,
  //             ))
  //       ],
  //     ),
  //   );
  // }

  // Widget expandItemWeb(String image, String title, String subTitle) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 5),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         iconWidget(image, 30, 30),
  //         width(30),
  //         Text(
  //           title,
  //           style: TextStyle(fontFamily: Constants.fontsFamily, fontSize: 16),
  //         ),
  //         const Spacer(),
  //         IconButton(
  //             onPressed: () {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => WebViewPage(
  //                             title: title,
  //                             uri: subTitle,
  //                           )));
  //             },
  //             icon: const Icon(
  //               Icons.arrow_right_rounded,
  //               size: 30,
  //               color: Colors.grey,
  //             ))
  //       ],
  //     ),
  //   );
  // }

  Widget expandItemFollowUs(String image, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: iconWidget(image, 30, 30),
          title: Text(
            title,
            style: TextStyle(fontFamily: Constants.fontsFamily),
          ),
          expandedAlignment: Alignment.topLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.all(5),
          tilePadding: const EdgeInsets.all(5),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                circleIcon('Facebook', Colors.indigoAccent),
                circleIcon('Twitter', Colors.blue),
                circleIcon('Instagram', Colors.pink)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget expandItemContactUs(String image, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: iconWidget(image, 30, 30),
          title: Text(
            title,
            style: TextStyle(fontFamily: Constants.fontsFamily),
          ),
          expandedAlignment: Alignment.topLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.all(5),
          tilePadding: const EdgeInsets.all(5),
          children: [
            rowText('Customer call service', AppUrls.phone),
          ],
        ),
      ),
    );
  }

  // Widget tenantWidget(String image, String title) {
  //   return (vendorId != 'null' && vendorId != 'guest')
  //        FutureBuilder<List<TenantModel>>(
  //           future: fetchTenantApi('${AppConfig.tenant}?id=$vendorId'),
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               if (snapshot.data!.isNotEmpty) {
  //                 return expandItemRent(image, title, snapshot.data!.first);
  //               } else {
  //                 return const Text('');
  //               }
  //             } else if (snapshot.hasError) {
  //               return const Text('');
  //             }
  //             return loading();
  //           })
  //       : const Text('');
  // }

  // Widget expandItemRent(String image, String title, TenantModel tenantModel) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 10, right: 10),
  //     child: Theme(
  //       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
  //       child: ExpansionTile(
  //         leading: iconWidget(image, 30, 30),
  //         title: Text(
  //           title,
  //           style: TextStyle(fontFamily: Constants.fontsFamily),
  //         ),
  //         expandedAlignment: Alignment.topLeft,
  //         expandedCrossAxisAlignment: CrossAxisAlignment.start,
  //         childrenPadding: const EdgeInsets.all(5),
  //         tilePadding: const EdgeInsets.all(5),
  //         children: [
  //           rowText('Property name', tenantModel.propertyModel!.name),
  //           rowText('House  Id', tenantModel.houseId),
  //           rowText('Monthly Rent',
  //               '${Constants.currency}.${tenantModel.rentalAmt}'),
  //           rowText('House Type', tenantModel.bhkType),
  //           rowText('Pay Date', getFormatedDate(tenantModel.payDate)),
  //           rowText(
  //               'Pay Status (This month)', tenantModel.payStatus.split('T')[0]),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: screenWidth,
          height: screenHeight,
        ),
        Positioned(
            top: 30,
            child: SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Column(children: [
                      profileView(),
                      height(0.010),
                      Card(
                        child: Column(children: [
                          // Visibility(
                          //     visible: isTenant &&
                          //         (vendorId != 'null' || vendorId != 'guest'),
                          //     child: tenantWidget('rent', 'Rent Details')),
                          //Visibility(visible: isTenant, child: const Divider()),
                          expandItemContactUs('contact_us', 'Contact Info'),
                          const Divider(),
                          expandItemFollowUs('follow_us', 'Follow Us'),
                          //const Divider(),
                          // expandItemWeb(
                          //     'web_site', 'Website', 'https://rentiseazy.com/'),
                          // const Divider(),
                          //expandItemFaq('faq', 'FAQ '),
                        ]),
                      ),
                      height(0.020),
                      columnVersionText()
                    ]),
                  ),
                )))
      ]),
    );
  }
}
