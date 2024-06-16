import 'package:dot_com/auth/screen/signup/sign_up_page.dart';
import 'package:dot_com/components/color.dart';
import 'package:dot_com/components/text_style.dart';
import 'package:flutter/material.dart';

class LoginPopup extends StatefulWidget {
  const LoginPopup({super.key});

  @override
  State<LoginPopup> createState() => _LoginPopupState();
}

class _LoginPopupState extends State<LoginPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.primaryThemeColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcome to',
              style: Text_Style.big(
                fontWeight: FontWeight.w700,
              ),
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'dot.',
                  style: Text_Style.large(color: Color(0xffFC5D5D), fontWeight: FontWeight.w700)),
              TextSpan(
                  text: 'ComSale', style: Text_Style.big(fontWeight: FontWeight.w700, fontSize: 25))
            ])),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                backgroundColor: AppColors.primarySecondThemeColor,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Create an Account',
                      style: Text_Style.small(
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'or',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Log in', style: Text_Style.small(color: Color(0xffFC5D5D))),
          ],
        ),
      ),
    );
  }
}
