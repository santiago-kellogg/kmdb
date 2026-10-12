# bin/load rebuilds the database by swapping in a new file, but a running
# server keeps reading the old one it already has open. Before each request,
# notice a replaced file and reconnect to the new one.
module FollowsDatabaseFile
  extend ActiveSupport::Concern

  included do
    before_action :reconnect_if_database_replaced
  end

  private

  def reconnect_if_database_replaced
    file_id = database_file_id
    return if file_id == FollowsDatabaseFile.connected_file_id

    ActiveRecord::Base.connection_pool.disconnect!
    FollowsDatabaseFile.connected_file_id = file_id
  end

  def database_file_id
    path = ActiveRecord::Base.connection_db_config.database
    File.stat(path).ino if File.exist?(path)
  end

  mattr_accessor :connected_file_id
end
