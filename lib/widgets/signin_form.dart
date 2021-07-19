import 'package:flutter/material.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/providers/signin_validation_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool status = false;
    return Consumer<SignInValidation>(
      builder: (context, signInValidatonProvider, _) {
        return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Asking for E-mail
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 15),
                    child: TextFormField(
                        style: KtuTextStyles.regular,
                        decoration: InputDecoration(
                            labelText: 'e-mail',
                            labelStyle: KtuTextStyles.regular,
                            errorText: signInValidatonProvider.email.error),
                        controller: _emailController),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 30),
                    child: Text(signInValidatonProvider.emailtype,
                        style: KtuTextStyles.bold),
                  ),
                )
              ],
            ),

            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 15),

              // Asking for password
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Şifre',
                    labelStyle: KtuTextStyles.regular,
                    errorText: signInValidatonProvider.password.error),
                controller: _passwordController,
              ),
            ),

            // Giving space in between
            SizedBox(height: MediaQuery.of(context).size.height / 50),

            // This is a bad way of doing this.
            _isLoading == true
                ? Container(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator())
                : Container(),

            // Sign in button
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height / 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.green,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child:
                  Consumer<AuthProvider>(builder: (context, authProvider, _) {
                // ignore: deprecated_member_use
                return OutlineButton(
                  highlightedBorderColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  child: Text(
                    'Giriş Yap',
                    style: KtuTextStyles.regularWhite,
                  ),
                  onPressed: () async {
                    // Validate here, messy code, will fix later
                    signInValidatonProvider.setEmail(_emailController.text +
                        signInValidatonProvider.emailtype);
                    signInValidatonProvider
                        .setPassword(_passwordController.text);
                    if (signInValidatonProvider.password.error == null &&
                        signInValidatonProvider.email.error == null) {
                      _toggleLoading();
                      status = await authProvider.signIn(
                          _emailController.text +
                              signInValidatonProvider.emailtype,
                          _passwordController.text);

                      if (status == false) {
                        _toggleLoading();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Kullanıcı adı ya da şifre hatalı"),
                            duration: Duration(seconds: 5)));
                      }
                    }
                  },
                );
              }),
            ),

            // Giving space in between
            SizedBox(height: MediaQuery.of(context).size.height / 50),

            // Redirect to sign up
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height / 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color(0xFF555555),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              // ignore: deprecated_member_use
              child: OutlineButton(
                  highlightedBorderColor: Color(0xFF555555),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  child: Text(
                    'Kayıt ol',
                    style: KtuTextStyles.regularWhite,
                  ),
                  onPressed: () {
                    signInValidatonProvider.setToggleLoginLogout();
                  }),
            ),

            // Giving space in between
            SizedBox(height: MediaQuery.of(context).size.height / 100),

            // Forgot password button
            // Container(
            //   child: FlatButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => ForgotPasswordScreen()));
            //     },
            //     child:
            //         Text('Şifremi Unuttum', style: KtuTextStyles.regularBlue),
            //   ),
            // ),

            // Giving space in between
            SizedBox(height: MediaQuery.of(context).size.height / 100),
          ],
        );
      },
    );
  }
}
