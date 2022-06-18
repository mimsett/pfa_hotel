import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_pfa/screens/registration_screen.dart';
import '../pallete.dart';
import '../widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotel_pfa/firebase_options.dart';
//import 'package:flutter_session/flutter_session.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(
          image: 'assets/images/login_image.png',
        ),
        FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    children: [
                      const Flexible(
                        child: Center(
                          child: Text(
                            'boook me',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextInputField(
                            control: _email,
                            icon: FontAwesomeIcons.envelope,
                            hint: 'Email',
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                          ),
                          PasswordInput(
                            control: _password,
                            icon: FontAwesomeIcons.lock,
                            hint: 'Password',
                            inputAction: TextInputAction.done,
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, 'ForgotPassword'),
                            child: const Text(
                              'Forgot Password',
                              style: kBodyText,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          RoundedButton(
                            email: _email,
                            password: _password,
                            buttonName: 'Login',
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                        child: Container(
                          child: const Text(
                            'Create New Account',
                            style: kBodyText,
                          ),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(width: 1, color: kWhite))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              default:
                return const Text('loading...');
            }
          },
        ),
      ],
    );
  }
}
