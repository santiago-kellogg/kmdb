class QueriesController < ApplicationController
  # The landing page: an empty box for any SQL.
  def new
  end

  # Every file in queries/, run fresh on each refresh.
  def index
    @query_files = QueryFile.all
  end

  # The box on the landing page. Runs one statement that reads or changes rows;
  # refuses structure changes and multi-statement pastes, and says why.
  def create
    @query = Query.new(params[:sql])
    refusal = RunSqlPolicy.new(@query.sql).refusal
    refusal ? @query.refuse(refusal) : @query.run
  end
end
