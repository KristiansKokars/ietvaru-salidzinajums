import { int, sqliteTable, text } from "drizzle-orm/sqlite-core";

export const itemTable = sqliteTable("item_table", {
  id: text().primaryKey(),
  url: text().notNull(),
  width: int().notNull(),
  height: int().notNull(),
});
