# The tables in the database as they are right now, read from SQLite itself, so the
# Schema page always shows what bin/load actually built.
class DatabaseSchema
  Table = Struct.new(:name, :columns, :row_count)

  # points_to is the table a foreign key leads to: the one the column declares with
  # REFERENCES, or else the one its name implies (company_id -> companies).
  # points_to_missing is true when that table does not exist.
  Column = Struct.new(:name, :type, :primary_key, :points_to, :points_to_missing)

  def self.tables
    new.tables
  end

  def tables
    names.map { |name| Table.new(name, columns_of(name), row_count_of(name)) }
  end

  private

  def connection = ActiveRecord::Base.connection

  def names
    @names ||= connection.select_values(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%' ORDER BY name"
    )
  end

  def columns_of(table)
    declared = connection.select_all("PRAGMA foreign_key_list(#{quoted(table)})")
      .to_h { |key| [key["from"], key["table"]] }

    connection.select_all("PRAGMA table_info(#{quoted(table)})").map do |column|
      name = column["name"]
      target = declared[name] || (name.delete_suffix("_id").pluralize if name.end_with?("_id"))
      Column.new(name, column["type"], column["pk"].to_i.positive?, target, target && !names.include?(target))
    end
  end

  def row_count_of(table)
    connection.select_value("SELECT COUNT(*) FROM #{quoted(table)}")
  end

  def quoted(table) = connection.quote_table_name(table)
end
