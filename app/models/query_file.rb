# One .sql file in queries/: the question on its first line (-- Q: ...), then the SQL.
class QueryFile
  DIRECTORY = Rails.root.join("queries")
  QUESTION = /\A--\s*Q:\s*/i

  attr_reader :path

  def self.all
    DIRECTORY.glob("*.sql").sort.map { |path| new(path) }
  end

  def initialize(path)
    @path = Pathname(path)
  end

  def name = path.basename.to_s

  def question = comment_matching(QUESTION)

  def sql
    lines.reject { |line| line.match?(QUESTION) }.join.strip
  end

  # Files here only read. A file with nothing but comments has nothing to run yet.
  def query
    @query ||= begin
      query = Query.new(path.read)
      if RunSqlPolicy.new(query.sql).statements.empty?
        query.refuse("Nothing to run yet: write a SELECT under the -- Q: line.")
      else
        query.run(read_only: true)
      end
    end
  end

  private

  def lines = path.readlines

  def comment_matching(pattern)
    line = lines.find { |l| l.match?(pattern) }
    line&.sub(pattern, "")&.strip
  end
end
