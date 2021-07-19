import 'package:flutter/material.dart';
import 'package:ktu_sosyal/providers/signin_validation_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktu_sosyal/widgets/signin_form.dart';
import 'package:ktu_sosyal/widgets/signup_form.dart';
import 'package:provider/provider.dart';

class SignInSignUp extends StatefulWidget {
  @override
  _SignInSignUpState createState() => _SignInSignUpState();
}

class _SignInSignUpState extends State<SignInSignUp> {
  final List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(100, 100),
                      bottomRight: Radius.elliptical(100, 100),
                    ),
                    gradient: KtuColors.gradientLogin,
                  ),
                ),
                Column(
                  children: [
                    _buildKtuLogo(),
                    _buildToggleButtons(),
                    // The box that containst the forms
                    Consumer<SignInValidation>(
                      builder: (context, signInValidationProvider, _) {
                        return Padding(
                          // Why does padding have to be const?
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 40.0),
                          child: Container(
                            // If we're in the sign in form, make the box smaller!
                            height: signInValidationProvider
                                        .toggleLoginLogout ==
                                    false
                                ? (MediaQuery.of(context).size.height / 1.8)
                                : (MediaQuery.of(context).size.height / 1.6),
                            width: MediaQuery.of(context).size.width / 1.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 8,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  signInValidationProvider.toggleLoginLogout ==
                                          false
                                      ? SignInForm()
                                      : SignUpForm(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKtuLogo() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
      child: Align(
        child: SvgPicture.asset(
          LogoConstants.ktuLogo,
          height: MediaQuery.of(context).size.height / 8,
        ),
        alignment: Alignment.center,
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        height: 35.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: KtuColors.ktuDarkBlue),
        child: Consumer<SignInValidation>(
          builder: (context, signInValidationProvider, _) {
            return ToggleButtons(
              borderRadius: BorderRadius.circular(20.0),
              selectedColor: Colors.black,
              fillColor: KtuColors.ktuWhite,
              renderBorder: false,
              color: Colors.white,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text('Öğrenci', style: KtuTextStyles.regular),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text('Akademisyen', style: KtuTextStyles.regular),
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  if (index == 0) {
                    isSelected[index] = true;
                    isSelected[index + 1] = false;
                  } else {
                    isSelected[index] = true;
                    isSelected[index - 1] = false;
                  }
                  signInValidationProvider.setEmailType(index);
                });
              },
              isSelected: isSelected,
            );
          },
        ),
      ),
    );
  }
}
