import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:core_event/domain/use_cases/controllers/authentication.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.title,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Login con Email",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                      width: 300,
                    ),
                    TextFormField(
                      key: const Key("signInEmail"),
                      keyboardType: TextInputType.emailAddress,
                      controller: controllerEmail,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Accede con tu email',
                        hintText: 'Accede con tu email',
                      ),
                      maxLength: 35,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digite su email";
                        } else if (!value.contains('@') &&
                            !value.contains(".co") &&
                            !value.contains(".com") &&
                            !value.contains(".com.co") &&
                            !value.contains("edu.co")) {
                          return "Digite una direccion valida de email";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                      width: 300,
                    ),
                    TextFormField(
                      key: const Key("signInPassword"),
                      controller: controllerPassword,
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Digita tu password',
                        hintText: 'Digita tu password',
                      ),
                      maxLength: 25,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digita password";
                        } else if (value.length < 6) {
                          return "Password debe ser de minimo 6 caracteres";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Material(
                      elevation: 5,
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(30),
                      child: MaterialButton(
                        onPressed: () async {
                          bool isValid = true;
                          if (isValid) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            final form = _formKey.currentState;
                            form!.save();
                            if (_formKey.currentState!.validate()) {
                              await controller.manager.signIn(
                                  email: controllerEmail.text,
                                  password: controllerPassword.text);
                            }
                          }
                        },
                        minWidth: 320,
                        height: 30,
                        child: const Text(
                          'Acceder',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
