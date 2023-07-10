import 'package:ebtsamty/Pages/Sigin.dart';
import 'package:ebtsamty/shared/SnackBar.dart';
import 'package:ebtsamty/shared/custom_textfiled2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final EmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isloding = false;
  resetPassword() async {
    setState(() {
      isloding = true;
    });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: EmailController.text);
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => SigninScreen())));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR. :${e.code}");
    }
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    EmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(232, 243, 248, 255),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(0, 243, 248, 255),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SigninScreen()),
              );
            },
          ),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SizedBox(
                    child: Image.asset(
                      "assets/icons/Logo2.png",
                      width: 60,
                      // height: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Center(
                      child: Text(
                    "Ebtsamty",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  )),
                )
              ],
            )
          ],
        ),

        // appBar: AppBar(
        //   backgroundColor: appbar,
        //   title: Text("Reset Password"),
        //   elevation: 0,
        // ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(33.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "أدخل بريدك الالكتروني وأعد تعيين كلمة المرور",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 44,
                      ),
                      TextFormField(
                          // we return "null" when something is valid
                          validator: (email) {
                            return email!.contains(RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                                ? null
                                : "أدخل بريد إلكتروني صحيح";
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: EmailController,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          textAlign: TextAlign.end,
                          decoration: decorationTextfield2.copyWith(
                            prefixIcon: Icon(Icons.email),
                            hintText: ": أدخل بريدك الإلكتروني",
                          )),
                      const SizedBox(
                        height: 33,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            resetPassword();
                          } else {
                            showSnackBar(context, 'Error');
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 90, 154, 249)),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(12)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                        child: isloding
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "إعادة تعيين كلمة المرور",
                                style: TextStyle(fontSize: 19),
                              ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
    
  }
}
