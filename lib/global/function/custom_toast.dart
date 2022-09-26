import 'package:flutter/material.dart';
import 'package:gym_user_ios/global/value/value.dart';

class CustomBotToast extends StatelessWidget {
  final fun;
  final text;
  final Color color;

  const CustomBotToast({
    Key key,
    this.fun,
    this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: screenWidth,
      child: Card(
        shadowColor: Colors.indigo[300],
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: color,
        margin: EdgeInsets.all(16),
        child: InkWell(
          onTap: fun,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Center(
                      child: Text(text,
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "noto")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
