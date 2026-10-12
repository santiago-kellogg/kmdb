# Runs one piece of SQL against the database and holds what came back:
# the column names and rows, or the error message if the database refused it.
class Query
  MAX_ROWS = 500

  attr_reader :sql, :columns, :rows, :error

  def initialize(sql)
    @sql = sql.to_s
  end

  # read_only: true refuses anything that would change the data, which is how
  # the Queries page re-runs every saved file on each refresh without harm.
  def run(read_only: false)
    result = read_only ? ActiveRecord::Base.while_preventing_writes { execute } : execute
    @columns = result.columns
    @rows = result.rows
    self
  rescue ActiveRecord::ReadOnlyError
    @error = "Not run: files on this page can only read the data."
    self
  rescue ActiveRecord::StatementInvalid => e
    @error = e.message
    self
  end

  # Not run at all, for the reason given.
  def refuse(reason)
    @error = reason
    self
  end

  def error? = error.present?

  def row_count = rows&.size.to_i

  def truncated? = row_count > MAX_ROWS

  def visible_rows = rows.to_a.first(MAX_ROWS)

  private

  def execute
    ActiveRecord::Base.connection.select_all(sql)
  end
end
