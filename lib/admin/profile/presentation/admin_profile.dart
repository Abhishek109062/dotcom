import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../../components/formfields/formfields.dart";
import "../../../components/text_style.dart";
import "../../home/viewModel/user_admin_viewModel.dart";

class AdminProfile extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AdminProfile());
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  CustomFormFields _formFields = CustomFormFields();
  final usernameFocusNode = FocusNode();
  final usernameController = TextEditingController();
  final emailFocusNode = FocusNode();
  final emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    final state =  Provider.of<UserAdminViewModel>(context, listen: false);
    this.usernameController.text =
        state.user?.name ?? "";
    this.emailController.text = state.user?.email ?? "";
    super.initState();
  }

  void submitForm() {
    if(_formKey.currentState?.validate() ?? false){
      final userName = usernameController.text.trim();
      final email = emailController.text.trim();
      Provider.of<UserAdminViewModel>(context, listen: false).updateProfile(username: userName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDFA),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFDFA),
        leading: SizedBox.shrink(),
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Color(0xFFEE4540),
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "dot.",
                  style: Text_Style.small(
                      color: Color(0xFFEE4540), fontWeight: FontWeight.w700),
                ),
                Text(
                  "ComSale",
                  style: Text_Style.small(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Admin123",
                  style: Text_Style.large(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xFFEE4540), width: 1)),
                    child: Icon(
                      Icons.person,
                      color: Color(0xFFEE4540),
                    ))
              ],
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF3EDC8),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, 4),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_back),
                                  ],
                                )),
                            Flexible(
                                flex: 1,
                                child: Center(
                                    child: Text(
                                  "Welcome",
                                  style: Text_Style.medium(
                                      fontWeight: FontWeight.w500),
                                ))),
                            Flexible(
                                flex: 1,
                                child: Container(
                                  child: Text(""),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Admin123",
                          maxLines: 10,
                          style:
                              Text_Style.large(overflow: TextOverflow.ellipsis),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                _formFields.textFieldWithSpace(
                  controller: usernameController,
                  focusNode: usernameFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Username is required";
                      return null;
                    },
                ),
                SizedBox(
                  height: 20,
                ),
                _formFields.emailField(
                    controller: emailController,
                    focusNode: emailFocusNode,
                    ),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                    onPressed: () {
                      submitForm();
                    },
                    style: TextButton.styleFrom(
                        maximumSize: Size(MediaQuery.of(context).size.width * .6,44),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        backgroundColor: Color(0xffFC5D5D)),
                    child: Text(
                      "Save Changes",
                      style: Text_Style.medium(
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ))
              ],
            ),
          ),
        )),
      ),
    );
  }


}
