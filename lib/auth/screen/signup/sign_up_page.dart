import 'package:dot_com/auth/screen/signup/sign_up_step1.dart';
import 'package:dot_com/auth/screen/signup/sign_up_step2.dart';
import 'package:dot_com/auth/screen/signup/sign_up_step3.dart';
import 'package:dot_com/auth/screen/signup/sign_up_step4.dart';
import 'package:dot_com/auth/viewModel/auth_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, viewModel, child) {
        viewModel.initializeLoader(context);
        return viewModel.page == 1
            ? SignUpPage1()
            : viewModel.page == 2
                ? SignUpPage2()
                : viewModel.page == 3
                    ? SignUpPage3()
                    : SignUpPage4();
      },
    );
  }
}
