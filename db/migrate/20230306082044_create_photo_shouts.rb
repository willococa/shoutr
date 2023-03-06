class CreatePhotoShouts < ActiveRecord::Migration[7.0]
  def change
    create_table :photo_shouts do |t|
      t.timestamps
    end
  end
end
