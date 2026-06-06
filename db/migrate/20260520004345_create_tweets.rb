class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.string :place
      t.string :title
      t.integer :people
      t.integer :budget
      t.string :genre

      t.timestamps
    end
  end
end
