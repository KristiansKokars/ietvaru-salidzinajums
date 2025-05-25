package com.kristianskokars.demo

fun APIResponse.toDBEntity(): ItemEntity = ItemEntity(
    id = id,
    url = url,
    width = width,
    height = height
)

fun List<APIResponse>.toDBEntities(): List<ItemEntity> = map { it.toDBEntity() }

fun ItemEntity.toAPIResponse(): APIResponse = APIResponse(
    id = id,
    url = url,
    width = width,
    height = height
)

fun List<ItemEntity>.toAPIResponses(): List<APIResponse> = map { it.toAPIResponse() }
