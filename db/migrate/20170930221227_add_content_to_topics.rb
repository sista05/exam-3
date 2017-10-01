class AddContentToTopics < ActiveRecord::Migration
  def up
    add_column :topics, :content,  :text
  end
end
