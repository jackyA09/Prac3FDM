import 'package:flutter/material.dart';
import 'package:fit_track_pro/features/weight/models/weight_model.dart';

// StatefulWidget porque maneja controllers y el estado del formulario
class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen({super.key});

  @override
  State<AddWeightScreen> createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  // GlobalKey<FormState>: permite ejecutar validate() sobre todo el Form
  final _formKey = GlobalKey<FormState>();

  final _fechaController = TextEditingController();
  final _pesoController = TextEditingController();

  @override
  void dispose() {
    // liberar los controllers al destruir la pantalla
    _fechaController.dispose();
    _pesoController.dispose();
    super.dispose();
  }

  void _guardarRegistro() {
    // validate() corre el validator de cada TextFormField del Form
    if (_formKey.currentState!.validate()) {
      // Empaqueta los datos ya validados en un WeightModel
      final nuevoRegistro = WeightModel(
        fecha: _fechaController.text.trim(),
        pesoKilos: double.parse(_pesoController.text),
      );

      // Regresa el objeto a la pantalla anterior (lo recibe el await del push)
      Navigator.pop(context, nuevoRegistro);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Registro de Peso'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _fechaController,
                decoration: InputDecoration(
                  labelText: 'Fecha (ej. 17 de Noviembre)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                // Validación: no puede estar vacío
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa la fecha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _pesoController,
                // Teclado numérico
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.monitor_weight),
                ),
                // Validación: no vacío, numérico y mayor a 0
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu peso';
                  }
                  final peso = double.tryParse(value);
                  if (peso == null) {
                    return 'Ingresa un valor numérico válido';
                  }
                  if (peso <= 0) {
                    return 'El peso debe ser mayor a 0';
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _guardarRegistro,
                child: Text('Guardar', style: TextStyle(fontSize: 18.0)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
