package com.kristianskokars.demo

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import co.touchlab.kermit.Logger
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.request.get
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import io.ktor.serialization.kotlinx.json.*
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.flow.update
import kotlinx.serialization.Serializable

class ListViewModel : ViewModel() {
    private val _state = MutableStateFlow(ListState())
    private val client = HttpClient {
        install(ContentNegotiation) {
            json()
        }
    }
    private val itemDao = Dependencies.dependencyBox.itemDao

    val state = _state.asStateFlow()

    init {
        collectItemsFromDB()
        fetch()
    }

    private fun collectItemsFromDB() {
        viewModelScope.launch {
            itemDao.getAll().collectLatest { items ->
                _state.update { it.copy(items = items.toAPIResponses()) }
            }
        }
    }

    fun fetch() {
        viewModelScope.launch {
            val response = client
                .get("https://api.thecatapi.com/v1/images/search?limit=10")
                .body<List<APIResponse>>()
            Logger.d { response.toString() }
            itemDao.insertAll(response.toDBEntities())
        }
    }
}

data class ListState(
    val items: List<APIResponse> = emptyList()
)

@Serializable
data class APIResponse(
    val id: String,
    val url: String,
    val width: Int,
    val height: Int
)
