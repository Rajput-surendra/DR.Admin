

import 'package:doctoradmin/Helper/Appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/AppBtn.dart';
import '../Helper/Color.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  customAppBar(text: "Update password",isTrue: true, context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Old Password", style: TextStyle(
                  color: colors.black54, fontWeight: FontWeight.bold),),
            ),

            SizedBox(height: 10,),
            TextFormField(
              // controller: passController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: '',
                  hintStyle: TextStyle(
                      fontSize: 15.0, color: colors.secondary),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: EdgeInsets.only(left: 10, top: 10)
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return "password is required";
                }

              },
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("New Password", style: TextStyle(
                  color: colors.black54, fontWeight: FontWeight.bold),),
            ),

            SizedBox(height: 10,),
            TextFormField(
              // controller: passController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: '',
                  hintStyle: TextStyle(
                      fontSize: 15.0, color: colors.secondary),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: EdgeInsets.only(left: 10, top: 10)
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return "password is required";
                }

              },
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Confirm New Password", style: TextStyle(
                  color: colors.black54, fontWeight: FontWeight.bold),),
            ),

            SizedBox(height: 10,),
            TextFormField(
              // controller: passController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: '',
                  hintStyle: TextStyle(
                      fontSize: 15.0, color: colors.secondary),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: EdgeInsets.only(left: 10, top: 10)
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return "password is required";
                }

              },
            ),
            SizedBox(height: 50,),
            Center(
              child: Btn(
                color: colors.secondary,
                height: 50,width: 320,title: 'Update Password',onPress: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Container()));
              },),
            )
          ],
        ),
      ),
    );
  }
}
