import 'package:flutter/material.dart';
import 'package:ktu_sosyal/providers/auth_provider.dart';
import 'package:ktu_sosyal/providers/signin_validation_provider.dart';
import 'package:ktu_sosyal/theme.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();

  String errorText = "";
  var _isLoading;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _fieldOfStudyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInValidation>(
      builder: (context, signInValidatonProvider, _) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 15),
              // Asking for name of the user
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Ad',
                    labelStyle: KtuTextStyles.regular,
                    errorText: signInValidatonProvider.name.error),
                controller: _nameController,
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 15),
              // Asking for surname of the user
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Soyad',
                    labelStyle: KtuTextStyles.regular,
                    errorText: signInValidatonProvider.surname.error),
                controller: _surnameController,
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 15),
              // Asking for fielOfStudy of the user
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Bölüm',
                    labelStyle: KtuTextStyles.regular,
                    errorText: signInValidatonProvider.fieldOfStudy.error),
                controller: _fieldOfStudyController,
              ),
            ),

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

            // Giving space in between maybe value changed
            SizedBox(height: MediaQuery.of(context).size.height / 10000),

            // This is a bad way of doing this.
            _isLoading == true ? CircularProgressIndicator() : Container(),
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height / 20,
              child: Text(errorText),
            ),
            // Sign up button
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
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  // ignore: deprecated_member_use
                  return OutlineButton(
                    highlightedBorderColor: Color(0xFF555555),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    child: Text(
                      'Kayıt ol',
                      style: KtuTextStyles.regularWhite,
                    ),
                    onPressed: () async {
                      signInValidatonProvider.setName(_nameController.text);
                      signInValidatonProvider
                          .setSurname(_surnameController.text);
                      signInValidatonProvider
                          .setFieldOfStudy(_fieldOfStudyController.text);
                      signInValidatonProvider.setEmail(_emailController.text +
                          signInValidatonProvider.emailtype);
                      signInValidatonProvider
                          .setPassword(_passwordController.text);

                      String s = await authProvider.signUp(
                          _nameController.text,
                          _surnameController.text,
                          _fieldOfStudyController.text,
                          _emailController.text +
                              signInValidatonProvider.emailtype,
                          _passwordController.text);

                      if (signInValidatonProvider.password.error == null &&
                          signInValidatonProvider.email.error == null) {
                        setState(() {
                          errorText = s;
                        });
                      }
                    },
                  );
                },
              ),
            ),

            // Giving space in between
            SizedBox(height: MediaQuery.of(context).size.height / 100),

            // Redirect to sign in
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
                highlightedBorderColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                child: Text(
                  'Geri',
                  style: KtuTextStyles.regularWhite,
                ),
                onPressed: () {
                  signInValidatonProvider.setToggleLoginLogout();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
