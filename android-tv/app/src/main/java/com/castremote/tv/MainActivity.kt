package com.castremote.tv

import android.app.Activity
import android.os.Bundle
import android.graphics.Color
import android.view.Gravity
import android.widget.LinearLayout
import android.widget.TextView

class MainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER
            setPadding(32, 32, 32, 32)
            setBackgroundColor(Color.rgb(8, 17, 38))
        }

        val title = TextView(this).apply {
            text = "CASTREMOTE"
            textSize = 32f
            setTextColor(Color.rgb(80, 210, 255))
            gravity = Gravity.CENTER
        }
        val subtitle = TextView(this).apply {
            text = "Your TV companion is ready"
            textSize = 18f
            setTextColor(Color.WHITE)
            gravity = Gravity.CENTER
            setPadding(0, 20, 0, 8)
        }
        val status = TextView(this).apply {
            text = "Companion app starter\nRemote pairing and casting are not enabled yet."
            textSize = 14f
            setTextColor(Color.LTGRAY)
            gravity = Gravity.CENTER
            setPadding(0, 12, 0, 0)
        }

        root.addView(title)
        root.addView(subtitle)
        root.addView(status)
        setContentView(root)
    }
}
