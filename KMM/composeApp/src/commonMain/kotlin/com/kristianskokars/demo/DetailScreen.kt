package com.kristianskokars.demo

import androidx.compose.foundation.layout.Column
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.lifecycle.viewmodel.compose.viewModel
import coil3.compose.AsyncImage
import org.jetbrains.compose.ui.tooling.preview.Preview

@Composable
@Preview
fun DetailScreen(
    itemId: String,
    viewModel: DetailViewModel = viewModel { DetailViewModel(itemId) },
) {
    val state by viewModel.state.collectAsStateWithLifecycle()

    Column {
        when (val item = state.item) {
            null -> CircularProgressIndicator()
            else -> {
                AsyncImage(
                    model = item.url,
                    contentDescription = null
                )
            }
        }
    }
}
