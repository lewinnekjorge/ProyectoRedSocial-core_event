import 'package:flutter/material.dart';

class InicioWidget extends StatefulWidget {
  const InicioWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<InicioWidget> createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              Flexible(
                flex: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/nosotros.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                    margin: const EdgeInsets.all(0.0),
                    padding: const EdgeInsets.all(0.0),
                    color: Colors.deepPurple,
                    alignment: Alignment.center,
                    child: const Text("CORE EVENT",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Roboto',
                        ))),
              ),
              Center(
                  //flex: 2,
                  child: Container(
                      margin: const EdgeInsets.all(20.0),
                      //padding: const EdgeInsets.all(25.0),
                      alignment: Alignment.center,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: MaterialButton(
                        child: const Text("Login",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Roboto',
                            )),
                        elevation: 10,
                        color: Colors.deepPurple,
                        height: 50,
                        minWidth: 150,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/usr_login');
                        },
                      ))),
              Center(
                  //flex: 2,
                  child: Container(
                      margin: const EdgeInsets.all(20.0),
                      //padding: const EdgeInsets.all(25.0),
                      alignment: Alignment.center,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: MaterialButton(
                        child: const Text("Registro",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Roboto',
                            )),
                        elevation: 10,
                        color: Colors.deepPurple,
                        height: 50,
                        minWidth: 150,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/usr_register');
                        },
                      ))),
            ])));
  }
}
