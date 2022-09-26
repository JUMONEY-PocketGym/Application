import 'package:bot_toast/bot_toast.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'auth/kakao/kakao_auth_init.dart';
import 'global/function/global_function.dart';
import 'global/function/onesignal/init.dart';
import 'global/value/value.dart';
import 'loading.dart';
import 'themes.dart';
import 'ui/intro/splash_page.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

List<CameraDescription> cameras = <CameraDescription>[];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('ko', timeago.KoMessages());
  cameras = await availableCameras();
  await Firebase.initializeApp();
  if (defaultTargetPlatform == TargetPlatform.android) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }
  await kakaoInit();
  await M.init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

final routeObserver = RouteObserver();

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const String appName = "Squatt user";

    final botToastBuilder = BotToastInit();

    // Crashlytics를 firebase 연결 테스트할때 사용
    // if (crashlyticsCheck) FirebaseCrashlytics.instance.crash();

    return ScreenUtilInit(
        designSize: Size(390, 844),
        builder: (_, __) => Loading(
              child: GetMaterialApp(
                navigatorObservers: [routeObserver],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('ko', ''),
                ],
                title: appName,
                popGesture: true,
                opaqueRoute: true,
                defaultTransition: Transition.fadeIn,
                // defaultTransition: Transition.cupertino,
                enableLog: true,
                // opaqueRoute: Get.isOpaqueRouteDefault,
                // popGesture: Get.isPopGestureEnable,
                transitionDuration: Get.defaultTransitionDuration,
                theme: Themes().getAppTheme(),

                builder: (c, widget) {
                  var size = MediaQuery.of(c).size;
                  screenHeight = size.height;
                  screenWidth = size.width;

                  widget = botToastBuilder(context, widget);

                  return MediaQuery(
                    child: widget,
                    data: MediaQuery.of(c).copyWith(textScaleFactor: 1.0),
                  );
                },
                debugShowCheckedModeBanner: false,
                home: Provider<RouteObserver>(
                  // One way to make it avaliable through all your files and pages, but
                  // global variables and other means will work just fine as well.
                  create: (_) => routeObserver,
                  child: SplashPage(),
                ),
              ),
            ));
  }
}
