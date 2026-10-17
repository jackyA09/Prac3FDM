package com.example.myapplication

import android.content.Context
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.CheckBox
import android.widget.TextView
import com.google.android.material.card.MaterialCardView

class ActividadAdapter(
    context: Context,
    actividades: MutableList<Actividad>
) : ArrayAdapter<Actividad>(context, 0, actividades) {

    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        // Reutiliza la vista si ya existe (reciclaje); si no, la infla
        val vista = convertView ?: LayoutInflater.from(context)
            .inflate(R.layout.item_card, parent, false)
        val card = vista as MaterialCardView
        val actividad = getItem(position)!!

        val tvTitulo = vista.findViewById<TextView>(R.id.tvTituloCard)
        val tvSubtitulo = vista.findViewById<TextView>(R.id.tvSubtituloCard)
        val cbCompletado = vista.findViewById<CheckBox>(R.id.cbCompletado)

        tvTitulo.text = actividad.titulo
        tvSubtitulo.text = actividad.subtitulo

        // 1) quitar el listener ANTES de asignar el estado (ver nota abajo)
        cbCompletado.setOnCheckedChangeListener(null)
        // 2) pintar el estado real del dato
        cbCompletado.isChecked = actividad.completado
        pintarCard(card, actividad.completado)
        // 3) volver a poner el listener
        cbCompletado.setOnCheckedChangeListener { _, marcado ->
            actividad.completado = marcado
            pintarCard(card, marcado)
        }

        return vista
    }

    // Verde cuando está completada, igual que en la versión de Flutter
    private fun pintarCard(card: MaterialCardView, completado: Boolean) {
        card.setCardBackgroundColor(
            if (completado) Color.parseColor("#4BDB6C") else Color.WHITE
        )
    }
}