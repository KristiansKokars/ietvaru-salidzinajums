package com.kristianskokars.demo

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class DetailViewModel(private val itemId: String) : ViewModel() {
    private val _state = MutableStateFlow(DetailState())
    private val itemDao = Dependencies.dependencyBox.itemDao

    val state = _state.asStateFlow()

    init {
        collectFromDB()
    }

    private fun collectFromDB() {
        viewModelScope.launch {
            itemDao.get(itemId).collectLatest { newItem -> _state.update { it.copy(item = newItem.toAPIResponse()) } }
        }
    }
}

data class DetailState(
    val item: APIResponse? = null
)
