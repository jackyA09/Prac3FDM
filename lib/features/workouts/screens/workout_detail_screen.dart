import 'package:flutter/material.dart';
import 'package:fit_track_pro/features/workouts/models/workout_model.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final WorkoutModel workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _duracionController;
  late String _selectedCategory;

  final List<String> _categories = ['Fuerza', 'Cardio', 'Flexibilidad'];
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.workout.title);
    _duracionController = TextEditingController(
      text: widget.workout.durationMinutes.toString(),
    );
    _selectedCategory = widget.workout.category;

    // Asegurarse de que la categoría actual esté en la lista si es personalizada
    if (!_categories.contains(_selectedCategory)) {
      _categories.add(_selectedCategory);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _duracionController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _cancelEdit() {
    setState(() {
      // Revertir valores originales
      _titleController.text = widget.workout.title;
      _duracionController.text = widget.workout.durationMinutes.toString();
      _selectedCategory = widget.workout.category;
      _isEditing = false;
    });
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final updatedWorkout = WorkoutModel(
        localId: widget.workout.localId,
        title: _titleController.text,
        category: _selectedCategory,
        durationMinutes: int.parse(_duracionController.text),
      );

      Navigator.pop(context, updatedWorkout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Rutina' : 'Detalles de Rutina'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          if (!_isEditing)
            IconButton(
              icon: Icon(Icons.edit),
              tooltip: 'Editar',
              onPressed: _toggleEdit,
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                enabled: _isEditing,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  if (value.length < 3) {
                    return 'El nombre es muy corto';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    child: Text(category),
                    value: category,
                  );
                }).toList(),
                onChanged: _isEditing
                    ? (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue!;
                        });
                      }
                    : null, // Deshabilitado si no está en modo edición
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _duracionController,
                enabled: _isEditing,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Duración (minutos)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timer),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la duración';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Ingresa un valor numérico válido';
                  }
                  return null;
                },
              ),
              Spacer(),
              if (_isEditing) ...[
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _cancelEdit,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          side: BorderSide(color: Colors.red),
                          foregroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Cancelar',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Guardar',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
