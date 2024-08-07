import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../assets/asset_helper.dart';
import 'controllers/login_ui_controller.dart';
import '../../utilities/app_service.dart';
import '../../utilities/classes/app_models.dart';
import '../../utilities/constants/core_constants.dart';
import '../../utilities/responsive.dart';
import '../../utilities/shared_preferences.dart';
import '../../utilities/ui_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  LoginUIController simpleUIController = Get.put(LoginUIController());
  TextEditingController usernameController =
      TextEditingController(text: sharedPref.getUsername());
  TextEditingController passwordController =
      TextEditingController(text: sharedPref.getPassword());

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginUIController simpleUIController = Get.find<LoginUIController>();
    var size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          // backgroundColor: Colors.white,
          // resizeToAvoidBottomInset: false,
          // body: LayoutBuilder(builder: (context, constraints) {
          //   if (constraints.maxWidth > constraints.maxHeight) {
          //     return _buildLargeScreen(size, simpleUIController);
          //   } else {
          //     return _buildSmallScreen(size, simpleUIController);
          //   }
          // }),
          body: Responsive.isSmallWidth(context)
              ? _buildSmallScreen(size, simpleUIController)
              : _buildLargeScreen(size, simpleUIController),
        ));
  }

  Widget _buildLargeScreen(Size size, LoginUIController simpleUIController) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: RotatedBox(
            quarterTurns: 0,
            child: Image.asset(
              AssetHelper.logoPortrait,
              height: size.height * 0.3,
              width: double.infinity,
              // fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildMainBody(size, simpleUIController),
        ),
      ],
    );
  }

  Widget _buildSmallScreen(Size size, LoginUIController simpleUIController) {
    return Center(
      child: _buildMainBody(size, simpleUIController),
    );
  }

  Widget _buildMainBody(Size size, LoginUIController simpleUIController) {
    Locale? locale = sharedPref.getLocale();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: !Responsive.isSmallWidth(context)
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          size.width > size.height
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Image.asset(
                    AssetHelper.logoLandscape,
                    height: size.height * 0.2,
                    width: size.width,
                    // fit: BoxFit.fill,
                  ),
                ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              sharedPref.translate('Login'),
              // style: kLoginTitleStyle(size),
              style: TextStyle(
                fontSize: size.height * 0.060,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              sharedPref.translate('Welcome back!'),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// username
                  TextFormField(
                    controller: usernameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: sharedPref.translate('Username or Email'),
                      label: Text(sharedPref.translate('Account')),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    autofocus: usernameController.text == '' ? true : false,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      var min = 4, max = 13;
                      if (value == null || value.isEmpty) {
                        return sharedPref.translate('Please enter username');
                      } else if (value.length < 4) {
                        return '${sharedPref.translate('Minimum character is:')} $min';
                      } else if (value.length > 13) {
                        return '${sharedPref.translate('Maximum character is:')} $max';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// Password
                  Obx(
                    () => TextFormField(
                      controller: passwordController,
                      obscureText:
                          simpleUIController.isObscure.value ? true : false,
                      decoration: InputDecoration(
                        label: Text(sharedPref.translate('Password')),
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: IconButton(
                          icon: Icon(
                            simpleUIController.isObscure.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            simpleUIController.isObscureActive();
                          },
                        ),
                        // hintText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        var min = 6;
                        if (value == null || value.isEmpty) {
                          return sharedPref.translate('Please enter password');
                        } else if (value.length < min) {
                          return '${sharedPref.translate('Minimum character is:')} $min';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  _loginButton(),

                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  DropdownButton(
                    icon: const Icon(Icons.language),
                    items: constants.supportedLocales
                        .map<DropdownMenuItem<Locale>>(
                            (LocaleDescription appLocale) {
                      return DropdownMenuItem<Locale>(
                        value: appLocale.locale,
                        child: Text(appLocale.name),
                      );
                    }).toList(),
                    value: locale,
                    onChanged: (val) async {
                      await sharedPref.setLocale(val);
                      setState(
                        () {
                          locale = val;
                        },
                      );
                    },
                  ),

                  /// Navigate To Login Screen
                  // GestureDetector(
                  //   onTap: () {
                  //     // Navigator.pop(context);
                  //     usernameController.clear();
                  //     passwordController.clear();
                  //     _formKey.currentState?.reset();
                  //     simpleUIController.isObscure.value = true;
                  //   },
                  //   child: RichText(
                  //     text: TextSpan(
                  //       text: 'Don\'t have an account?',
                  //       style: kHaveAnAccountStyle(size),
                  //       children: [
                  //         TextSpan(
                  //           text: " Sign up",
                  //           style: kLoginOrSignUpTextStyle(
                  //             size,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.blue),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Map<String, String> payload = {
              'username': usernameController.text.toString(), // sysadmin
              'password': passwordController.text.toString(), // 123456a@
            };
            login(context, payload);
          }
        },
        child: Text(
          sharedPref.translate('Login'),
          style: const TextStyle(color: kBgColor),
        ),
      ),
    );
  }
}
