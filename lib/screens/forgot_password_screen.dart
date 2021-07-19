// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ktu_sosyal/providers/signin_validation_provider.dart';
// import 'package:ktu_sosyal/theme.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:ktu_sosyal/theme.dart';

// //TODO: clean up code, too much indentation

// class ForgotPasswordScreen extends StatefulWidget {
//   @override
//   _ForgotPasswordScreen createState() => _ForgotPasswordScreen();
// }

// class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
//   final List<bool> isSelected = [true, false];
//   String email = "";
//   var _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height / 1.5,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.elliptical(100, 100),
//                         bottomRight: Radius.elliptical(100, 100),
//                       ),
//                       gradient: KtuColors.gradientLogin),
//                 ),
//                 Column(
//                   children: [
//                     _buildKtuLogo(),
//                     SizedBox(height: MediaQuery.of(context).size.height / 30),
//                     Consumer<SignInValidation>(
//                       builder: (context, signInValidationProvider, _) {
//                         return Padding(
//                           // Why does padding have to be const?
//                           padding: EdgeInsets.only(
//                               top: MediaQuery.of(context).size.height / 40.0),
//                           child: Container(
//                             // If we're in the sign in form, make the box smaller!
//                             height: signInValidationProvider
//                                         .toggleLoginLogout ==
//                                     false
//                                 ? (MediaQuery.of(context).size.height / 1.8)
//                                 : (MediaQuery.of(context).size.height / 1.6),
//                             width: MediaQuery.of(context).size.width / 1.3,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20.0),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black26,
//                                   spreadRadius: 8,
//                                   blurRadius: 10,
//                                   offset: Offset(0, 3),
//                                 ),
//                               ],
//                             ),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   Form(
//                                     key: _formKey,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(30.0),
//                                       child: Column(
//                                         children: <Widget>[
//                                           Text(
//                                             "Sıfırlama linki gönderilecek mail adresini giriniz.",
//                                             style: TextStyle(
//                                                 color: KtuColors.ktuLightBlue,
//                                                 fontSize: 15.0,
//                                                 fontFamily: 'Rubik'),
//                                           ),
//                                           SizedBox(
//                                               height: MediaQuery.of(context)
//                                                       .size
//                                                       .height /
//                                                   30),
//                                           TextFormField(
//                                             style: KtuTextStyles.regular,
//                                             decoration: InputDecoration(
//                                                 labelText: 'e-mail',
//                                                 labelStyle:
//                                                     KtuTextStyles.regular),
//                                             validator: (value) {
//                                               if (value.isEmpty) {
//                                                 return "Lütfen mailinizi giriniz";
//                                               } else {
//                                                 email = value;
//                                               }
//                                               return null;
//                                             },
//                                           ),
//                                           SizedBox(
//                                               height: MediaQuery.of(context)
//                                                       .size
//                                                       .height /
//                                                   40),
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 20, right: 20),
//                                             child: Container(
//                                               width: MediaQuery.of(context)
//                                                       .size
//                                                       .width /
//                                                   3.5,
//                                               height: MediaQuery.of(context)
//                                                       .size
//                                                       .height /
//                                                   20,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(20.0),
//                                                 color: Colors.green,
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                     color: Colors.black12,
//                                                     spreadRadius: 1,
//                                                     blurRadius: 4,
//                                                     offset: Offset(0, 3),
//                                                   )
//                                                 ],
//                                               ),
//                                               child: OutlineButton(
//                                                   highlightedBorderColor:
//                                                       Colors.green,
//                                                   shape: RoundedRectangleBorder(
//                                                       borderRadius:
//                                                           new BorderRadius
//                                                               .circular(20.0)),
//                                                   child: Text(
//                                                     'Gönder',
//                                                     style: KtuTextStyles
//                                                         .regularWhite,
//                                                   ),
//                                                   onPressed: () {
//                                                     if (_formKey.currentState
//                                                         .validate()) {
//                                                       FirebaseAuth.instance
//                                                           .sendPasswordResetEmail(
//                                                               email: email)
//                                                           .then((value) => print(
//                                                               "Mailini kontrol et!"));

//                                                       Navigator.pop(context);
//                                                     }
//                                                   }),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildKtuLogo() {
//     return Padding(
//       padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
//       child: Align(
//         child: SvgPicture.asset(
//           LogoConstants.ktuLogo,
//           height: MediaQuery.of(context).size.height / 8,
//         ),
//         alignment: Alignment.center,
//       ),
//     );
//   }
// }
