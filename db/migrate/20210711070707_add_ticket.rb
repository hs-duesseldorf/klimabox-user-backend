class AddTicket < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :message
      t.timestamps
    end
  end
end
