class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shout, null: false, foreign_key: true

      t.timestamps
    end
    #to ensure that the user doesnt give various likes to the same shout
    add_index :likes, [:user_id, :shout_id], unique:true
  end
end
