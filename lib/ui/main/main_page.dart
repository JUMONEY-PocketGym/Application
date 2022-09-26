import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_user_ios/global/function/global_function.dart';
import 'package:gym_user_ios/global/value/color.dart';
import 'package:lottie/lottie.dart';

import 'controller/main_body_controller.dart';
import 'pages/page01/betting/betting_main_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  MainBodyController mbc = Get.put(MainBodyController());
  AnimationController box01;
  AnimationController box02;
  @override
  void initState() {
    print("CHECK init");
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      box01.duration = const Duration(milliseconds: 320);
      box02.duration = const Duration(milliseconds: 300);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentBackPressTime;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          // for Android
          statusBarIconBrightness: Brightness.dark,
          // for iOS
          statusBarBrightness: Brightness.light),
      child: Container(
        // color: HexColor.fromHex("ffffff"),
        color: HexColor.fromHex("ff742c"),
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [
        //       HexColor.fromHex("#ffffff"),
        //       HexColor.fromHex("#ff742c"),
        //     ])),
        child: SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              if (mbc.menuPosition.value != 0) {
                mbc.changeIndex(0);
                return false;
              } else {
                DateTime now = DateTime.now();
                if (currentBackPressTime == null ||
                    now.difference(currentBackPressTime) >
                        Duration(seconds: 2)) {
                  currentBackPressTime = now;
                  showBotToast("뒤로 버튼을 한번 더 누르시면 종료됩니다.", Colors.black,
                      Alignment.bottomCenter, 2);
                  return false;
                }
              }

              return true;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Obx(() {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(child: mbc.animPageWidget.value
                            // FadeInUp(
                            //     from: 30.h,
                            //     controller: (c) => pageAnimateController = c,
                            //     child: mbc.animPageWidget.value),
                            ),
                        Container(
                          width: double.infinity,
                          height: 0.5.h,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                    Positioned(bottom: 0, left: 0, right: 0, child: bottomNav())
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNav() {
    return Container(
        width: double.infinity,
        height: 140.w,
        child: Stack(
          children: [
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: AnimatedContainer(
            //     duration: Duration(milliseconds: 300),
            //     width: double.infinity,
            //     height: mbc.isToggledMyQuest.value ? 120.h : 0,
            //     // color: Color.fromARGB(255, 255, 183, 0),
            //     color: Colors.white,
            //   ),
            // ),
            if (mbc.isUseAnimbutton.value && mbc.isToggledMyQuest.value) ...[
              Positioned(
                  left: 0,
                  top: 20.h,
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        box01.reverse();
                        box02.reverse();
                      } catch (e) {}
                      mbc.isToggledMyQuest.value = !mbc.isToggledMyQuest.value;
                      // await 0.5.delay();
                      if (mbc.isToggledMyQuest.value) {
                        box01.forward();
                        box02.forward();
                      }

                      await 0.1.delay();
                      mbc.changeIndex(2);
                    },
                    child: Container(
                      // duration: Duration(milliseconds: 300),
                      // width: mbc.isToggledMyQuest.value ? 150.w : 0,
                      width: 150.w,
                      height: 60.h,
                      // color: Colors.transparent,
                      child: Center(
                        child: JelloIn(
                          manualTrigger: true,
                          controller: (c) => box01 = c,
                          duration: Duration(milliseconds: 800),
                          // delay: Duration(milliseconds: 100),
                          child: Container(
                            width: 120.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#f9ede4"),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.w),
                                topRight: Radius.circular(30.w),
                                bottomLeft: Radius.circular(30.w),
                                bottomRight: Radius.circular(30.w),
                              ),
                              border: Border.all(
                                width: 1.w,
                                style: BorderStyle.solid,
                                color: HexColor.fromHex("#ff742c"),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(children: [
                              // Container(
                              //   width: 40.w,
                              //   height: 40.h,
                              // ),
                              // Container(
                              //     width: 1.w,
                              //     height: 50.h,
                              //     color: HexColor.fromHex("#ff742c")),
                              Expanded(
                                  child: Center(
                                child: Text(
                                  "운동 퀘스트",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      // color: HexColor.fromHex("#ff742c"),
                                      color: Colors.black,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                            ]),
                          ),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  right: 0,
                  top: 20.h,
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        box01.reverse();
                        box02.reverse();
                      } catch (e) {}
                      mbc.isToggledMyQuest.value = !mbc.isToggledMyQuest.value;
                      // await 0.5.delay();
                      if (mbc.isToggledMyQuest.value) {
                        box01.forward();
                        box02.forward();
                      }

                      await 0.1.delay();

                      Get.to(BettingMainPage(mainPosition: 1));
                    },
                    child: Container(
                      // duration: Duration(milliseconds: 200),
                      // width: mbc.isToggledMyQuest.value ? 150.w : 0,
                      width: 150.w,
                      height: 60.h,
                      color: Colors.transparent,
                      child: Center(
                        child: JelloIn(
                          manualTrigger: true,
                          controller: (c) => box02 = c,
                          duration: Duration(milliseconds: 800),
                          // delay: Duration(milliseconds: 100),
                          child: Container(
                            width: 120.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: HexColor.fromHex("#f9ede4"),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.w),
                                topRight: Radius.circular(30.w),
                                bottomLeft: Radius.circular(30.w),
                                bottomRight: Radius.circular(30.w),
                              ),
                              border: Border.all(
                                width: 1.w,
                                style: BorderStyle.solid,
                                color: HexColor.fromHex("#ff742c"),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(
                                      3, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(children: [
                              // Container(
                              //   width: 40.w,
                              //   height: 40.h,
                              // ),
                              // Container(
                              //     width: 1.w,
                              //     height: 50.h,
                              //     color: HexColor.fromHex("#ff742c")),
                              Expanded(
                                  child: Center(
                                child: Text(
                                  "미션 퀘스트",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      // color: HexColor.fromHex("#ff742c"),
                                      color: Colors.black,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
            Center(
              child: GestureDetector(
                onTap: () async {
                  // mbc.changeIndex(2);
                  // await 0.5.delay();
                  mbc.isUseAnimbutton(true);

                  try {
                    box01.reverse();
                    box02.reverse();
                  } catch (e) {}
                  mbc.isToggledMyQuest.value = !mbc.isToggledMyQuest.value;
                  // await 0.5.delay();
                  if (mbc.isToggledMyQuest.value) {
                    box01.forward();
                    box02.forward();
                  }
                },
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/img/ellipse_14.png",
                        width: 80.w,
                        height: 80.w,
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.w),
                        child: Image.asset(
                          "assets/img/my_quest.png",
                          width: 38.w,
                          height: 31.w,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 60.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/img/union.png"),
                    fit: BoxFit.fill,
                  )),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              // await pageAnimateController.reverse();
                              mbc.changeIndex(0);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10.w),
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Image.asset(
                                    'assets/img/ant_design_home_filled.png',
                                    width: 26.w,
                                    fit: BoxFit.fitWidth,
                                    color: mbc.menuPosition.value == 0
                                        ? Colors.white
                                        : Colors.white30,
                                  )),
                                  SizedBox(
                                    height: 2.w,
                                  ),
                                  Text("Home",
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        color: mbc.menuPosition.value == 0
                                            ? Colors.white
                                            : Colors.white30,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              // await pageAnimateController.reverse();
                              mbc.changeIndex(1);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10.w),
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Image.asset(
                                    'assets/img/bxs_category.png',
                                    width: 26.w,
                                    fit: BoxFit.fitWidth,
                                    color: mbc.menuPosition.value == 1
                                        ? Colors.white
                                        : Colors.white30,
                                  )),
                                  SizedBox(
                                    height: 2.w,
                                  ),
                                  Text("Feed",
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        color: mbc.menuPosition.value == 1
                                            ? Colors.white
                                            : Colors.white30,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: InkWell(
                        //     onTap: () async {
                        //       // await pageAnimateController.reverse();
                        //       mbc.changeIndex(2);
                        //     },
                        //     child: Container(
                        //       color: Colors.transparent,
                        //       child: Center(
                        //         child: mbc.menuPosition.value == 2
                        //             ? Image.asset(
                        //                 'assets/img/home_icon/selected_training_icon.png',
                        //                 width: 20.w,
                        //                 fit: BoxFit.fitWidth,
                        //               )
                        //             : Image.asset(
                        //                 'assets/img/home_icon/training_icon.png',
                        //                 width: 20.w,
                        //                 fit: BoxFit.fitWidth,
                        //               ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Spacer(),
                        SizedBox(
                          width: 30.w,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              // await pageAnimateController.reverse();
                              mbc.changeIndex(3);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10.w),
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Image.asset(
                                    'assets/img/clarity_note_solid.png',
                                    width: 26.w,
                                    fit: BoxFit.fitWidth,
                                    color: mbc.menuPosition.value == 3
                                        ? Colors.white
                                        : Colors.white30,
                                  )),
                                  SizedBox(
                                    height: 2.w,
                                  ),
                                  Text("Note",
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        color: mbc.menuPosition.value == 3
                                            ? Colors.white
                                            : Colors.white30,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              // await pageAnimateController.reverse();
                              mbc.changeIndex(4);
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10.w),
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Image.asset(
                                    'assets/img/healthicons_ui_user_profile.png',
                                    width: 26.w,
                                    fit: BoxFit.fitWidth,
                                    color: mbc.menuPosition.value == 4
                                        ? Colors.white
                                        : Colors.white30,
                                  )),
                                  SizedBox(
                                    height: 2.w,
                                  ),
                                  Text("My Page",
                                      style: TextStyle(
                                        fontSize: 8.sp,
                                        color: mbc.menuPosition.value == 4
                                            ? Colors.white
                                            : Colors.white30,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ]),
                ))
          ],
        ));
  }

  Widget bottomNavOrigin() {
    return Container(
      width: double.infinity,
      height: 120.h,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: HexColor.fromHex("fcfcfc"),
              height: 60.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        // await pageAnimateController.reverse();
                        mbc.changeIndex(0);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: mbc.menuPosition.value == 0
                              ? Image.asset(
                                  'assets/img/home_icon/selected_home_icon.png',
                                  width: 20.w,
                                  fit: BoxFit.fitWidth,
                                )
                              : Image.asset(
                                  'assets/img/home_icon/home_icon.png',
                                  width: 20.w,
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        // await pageAnimateController.reverse();
                        mbc.changeIndex(1);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: mbc.menuPosition.value == 1
                              ? Image.asset(
                                  'assets/img/home_icon/selected_feed_icon.png',
                                  width: 20.w,
                                  fit: BoxFit.fitWidth,
                                )
                              : Image.asset(
                                  'assets/img/home_icon/feed_icon.png',
                                  width: 20.w,
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: InkWell(
                  //     onTap: () async {
                  //       // await pageAnimateController.reverse();
                  //       mbc.changeIndex(2);
                  //     },
                  //     child: Container(
                  //       color: Colors.transparent,
                  //       child: Center(
                  //         child: mbc.menuPosition.value == 2
                  //             ? Image.asset(
                  //                 'assets/img/home_icon/selected_training_icon.png',
                  //                 width: 20.w,
                  //                 fit: BoxFit.fitWidth,
                  //               )
                  //             : Image.asset(
                  //                 'assets/img/home_icon/training_icon.png',
                  //                 width: 20.w,
                  //                 fit: BoxFit.fitWidth,
                  //               ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Expanded(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       mbc.changeIndex(2);
                  //     },
                  //     child: Container(
                  //       color: Colors.transparent,
                  //       width: double.infinity,
                  //       height: double.infinity,
                  //       child: Column(
                  //         children: [
                  //           Expanded(child: SizedBox()),
                  //           Text(
                  //             "운동 퀘스트",
                  //             style: TextStyle(
                  //                 color: mbc.menuPosition.value == 2
                  //                     ? HexColor.fromHex("#2733a0")
                  //                     : Colors.black,
                  //                 fontSize: 12.sp,
                  //                 fontWeight: FontWeight.w500),
                  //           ),
                  //           SizedBox(
                  //             height: 12.w,
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(child: SizedBox()),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        // await pageAnimateController.reverse();
                        mbc.changeIndex(3);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: mbc.menuPosition.value == 3
                              ? Image.asset(
                                  'assets/img/home_icon/selected_my_record_icon.png',
                                  width: 20.w,
                                  fit: BoxFit.fitWidth,
                                )
                              : Image.asset(
                                  'assets/img/home_icon/my_record_icon.png',
                                  width: 20.w,
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        // await pageAnimateController.reverse();
                        mbc.changeIndex(4);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: mbc.menuPosition.value == 4
                              ? Image.asset(
                                  'assets/img/home_icon/selected_my_page_icon.png',
                                  width: 20.w,
                                  fit: BoxFit.fitWidth,
                                )
                              : Image.asset(
                                  'assets/img/home_icon/my_page_icon.png',
                                  width: 20.w,
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // mbc.changeIndex(2);
                },
                child: Container(
                  width: 90.w,
                  height: 120.w,
                  // color: Colors.red[50],
                  child: Stack(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: Container(
                            width: 60.w,
                            height: 60.h,
                            color: mbc.menuPosition.value == 2
                                ? HexColor.fromHex("#2733a0")
                                : Colors.blueGrey[100],
                            // child: Column(
                            //   children: [
                            //     Expanded(child: SizedBox()),
                            //     Center(
                            //       child: Text(
                            //         "운동 퀘스트",
                            //         style: TextStyle(
                            //             color: Colors.white, fontSize: 11.sp),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 13.h,
                            //     )
                            //   ],
                            // ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 10.h,
                          left: 21.w,
                          child: Lottie.asset("assets/lottie/bo03.json",
                              width: 70.w))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
