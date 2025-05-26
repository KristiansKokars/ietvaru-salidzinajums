import { db } from "@/lib/db";
import { itemTable } from "@/lib/schema";
import { useLiveQuery } from "drizzle-orm/expo-sqlite";
import { Image } from "expo-image";
import { Link } from "expo-router";
import { useEffect } from "react";
import { Button, FlatList, View } from "react-native";

async function fetchAPIItems(): Promise<APIResponse[]> {
  const response = await fetch(
    "https://api.thecatapi.com/v1/images/search?limit=10"
  );

  return await response.json();
}

interface APIResponse {
  id: string;
  url: string;
  width: number;
  height: number;
}

export default function Index() {
  const { data } = useLiveQuery(db.select().from(itemTable));

  async function fetchAndUpdateItems() {
    const items = await fetchAPIItems();
    await db.insert(itemTable).values(items).onConflictDoNothing();
  }

  useEffect(() => {
    fetchAndUpdateItems();
  }, []);

  return (
    <View
      style={{
        flex: 1,
        justifyContent: "center",
      }}
    >
      <Button title="Get more items" onPress={fetchAndUpdateItems}></Button>
      <FlatList
        columnWrapperStyle={{
          flex: 1,
          alignContent: "center",
          justifyContent: "space-between",
          paddingHorizontal: 20,
          paddingBottom: 20,
        }}
        data={data}
        numColumns={3}
        renderItem={({ item }) => (
          <Link
            style={{
              display: "flex",
              justifyContent: "center",
              backgroundColor: "gray",
              aspectRatio: "1",
            }}
            href={{ pathname: "/details", params: { itemId: item.id } }}
          >
            <Image source={item.url} style={{ width: 100, height: 100 }} />
          </Link>
        )}
      />
    </View>
  );
}
