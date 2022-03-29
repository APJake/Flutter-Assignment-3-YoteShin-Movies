import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yoteshin_movies_asm/components/accessories/components.dart';
import 'package:get/get.dart';
import 'package:yoteshin_movies_asm/networks/authentification.dart';
import 'package:yoteshin_movies_asm/pages/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool isLoading = false;
  bool showLogin = true;

  _loginGoogle() async {
    await Authentification().signInWithGoogle();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Get.off(() => const HomePage());
    }
  }

  _register() async {
    isLoading = true;
    bool isSuccess = true;
    setState(() {});
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      isSuccess = false;
      if (e.code == 'weak-password') {
        errorSnackbar("Weak password");
      } else if (e.code == 'email-already-in-use') {
        errorSnackbar("Email already in use");
      }
    } catch (e) {
      isSuccess = false;
      errorSnackbar(e.toString());
    } finally {
      isLoading = false;
      showLogin = true;
      setState(() {});
      if (isSuccess) {
        _login();
      }
    }
  }

  _login() async {
    bool isSuccess = true;
    isLoading = true;
    setState(() {});
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      isSuccess = false;
      if (e.code == 'user-not-found') {
        // errorSnackbar("User not found");
        setState(() {
          showLogin = false;
        });
      } else if (e.code == 'wrong-password') {
        errorSnackbar("Incorrect password");
      } else {
        errorSnackbar(e.code);
      }
    } finally {
      isLoading = false;
      if (isSuccess) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          infoSnackbar("Verification sent!", "Check your email to verfy");
          setState(() {});
        } else {
          Get.off(() => const HomePage());
        }
      } else {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign in"),
        ),
        body: showLogin ? _loginForm() : _confirmRegisteration());
  }

  Container _confirmRegisteration() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isLoading ? "Registering..." : "Email does not exist!"),
            const SizedBox(
              height: 30,
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              showLogin = true;
                            });
                          },
                          child: const Text("Try again")),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _register();
                          },
                          child: const Text("Create new account"))
                    ],
                  ),
            const SizedBox(
              height: 120,
            )
          ],
        ),
      );

  Container _loginForm() => Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            TextField(
              controller: _emailController,
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: Icon(_passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  hintText: "Password",
                  border: const OutlineInputBorder()),
            ),
            const SizedBox(
              height: 12,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    child: const Text("Login / Register")),
            ElevatedButton(
              onPressed: () {
                _loginGoogle();
              },
              child: const Text("Login with Google"),
            )
          ],
        ),
      );
}
