import 'package:flutter/material.dart';

class HomeScreen  extends StatelessWidget{
  const HomeScreen({super.key}); 

  @override
  Widget build(BuildContext context) {
    const fontSizeVar25 = TextStyle(fontSize: 30);

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: const Text('Mi primera app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Click para cambiar contador',
              style: fontSizeVar25,
            ),
            const Text('30'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('hola mis amiguitos');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}