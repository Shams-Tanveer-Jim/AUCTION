import 'package:bidbox/services/google_signin.dart';
import 'package:bidbox/views/widgets/dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../consts/assets.dart';
import '../consts/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            ColorConstants.backgroundColor2,
            ColorConstants.backgroundColor1,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: ColorConstants.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AssetsConstant.logo,
                scale: 3,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "AUCTION",
                style: GoogleFonts.comicNeue(
                    fontSize: 34, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: ElevatedButton.icon(
                    onPressed: () {
                      GoogleServices.signInWithGoogle(context);
                    },
                    icon: Image.asset(
                      AssetsConstant.google,
                      width: 25,
                      height: 25,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        maximumSize: const Size(double.infinity, 50)),
                    label: const Text(
                      "SIGN IN WITH GOOGLE",
                      style: TextStyle(color: Colors.yellow),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
