package com.kristianskokars.demo

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.toRoute
import kotlinx.serialization.Serializable
import org.jetbrains.compose.ui.tooling.preview.Preview

@Composable
@Preview
fun App() {
    val navController = rememberNavController()

    MaterialTheme {
        Scaffold { innerPadding ->
            NavHost(
                navController = navController,
                startDestination = Screens.List,
                modifier = Modifier
                    .fillMaxSize()
                    .padding(innerPadding),
            ) {
                composable<Screens.List> {
                    ListScreen(
                        onGoToDetail = {
                            navController.navigate(Screens.Detail(it))
                        }
                    )
                }
                composable<Screens.Detail> { entry ->
                    val detail = entry.toRoute<Screens.Detail>()
                    DetailScreen(itemId = detail.itemId)
                }
            }
        }
    }
}

@Serializable
sealed interface Screens {
    @Serializable
    data object List : Screens
    @Serializable
    data class Detail(val itemId: String) : Screens
}
