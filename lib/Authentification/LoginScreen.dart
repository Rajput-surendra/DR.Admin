import 'dart:convert';
import 'dart:developer';

import 'package:doctoradmin/Helper/Color.dart';
import 'package:doctoradmin/Home/home_screen.dart';
import 'package:doctoradmin/Screens/Update_password.dart';
import 'package:doctoradmin/api/api_services.dart';
import 'package:doctoradmin/api/model/login_response.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloader = false;

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginResponse? logInResponse;

  int selectedIndex = 1;
  bool _isObscure = true;
  String? token;

  // String? password,
  //     mobile,
  //     username,
  //     email,
  //     id,
  //     mobileno;

  loginwitMobile() async {
    isloader = true;
    setState(() {});
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final headers = <String, String>{
      'Cookie': 'ci_session=b13e618fdb461ccb3dc68f327a6628cb4e99c184'
    };
    final body = <String, String>{
      "mobile": mobileController.text,
      "password": passwordController.text,
      "fcm_id": token ?? 'asdfasdfasdfasdfasdfasdfasffasdfasdfasdf'
    };
    log('${body}');

    final response = await http.post(Uri.parse(ApiService.adminBaseUrl),
        body: body, headers: headers);

    // final data = jsonDecode(response.body);
    // success = data["result"] == "Success";

    if (response.statusCode == 200) {
      isloader = false;

      final finalResult = LoginResponse.fromJson(jsonDecode(response.body));

      setState(() {
        logInResponse = finalResult;
        print('__________${logInResponse?.data?.first.username}_____________');
      });
      if (logInResponse?.error == false) {
        preferences.setBool('isLogin', true);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${logInResponse?.message}')));

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        isloader = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${logInResponse?.message} ...!  ')));
        setState(() {});
        //Fluttertoast.showToast(msg: "${jsonresponse['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    inIt();

    super.initState();
  }

  inIt() async {
    try {
      token = await FirebaseMessaging.instance.getToken();
      print("-----------token:-----${token}");
    } on FirebaseException {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colors.primary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.75),
                child: Container(
                    height: MediaQuery.of(context).size.height / 3.0,
                    child: Image.asset(
                      "assets/splash/splashimages.png",
                      scale: 6.2,
                    )),
              ),
              Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                      color: colors.whiteTemp,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  height: MediaQuery.of(context).size.height / 1.59,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Admin Login",
                        style: TextStyle(
                            color: colors.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      /*Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: 1,
                            fillColor: MaterialStateColor.resolveWith(
                                    (states) =>  colors.secondary),
                            activeColor:  colors.secondary,
                            groupValue: _value,
                            onChanged: (int? value) {
                              setState(() {
                                _value = value!;
                                isMobile = false;
                              });
                            },
                          ),
                          const Text(
                            "Email",
                            style: TextStyle(
                                color: colors.secondary, fontSize: 21),
                          ),
                          */ /*SizedBox(height: 10,),
                          Radio(
                              value: 2,
                              fillColor: MaterialStateColor.resolveWith(
                                      (states) => colors.secondary),
                              activeColor:   colors.secondary,
                              groupValue: _value,
                              onChanged: (int? value) {
                                setState(() {
                                  _value = value!;
                                  isMobile = true;
                                });
                              }),*/ /*
                          // SizedBox(width: 10.0,),
                          */ /*const Text(
                            "Mobile No",
                            style: TextStyle(
                                color:  colors.secondary, fontSize: 21),
                          ),*/ /*
                        ],
                      ),*/
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20, left: 20, right: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 4,
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: colors.whiteTemp,
                                    //Theme.of(context).colorScheme.gray,
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      maxLength: 10,
                                      keyboardType: TextInputType.number,

                                      controller: mobileController,
                                      validator: (msg) {
                                        if (msg!.isEmpty) {
                                          return "Please Enter Valid Mobile No.!";
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        counterText: "",
                                        contentPadding: EdgeInsets.only(
                                            left: 15, top: 15),
                                        hintText: "Mobile Number",
                                        hintStyle: TextStyle(
                                            color: colors.secondary),
                                        // labelText: "Enter Email id",
                                        prefixIcon: Icon(
                                          Icons.call,
                                          color: colors.secondary,
                                          size: 24,
                                        ),
                                        // border: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 4,
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: colors.whiteTemp),
                                  child: Center(
                                    child: TextFormField(
                                      obscureText: _isObscure,
                                      controller: passwordController,
                                      // obscureText: _isHidden ? true : false,
                                      keyboardType: TextInputType.text,
                                      validator: (msg) {
                                        if (msg!.isEmpty) {
                                          return "Please Enter Valid Password!";
                                        }
                                      },
                                      // maxLength: 10,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: colors.secondary),
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: colors.secondary,
                                            size: 24,
                                          ),
                                          suffixIcon: IconButton(
                                              icon: Icon(
                                                _isObscure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: colors.secondary,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscure = !_isObscure;
                                                });
                                              })),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              /*Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdatePassword()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                            color: colors.secondary,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),*/
                              InkWell(
                                  onTap: () {

                                    if (_formKey.currentState!.validate()) {

                                      setState(() {
                                        isloader = true;
                                      });
                                      loginwitMobile();
                                    } else {
                                      /*ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  '"Please Enter Correct Credentials!!"')));*/

                                      /*Fluttertoast.showToast(
                                          msg:
                                          "Please Enter Correct Credentials!!");*/
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        color: colors.secondary),
                                    child: isloader == true
                                        ? Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Center(
                                            child: Text("Sign In",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color:
                                                        colors.whiteTemp))),
                                  )),
                              /*Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Dont have an account?",style: TextStyle(color: colors.blackTemp,fontSize: 14,fontWeight: FontWeight.bold),),
                                  TextButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                                  }, child: Text("SignUp",style: TextStyle(color: colors.secondary,fontSize: 16,fontWeight: FontWeight.bold),))
                                ],
                              )*/
                            ],
                          ),
                        ),
                      ),
                    ],
                  )

                  // Column(
                  //   children: [
                  //     SizedBox(height: 20,),
                  //     Text("Login",style: TextStyle(color: colors.blackTemp,fontSize: 30,fontWeight: FontWeight.w500),),
                  //     SizedBox(height: 30,),
                  //     Container(
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           InkWell(
                  //             onTap: () {
                  //               setState(() {
                  //                 selectedIndex = 1;
                  //               });
                  //             },
                  //             child: Container(
                  //               child: Row(
                  //                 children: [
                  //                   Container(
                  //                     height: 20,
                  //                     width: 20,
                  //                     padding: EdgeInsets.all(3),
                  //                     decoration: BoxDecoration(
                  //                         borderRadius: BorderRadius.circular(100),
                  //                         border: Border.all(
                  //                             color: selectedIndex == 1
                  //                                 ? colors.secondary
                  //                                 :colors.secondary,
                  //                             width: 2)),
                  //                     child: Container(
                  //                       decoration: BoxDecoration(
                  //                         borderRadius: BorderRadius.circular(100),
                  //                         color: selectedIndex == 1
                  //                             ? colors.secondary
                  //                             : Colors.transparent,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 10,
                  //                   ),
                  //                   Text(
                  //                     "Email",
                  //                     style: TextStyle(
                  //                         color:colors.secondary,
                  //                         fontSize: 14,
                  //                         fontWeight: FontWeight.w500),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //           InkWell(
                  //             onTap: () {
                  //               setState(() {
                  //                 selectedIndex = 2;
                  //               });
                  //             },
                  //             child: Container(
                  //               child: Row(
                  //                 children: [
                  //                   Container(
                  //                     height: 20,
                  //                     width: 20,
                  //                     padding: EdgeInsets.all(3),
                  //                     decoration: BoxDecoration(
                  //                         borderRadius: BorderRadius.circular(100),
                  //                         border: Border.all(
                  //                             color: selectedIndex == 2
                  //                                 ? colors.secondary
                  //                                 :colors.secondary,
                  //                             width: 2)),
                  //                     child: Container(
                  //                       decoration: BoxDecoration(
                  //                         borderRadius: BorderRadius.circular(100),
                  //                         color: selectedIndex == 2
                  //                             ? colors.secondary
                  //                             : Colors.transparent,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 10,
                  //                   ),
                  //                   Text(
                  //                     "Mobile no.",
                  //                     style: TextStyle(
                  //                         color: colors.secondary,
                  //                         fontSize: 14,
                  //                         fontWeight: FontWeight.w500),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(right: 15,left: 15,top: 20),
                  //       child: Column(
                  //         children: [
                  //       selectedIndex == 1?
                  //         Form(
                  //           key: _formKey,
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.end,
                  //             children: [
                  //               Card(
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(10.0),
                  //                 ),
                  //                 elevation: 4,
                  //                 child: TextFormField(
                  //                   controller: emailController,
                  //                   keyboardType: TextInputType.text,
                  //                   decoration: InputDecoration(
                  //                       prefixIcon: Icon(Icons.email_outlined,color: colors.secondary),
                  //                       hintText: 'Email', hintStyle: TextStyle(fontSize: 15.0, color: colors.secondary),
                  //                       border: InputBorder.none,
                  //                       contentPadding: EdgeInsets.only(left: 10,top: 10)
                  //                   ),
                  //                   validator: (v) {
                  //                     if (v!.isEmpty) {
                  //                       return "Email is required";
                  //                     }
                  //                     if (!v.contains("@")) {
                  //                       return "Enter Valid Email Id";
                  //                     }
                  //                   },
                  //                 ),
                  //               ),
                  //               SizedBox(height: 10,),
                  //               Card(
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(10.0),
                  //                 ),
                  //                 elevation: 5,
                  //                 child: TextFormField(
                  //                   controller: passwordController,
                  //                   obscureText: true,
                  //                   keyboardType: TextInputType.text,
                  //                   decoration: InputDecoration(
                  //                       prefixIcon: Icon(Icons.lock_open_rounded,color: colors.secondary),
                  //                       hintText: 'Password', hintStyle: TextStyle(fontSize: 15.0, color: colors.secondary),
                  //                       border: InputBorder.none,
                  //                       contentPadding: EdgeInsets.only(left: 10,top: 12)
                  //                   ),
                  //                   validator: (v) {
                  //                     if (v!.isEmpty) {
                  //                       return "Password is required";
                  //                     }
                  //                   },
                  //                 ),
                  //               ),
                  //
                  //               InkWell(
                  //                 onTap: (){
                  //                   Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdatePassword()));
                  //                 },
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(8.0),
                  //                     child: Text("Forget Password?",style: TextStyle(color: colors.secondary),),
                  //                   )),
                  //               SizedBox(height: 40,),
                  //               Padding(
                  //                 padding: const EdgeInsets.only(right:10.0),
                  //                 child: Btn(
                  //                     height: 50,
                  //                     width: 350,
                  //                     title: 'Sign in',
                  //                     onPress: () {
                  //                       if (_formKey.currentState!.validate()) {
                  //                         Navigator.push(context,
                  //                             MaterialPageRoute(builder: (context) =>SignupScreen()));
                  //                       } else {
                  //                         const snackBar = SnackBar(
                  //                           content: Text('All Fields are required!'),
                  //                         );
                  //                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //                         //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  //                       }
                  //
                  //                     }
                  //
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         )
                  //           : SizedBox.shrink(),
                  //           selectedIndex == 2?
                  //           Form(
                  //             key: _formKey,
                  //             child: Column(
                  //               children: [
                  //                 Card(
                  //                   shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(10.0),
                  //                   ),
                  //                   elevation: 5,
                  //                   child: TextFormField(
                  //                     maxLength: 10,
                  //                     maxLines: 1,
                  //                     controller: mobileController,
                  //                     keyboardType: TextInputType.number,
                  //                     decoration: InputDecoration(
                  //                         counterText: "",
                  //                         prefixIcon: Icon(Icons.perm_identity_sharp,color: colors.secondary),
                  //                         hintText: 'Mobile ',hintStyle: TextStyle(fontSize: 15.0, color: colors.secondary),
                  //                         border: InputBorder.none,
                  //                         contentPadding: EdgeInsets.only(left: 10,top: 12)
                  //                     ),
                  //                     validator: (v) {
                  //                       if (v!.isEmpty) {
                  //                         return "Mobile is required";
                  //                       }
                  //
                  //                     },
                  //                   ),
                  //                 ),
                  //                 SizedBox(height: 40,),
                  //                 Btn(
                  //                     height: 50,
                  //                     width: 350,
                  //                     title: 'Send OTP',
                  //                     onPress: () {
                  //                       if (_formKey.currentState!.validate()) {
                  //                         Navigator.push(context,
                  //                             MaterialPageRoute(builder: (context) =>VerifyOtp()));
                  //                       } else {
                  //                         const snackBar = SnackBar(
                  //                           content: Text('All Fields are required!'),
                  //                         );
                  //                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //                         //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  //                       }
                  //                     }
                  //
                  //                 ),
                  //               ],
                  //             ),
                  //           ) : SizedBox.shrink(),
                  //          //  SizedBox(height: 30,),
                  //          // Btn(
                  //          //    height: 50,
                  //          //    width: 320,
                  //          //    title: selectedIndex==1?'Sign in': 'Send OTP',
                  //          //    onPress: () {
                  //          //      if (_formKey.currentState!.validate()) {
                  //          //      } else {
                  //          //        // Navigator.push(context,
                  //          //        //     MaterialPageRoute(builder: (context) =>LoginScreen()));
                  //          //        //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  //          //      }
                  //          //        const snackBar = SnackBar(
                  //          //          content: Text('All Fields are required!'),
                  //          //        );
                  //          //        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //          //
                  //          //      }
                  //          //
                  //          //  ),
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                  ),

              // Container(
              //   color: colors.primary,
              //   child:
              // )
            ],
          ),
        ),
      ),
    );
  }
}
