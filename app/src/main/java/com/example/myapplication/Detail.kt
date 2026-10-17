package com.example.myapplication;

import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.runtime.savedinstancestate.savedInstanceState
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

class Detail : AppCompatActivity(){
    override fun onCreate(savedInstancesState: Bundle?){
        super.onCreate(savedInstancesState)
        setContentView(R.layout.activity_detail)

        val tvResumen=findViewById<TextView>(R.id.tvResumen);
        val btnRegresar=findViewById<TextView>(R.id.btnRegresar);
        val contador= intent.getIntExtra("Pasos", 0);

        tvResumen.text= "Pasos completados: $contador";

        btnRegresar.setOnClickListener {
            finish();
        }
    }
}
