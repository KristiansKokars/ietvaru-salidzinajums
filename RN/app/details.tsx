import { db } from "@/lib/db";
import { itemTable } from "@/lib/schema";
import { eq } from "drizzle-orm";
import { useLiveQuery } from "drizzle-orm/expo-sqlite";
import { Image } from "expo-image";
import { useLocalSearchParams } from "expo-router";
import { ActivityIndicator, View } from "react-native";

export default function Details() {
  const { itemId } = useLocalSearchParams<{ itemId: string }>();
  const { data } = useLiveQuery(
    db
      .select()
      .from(itemTable)
      .where(eq(itemTable.id, itemId as string))
  );

  if (data.length <= 0) {
    return (
      <View>
        <ActivityIndicator size="large" />
      </View>
    );
  }

  return (
    <View>
      <Image source={data[0].url} style={{ width: 100, height: 100 }} />
    </View>
  );
}
