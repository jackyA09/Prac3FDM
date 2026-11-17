// no se guardan en base de datos (viven en una lista temporal en pantalla).
class WeightModel {
  final String fecha; // ej. "17 de Noviembre"
  final double pesoKilos; // ej. 75.5

  WeightModel({required this.fecha, required this.pesoKilos});
}
