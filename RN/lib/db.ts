import * as SQLite from "expo-sqlite";
import { drizzle } from "drizzle-orm/expo-sqlite";

const expo = SQLite.openDatabaseSync("database.db", {
  enableChangeListener: true,
});

export const db = drizzle(expo);
