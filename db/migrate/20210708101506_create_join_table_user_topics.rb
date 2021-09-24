class CreateJoinTableUserTopics < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :topics do |t|
    end
  end
end
