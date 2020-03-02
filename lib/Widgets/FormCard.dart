import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutterlocalauth/Screens/contacts.dart';
import 'package:local_auth/local_auth.dart';

class FormCard extends StatefulWidget {
  FormCard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FormCard createState() => _FormCard();
}

class _FormCard extends State<FormCard> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Login With Finger",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(
      () {
        if (isAuthorized) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactsScreen(),
            ),
          );
        } else {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: ScreenUtil.getInstance().setWidth(400),
      height: ScreenUtil.getInstance().setHeight(400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1000.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0),
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0),
        ],
      ),
      child: ClipOval(
        child: Container(
          width: 220.0,
          height: 220.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fingerbg.jfif'),
            ),
          ),
          child: FlatButton(
            padding: EdgeInsets.all(0.0),
            onPressed: () {
              _authorizeNow();
            },
            child: Image.asset('assets/finger.png'),
          ),
        ),
      ),
    );
  }
}
