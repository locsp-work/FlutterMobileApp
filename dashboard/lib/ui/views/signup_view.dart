import 'package:dashboardadmin/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:dashboardadmin/ui/widgets/Container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dashboardadmin/ViewsModel/signup_view_model.dart';
import 'package:dashboardadmin/ui/views/login_view.dart';
import 'package:dashboardadmin/ui/widgets/busy_button.dart';
import 'package:dashboardadmin/ui/widgets/input_field.dart';
import 'package:dashboardadmin/ui/widgets/expansion_list.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    Widget _loginAccountLabel() {
      return Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginView()));
              },
              child: Text(
                'Login',
                style: TextStyle(
                    color: Color(0xfff79c4f),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      );
    }

    Widget _title() {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'D',
            style: GoogleFonts.mcLaren(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10),
            ),
            children: [
              TextSpan(
                text: 'as',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              TextSpan(
                text: 'hBoa',
                style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
              ),
              TextSpan(
                text: 'rd',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ]),
      );
    }

    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModelBuilder:()=> SignUpViewModel(),
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
          body: SingleChildScrollView(
              child:Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        verticalSpaceMassive,
                        _title(),
                        verticalSpaceSmall,
                        InputField(
                          placeholder: 'Full Name',
                          controller: fullNameController,
                        ),
                        verticalSpaceSmall,
                        InputField(
                          placeholder: 'Email',
                          controller: emailController,
                        ),
                        verticalSpaceSmall,
                        InputField(
                          placeholder: 'Password',
                          password: true,
                          controller: passwordController,
                          additionalNote: 'Password has to be a minimum of 6 characters.',
                        ),
                        verticalSpaceSmall,
                        ExpansionList<String>(
                            items: ['Admin', 'User'],
                            title: model.selectedRole,
                            onItemSelected: model.setSelectedRole),
                        verticalSpaceSmall,
                        _loginAccountLabel(),
                        verticalSpaceSmall,
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BusyButton(
                              title: 'Sign Up',
                              busy: model.busy,
                              onPressed: () {
                                model.signUp(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    fullName: fullNameController.text);
                              },
                            )
                          ],
                        ),
                        verticalSpaceSmall
                      ],
                    ),
                  ),
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .15,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BContainer())
                ],
              )
          )
      ),
    );
  }
}
