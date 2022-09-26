import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import '../global/function/global_function.dart';

const bool _kAutoConsume = true;

const List<String> androidIDSKU = <String>[
  "android.test.purchased",
];

const List<String> iosIDSKU = <String>[
  "com.lazyhippodev.petdiary_lifetimepremium",
];

class InAppPurchasePage extends StatefulWidget {
  final bool showExpired;
  const InAppPurchasePage({Key key, this.showExpired}) : super(key: key);

  @override
  _InAppPurchasePageState createState() => _InAppPurchasePageState();
}

class _InAppPurchasePageState extends State<InAppPurchasePage> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  bool _isAvailable = false;
  bool isPending = false;
  List<String> _kProductIds;
  bool showExpired = false;

  @override
  void initState() {
    super.initState();

    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {});

    //판다 하는 코드 kProduct은 무저거 ARRAY 바아서
    if (Platform.isAndroid) {
      _kProductIds = androidIDSKU;
    }
    if (Platform.isIOS) {
      _kProductIds = iosIDSKU;
    }
    initStoreInfo();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    print("INAPP PURCHASE IS $isAvailable");
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
      });
      return;
    }
    ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());

    if (productDetailResponse.error != null) {
      setState(() {
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
      });
      return;
    }
    if (productDetailResponse.productDetails.isNotEmpty) {
      setState(() {
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
      });

      return;
    }
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    print("INAPP : HELLO");
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          //여기서 인앱 판매 성공

          deliverProduct(purchaseDetails, false);
        } else if (purchaseDetails.status == PurchaseStatus.restored) {
          //필수! 여기서 인앱 restore 성공

          deliverProduct(purchaseDetails, true);
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    });
  }

  handleError(IAPError error) {
    setState(() {
      isPending = false;
    });
  }

  showPendingUI() {
    setState(() {
      isPending = true;
    });
  }

  deliverProduct(
      PurchaseDetails purchaseDetails, bool showRestoreDialog) async {
    await _inAppPurchase.completePurchase(purchaseDetails);
    String uid = FirebaseAuth.instance.currentUser.uid;
    String productID = purchaseDetails.productID;
    String purchaseID = purchaseDetails.purchaseID;

    //그냥 재가 결제 어디가 제일 많은지 알고 싶어서 확인하는거
    String platform;
    if (Platform.isAndroid) {
      platform = "android";
    } else {
      platform = "ios";
    }

    //여기가 인앱 아이디 체크 하고 무슨변경할건지

    // switch (productID) {
    //   case "com.lazyhippodev.petdiary_lifetimepremium":
    //     await FirebaseFirestore.instance.collection("Users").doc(uid).update({
    //       "premium_status": true,
    //     });
    //     break;
    //   default:
    // }

    // 서버에 무주건 커피 복사 해야해요.
    // await FirebaseFirestore.instance
    //     .collection("LifeTimePurchases")
    //     .doc(uid)
    //     .set({
    //   "productID": productID,
    //   "purchaseID": purchaseID,
    //   "logDate": FieldValue.serverTimestamp(),
    //   "platform": platform,
    // });

    //결제 하자마자 앱 리뷰 확률 좋아요 며형
    // InAppReview inAppReview = InAppReview.instance;
    // if (await inAppReview.isAvailable()) {
    //   inAppReview.requestReview();
    // }

    setState(() {
      isPending = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //여기는 인앱 서버에러 UI
    if (!_isAvailable) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ));
    }

    //이거는 인앱 아이디들이 잘못되면 나오는 UI 아니면 ios 인앱 설청 오류
    if (_products.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(),
      );
    }

    //Pending UI
    if (isPending) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("결제가 진행중입니다."),
            LinearProgressIndicator(),
          ]),
        ),
      );
    }

    //이건 사용자가 구매 성공하면 바로 보여주는 UI
    // if (userProvider.userModel.premiumStatus) {
    //   return Scaffold(
    //     backgroundColor: Colors.white,
    //     body: Container(
    //         padding: EdgeInsets.all(24),
    //         width: double.infinity,
    //         child: Text(
    //           "Purchase done",
    //         )),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: InkWell(
                    onTap: () {
                      //저는 하나만 있어서 .first 했어요 근데 매형이 만약에 상품들이 많이 있으면 listview 써야 해요 아니면 아이템 마다 UI
                      //example
                      //_products.elementAt(0); 기본 프리미엄 1개월 구독
                      //_products.elementAt(1); 기본 프리미엄 6개월 구독
                      //이렇개 후~
                      purchaseProduct(_products.first);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor.fromHex("#253d5b"),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(
                            //   FontAwesomeIcons.crown,
                            //   color: Colors.yellow,
                            // ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Purchase Premium",
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Haven't received your purchase?\nTry restoring your purchases",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () {
                          //ios android 이 버턴이 필수 이에요.
                          _inAppPurchase.restorePurchases();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(25)),
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                "구입 항목 복원하기",
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  purchaseProduct(ProductDetails productDetails) {
    //use as is

    PurchaseParam purchaseParam;
    if (Platform.isAndroid) {
      purchaseParam = GooglePlayPurchaseParam(
        productDetails: productDetails,
        applicationUserName: null,
      );
    } else {
      purchaseParam = PurchaseParam(
        productDetails: productDetails,
        applicationUserName: null,
      );
    }
    _inAppPurchase.buyConsumable(
        purchaseParam: purchaseParam,
        autoConsume: _kAutoConsume || Platform.isIOS);
  }
}
