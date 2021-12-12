import 'package:flutter/material.dart';

class ConfScreen extends StatefulWidget {
  // ConfScreen empty constructor
  const ConfScreen({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<ConfScreen> {
  List<Map> availableConfs = [
    {"name": "Guadar Localmente", "isChecked": false},
    {"name": "Hacer post de la ubicación", "isChecked": false},
    {
      "name": "Recibir notificaciones",
      "isChecked": false,
    },
    {"name": "Tema oscuro predeterminado", "isChecked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Escoge tus preferencias",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),

            Column(
                // ignore: non_constant_identifier_names
                children: availableConfs.map((Conf) {
              return CheckboxListTile(
                  value: Conf["isChecked"],
                  title: Text(Conf["name"]),
                  onChanged: (newValue) {
                    setState(() {
                      Conf["isChecked"] = newValue;
                    });
                  });
            }).toList()),

            // ignore: prefer_const_constructors
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (input) {
                final isDigitsOnly = int.tryParse(input!);
                return isDigitsOnly == null
                    ? 'Input needs to be digits only'
                    : null;
              },
              decoration: const InputDecoration(
                  labelText: "Intervalo de actualizaciones",
                  hintText: "Tiempo en minutos"),
            ),

            const Divider(indent: 30, endIndent: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Guardar cambios'),
                ),
                const Divider(indent: 5, endIndent: 5),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Valores predeterminados'),
                )
              ],
            )
          ]);
  }
}
