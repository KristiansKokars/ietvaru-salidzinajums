package com.kristianskokars.demo

import android.app.Application

class DemoApp : Application() {
    override fun onCreate() {
        super.onCreate()
        Dependencies.create(getDatabaseBuilder(this))
    }
}
