
import 'package:dashboardadmin/ViewsModel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dashboardadmin/ui/views/signup_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dashboardadmin/ui/widgets/Container.dart';
import 'package:dashboardadmin/ui/widgets/busy_button.dart';
import 'package:dashboardadmin/ui/widgets/input_field.dart';
import 'package:dashboardadmin/ui/shared/ui_helpers.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
class LoginView extends StatelessWidget {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    @override
    Widget build(BuildContext context) {

      Widget _createAccountLabel() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Don\'t have an account ?',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpView()));
                },
                child: Text(
                  'Register',
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

      return ViewModelProvider<LoginViewModel>.withConsumer(
        disposeViewModel: false,
        viewModelBuilder: ()=>LoginViewModel(),
        builder: (context,model,child)=>Scaffold(
              body: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              verticalSpaceMassive,
                              _title(),
                              verticalSpaceLarge,
                              Column(
                                children: <Widget>[
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
                                  BusyButton(
                                    title: 'Login',
                                    busy: model.busy,
                                    onPressed: () {
                                      model.login(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ).whenComplete(() =>
                                        {
                                          emailController.clear(),
                                          passwordController.clear(),
                                        }
                                      );
                                    },
                                  ),
                                ],
                              ),
                              verticalSpaceSmall,
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.centerRight,
                                child: Text('Forgot Password ?',
                                    style:
                                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              ),
                              verticalSpaceMedium,
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _createAccountLabel(),
                        ),
                        Positioned(
                            top: -MediaQuery.of(context).size.height * .15,
                            right: -MediaQuery.of(context).size.width * .4,
                            child: BContainer())
                      ],
                    ),
                  )
              )
          ),
      );
    }
}

