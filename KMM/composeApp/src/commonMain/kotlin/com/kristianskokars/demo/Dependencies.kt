package com.kristianskokars.demo

import androidx.room.RoomDatabase

object Dependencies {
    lateinit var dependencyBox: DependencyBox

    private lateinit var database: AppDatabase

    fun create(builder: RoomDatabase.Builder<AppDatabase>) {
        database = getRoomDatabase(builder)
        dependencyBox = DependencyBox(
            database = database,
            itemDao = database.getDao()
        )
    }
}

data class DependencyBox(
    val database: AppDatabase,
    val itemDao: ItemDao
)
