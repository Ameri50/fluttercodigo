import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _modoTema = ThemeMode.light;

  void _alternarTema() {
    setState(() {
      _modoTema = _modoTema == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación Rojas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      themeMode: _modoTema,
      home: ContadorApp(onTemaToggle: _alternarTema, modoTema: _modoTema),
    );
  }
}

class ContadorApp extends StatefulWidget {
  final VoidCallback onTemaToggle;
  final ThemeMode modoTema;

  const ContadorApp({super.key, required this.onTemaToggle, required this.modoTema});

  @override
  _ContadorAppState createState() => _ContadorAppState();
}

class _ContadorAppState extends State<ContadorApp> {
  int _contador = 0;
  final List<int> _historial = [];

  void _mostrarSnack(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), duration: Duration(milliseconds: 600)),
    );
  }

  void _incrementar() {
    setState(() {
      _contador++;
      _historial.add(_contador);
    });
    _mostrarSnack('Sumado: $_contador');
  }

  void _decrementar() {
    setState(() {
      _contador--;
      _historial.add(_contador);
    });
    _mostrarSnack('Restado: $_contador');
  }

  void _reiniciar() {
    setState(() {
      _contador = 0;
      _historial.add(_contador);
    });
    _mostrarSnack('Reiniciado');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicación Rojas'),
        actions: [
          IconButton(
            icon: Icon(widget.modoTema == ThemeMode.light
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            onPressed: widget.onTemaToggle,
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Column(
              children: [
                Text('Rojas.Mendoza',
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                Text('Contador de clics en Flutter',
                    style: GoogleFonts.poppins(fontSize: 18)),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text('$_contador',
                      key: ValueKey<int>(_contador),
                      style: GoogleFonts.poppins(
                          fontSize: 60, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _historial.isEmpty
                  ? Center(
                      child: Text('Sin historial aún',
                          style: GoogleFonts.poppins(color: Colors.grey)),
                    )
                  : ListView.builder(
                      itemCount: _historial.length,
                      itemBuilder: (context, index) {
                        final valor = _historial[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            leading: Icon(Icons.history, color: Colors.teal),
                            title: Text('Valor: $valor',
                                style: GoogleFonts.poppins()),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: _decrementar,
              tooltip: 'Restar',
              child: Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: _reiniciar,
              tooltip: 'Reiniciar',
              child: Icon(Icons.restart_alt),
            ),
            FloatingActionButton(
              onPressed: _incrementar,
              tooltip: 'Sumar',
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
