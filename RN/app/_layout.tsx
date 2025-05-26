import { Stack } from "expo-router";
import { useMigrations } from "drizzle-orm/expo-sqlite/migrator";
import { db } from "@/lib/db";
import migrations from "../drizzle/migrations";
import { Text, View } from "react-native";

export default function RootLayout() {
  const { success, error } = useMigrations(db, migrations);

  if (error) {
    return (
      <View>
        <Text>Error: {error.message}</Text>
      </View>
    );
  }

  if (!success) {
    return (
      <View>
        <Text>Database is migrating</Text>
      </View>
    );
  }

  return <Stack />;
}
