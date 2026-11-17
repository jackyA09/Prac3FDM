import 'package:flutter/material.dart';
import 'package:fit_track_pro/features/weight/models/weight_model.dart';
import 'package:fit_track_pro/features/weight/screens/add_weight_screen.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  // Lista temporal: vive solo mientras esta pantalla esté abierta
  List<WeightModel> registros = [];

  // Función async: navega al formulario y ESPERA el resultado
  Future<void> _navegarAAgregarPeso() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddWeightScreen()),
    );

    // Evita usar setState si la pantalla ya fue cerrada mientras se esperaba
    if (!mounted) return;

    // Solo agrega si no es nulo (el usuario no canceló) y es un WeightModel
    if (resultado != null && resultado is WeightModel) {
      setState(() {
        registros.add(resultado);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Peso'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: registros.isEmpty
          ? Center(child: Text('No hay registros'))
          : ListView.builder(
              itemCount: registros.length,
              itemBuilder: (context, index) {
                final registro = registros[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(Icons.monitor_weight)),
                    title: Text(
                      registro.fecha,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '${registro.pesoKilos} kg',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navegarAAgregarPeso,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
