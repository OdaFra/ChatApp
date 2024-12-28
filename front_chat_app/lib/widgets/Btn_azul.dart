import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String texto;
  final Function onpressed;

  const BotonAzul({
    this.texto,
    this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        // ignore: sort_child_properties_last
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(32)),
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(texto,
                style: const TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
        onPressed: () {
          onpressed();
        });
  }
}
