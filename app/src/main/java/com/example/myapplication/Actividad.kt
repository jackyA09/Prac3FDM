package com.example.myapplication;

// Mismo patrón que el modelo de Flutter: clase de datos sin lógica
class Actividad(
        val titulo: String,
        val subtitulo: String,
        var completado: Boolean = false // var: es lo único que cambia con el check
)