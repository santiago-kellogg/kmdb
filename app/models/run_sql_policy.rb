# What the Run SQL box will run. Reading data, and the occasional row change: yes.
# Changing the structure (CREATE, ALTER, DROP) never happens inside an app; that goes
# in the schema file, loaded with bin/load. And one statement at a time, because SQLite
# runs only the first statement of a paste and silently ignores the rest.
class RunSqlPolicy
  STRUCTURE = /\A(CREATE|ALTER|DROP)\b/i
  LEADING_COMMENTS = %r{\A(?:\s+|--[^\n]*(?:\n|\z)|/\*.*?\*/)*}m

  def initialize(sql)
    @sql = sql.to_s
  end

  # nil when the box may run the SQL; otherwise the reason it won't.
  def refusal
    files = Rails.configuration.x.load_files
    if statements.empty?
      "Nothing to run: type or paste a statement first."
    elsif (change = statements.find { |statement| statement.match?(STRUCTURE) })
      "Not run: #{change[/\A\S+(?:\s+\S+)?/].upcase} changes the database's structure, and that " \
        "never happens inside an app. Put it in #{files[:schema]} and run bin/load in the terminal."
    elsif statements.size > 1
      "Not run: this box runs one statement at a time, and this is #{statements.size}. Run them " \
        "one by one, or put them in #{files[:data]} and run bin/load in the terminal."
    end
  end

  def statements
    @statements ||= split
      .map { |piece| piece.sub(LEADING_COMMENTS, "") }
      .reject { |piece| piece.delete(";").strip.empty? }
  end

  private

  # Cut at each semicolon that SQLite itself says ends a complete statement, so a
  # semicolon inside a string or a comment is not mistaken for the end of one.
  def split
    lexer = SQLite3::Database.new(":memory:")
    pieces = []
    start = 0
    @sql.scan(";") do
      finish = Regexp.last_match.end(0)
      next unless lexer.complete?(@sql[start...finish])

      pieces << @sql[start...finish]
      start = finish
    end
    pieces << @sql[start..]
  ensure
    lexer&.close
  end
end
