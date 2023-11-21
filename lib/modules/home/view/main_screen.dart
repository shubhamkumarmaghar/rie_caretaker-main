import 'dart:io';

import 'package:caretaker/modules/home/view/home_screen.dart';
import 'package:caretaker/modules/home/view/user_ticket_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../theme/custom_theme.dart';
import '../../../utils/const/app_urls.dart';
import '../../../utils/const/appbar_widget.dart';
import '../../../utils/view/rie_widgets.dart';
import '../../login_screen.dart';
import '../../ot_ticket_screen.dart';
import 'get_all_ticket.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  var _mainHeight;
  var _mainWidth;
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // String imageUrl = '';
  @override
  void initState() {
    // fetchUserDet();
    _initPackageInfo();
    super.initState();
  }
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
  // fetchUserDet() async {
  //   var sharedPreferences = await _prefs;
  //   imageUrl = sharedPreferences.getString(Constants.profileUrl).toString();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    _mainHeight = Get.height;
    _mainWidth = Get.width;
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);
    return Scaffold(
        appBar: appBarWidget('RENTISEASY ADMIN', '', context, false),
      bottomNavigationBar: Container(
        decoration:  BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CustomTheme.appTheme,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomAppBar(
          height: 50,
          color: CustomTheme.appTheme,
          shape: const CircularNotchedRectangle(),
          elevation: 18,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 40,
                  width: 30,
                  child: Center(
                      child: Container(
                          height: 26,
                          width: 26,
                          child: Icon(Icons.add_home_work_outlined))),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(GetAllTickets());
                    },
                    child: Container(
                        height: 26,
                        width: 26,
                        child: Icon(Icons.signpost_rounded))),
              ],
            ),
          ),
        ),
      ),
        body:   WillPopScope(
          onWillPop: () async {
            showExitDialog(context);
            return false;
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        GetStorage().read(Constants.userId).toString()??'Guest',
                        style: TextStyle(color: CustomTheme.appTheme,fontWeight: FontWeight.w600,fontSize: 14),
                      ),
                      Spacer(),
                      Text('V.C ${_packageInfo.version}',
                        style: TextStyle(color: CustomTheme.appTheme,fontWeight: FontWeight.w600,fontSize: 14),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: _gridInput(
                          hint: 'Show Tickets',
                          icon: Image.asset(
                            'assets/images/splash_logo.png',
                            height: 40,
                            width: 40,
                          ),
                          callBack: () {
                            Get.to(GetAllTickets());
                          }
                        ),
                      ),
                      Container(
                        child: _gridInput(
                          hint: 'Search Booking',
                          icon: Image.asset(
                            'assets/images/splash_logo.png',
                            height: 40, width: 40,

                            //color: CustomTheme.appTheme,
                          ),
                          callBack: () {
                          //  showSearchBookingDialog(context);

                            /*  Navigator.pop(context);
              Navigator.pushNamed(
              context,
              AppRoutes.searchBookingListPage,
              arguments: {
              'bookingId': '42985',
              'mobileNo': '',
              },
              ); */
                          },
                        ),
                      ),
                      Container(
                        child: _gridInput(
                          hint: 'Pending Payment',
                          icon: Image.asset(
                            'assets/images/splash_logo.png',
                            height: 40, width: 40,
                            //color: CustomTheme.appTheme,
                          ),
                          callBack: () =>{

                          }
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
       /* PersistentTabView(
          context,
          controller: controller,
          screens: _buildScreens(context),
          items: _navBarsItems(),
          onItemSelected: (int i) {
            debugPrint(i.toString());
          },
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: false,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style3, // Choose the nav bar style with this property.
        ),*/
      drawer: _getDrawer(context: context),
    );
  }

  List<Widget> _buildScreens(BuildContext context) {
    return [
      const MyHomePage(),
     // const UserTickets(),
      const GetAllTickets(),
     // const OtTicketsPage(),
      //const CallLogScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add_home_work_outlined),
        title: ("Available Rooms"),
        activeColorPrimary: CustomTheme.appTheme,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.signpost_rounded),
        title: ("User Ticket"),
        activeColorPrimary: CustomTheme.appTheme,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    /*  PersistentBottomNavBarItem(
        icon: const Icon(Icons.signpost_rounded),
        title: ("create Ticket"),
        activeColorPrimary: CustomTheme.appTheme,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),*/
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Icons.phone_callback_rounded),
      //   title: ("CALL LOGS"),
      //   activeColorPrimary: Constants.primaryColor,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),
    ];
  }

  Widget _getDrawer({
    required BuildContext context,
  }) {
    return Drawer(
      key: _drawerKey,
      backgroundColor: CustomTheme.white,
      child: Container(
        height: Get.height,
        child: ListView(
          children: [
            getTile(
              context: context,
              leading: Icon(
                Icons.logout,
                color: CustomTheme.appTheme,
                size: 20,
              ),
              title: 'Logout',
              onTap: () async {
                RIEWidgets.showLoaderDialog(
                    context: context, message: 'Logging out...');
                //SharedPreferenceUtil shared = SharedPreferenceUtil();
                //await Workmanager().cancelAll();
                //bool deletedAllValues = await shared.clearAll();
                GetStorage().erase();

                Navigator.of(context).pop();
                Get.offAll(LoginScreen());
              /*  if (deletedAllValues) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.loginPage, (route) => false);
                } else {
                  log('NOT ABLE TO DELETE VALUES FROM SP');
                }*/
              },
            ),
              getTile(
              context: context,
              leading: Icon(
                Icons.clear_all_rounded,
                color: CustomTheme.appTheme,
                size: 20,
              ),
              title: 'Get All Tickets',
              onTap: ()
               {
                 Get.to(GetAllTickets());
              },
            ),
          ],
        ),
      ),
    );
  }

  Future showExitDialog(BuildContext context) async {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Container(
        height: _mainHeight * 0.1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure to exit the app ?',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black),
            ),
            SizedBox(
              height: _mainHeight * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: _mainWidth * 0.2,
                  height: _mainHeight * 0.035,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                        )),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'No',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: _mainWidth * 0.2,
                  height: _mainHeight * 0.035,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            CustomTheme.appTheme),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                        )),
                    onPressed: () => exit(0),
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert; //WillPopScope(child: alert, onWillPop: ()async=>false);
      },
    );
  }
  Widget _gridInput(
      {required String hint, required Image icon, required Function callBack}) {
    return GestureDetector(
      onTap: () => callBack(),
      child: Container(
        width: _mainWidth * 0.33,
        height: _mainHeight * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            /*  Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: 8,
                    lightSource: LightSource.topLeft,
                    color: Colors.white
                ),
                child: Container(margin: EdgeInsets.all(10),child: icon,)
            ),*/
            icon,
            SizedBox(
              height: _mainHeight * 0.01,
            ),
            FittedBox(
              child: Text(hint,
                  style: TextStyle(
                    color: CustomTheme.appThemeContrast,
                    fontWeight: FontWeight.w500,fontFamily: 'Montserrat-Regular',
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTile(
      {required BuildContext context,
        required Icon leading,
        required String title,
        required Function onTap}) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 5),

      /*decoration: BoxDecoration(
          color: CustomTheme.appTheme.withAlpha(20),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),

      ),*/

      height: _mainHeight * 0.06,
      child: ListTile(
        leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: CustomTheme.appTheme.withAlpha(20),
                borderRadius: BorderRadius.circular(5)),
            child: leading),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        onTap: () => onTap(),
        trailing: Icon(
          Icons.arrow_right_outlined,
          color: Colors.grey,
        ),
      ),
    );
  }
}


