class SchemaController < ApplicationController
  # Every table, its columns, and where each foreign key points, read fresh on each refresh.
  def show
    @tables = DatabaseSchema.tables
  end
end
