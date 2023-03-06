class MakeShoutsPolymorphic < ActiveRecord::Migration[7.0]
  #in order to make sure this migration runs in the future
  #we have redefined the shout models below so if we add some
  #callbacks or validations to the regular models they..
  #won't break this migration. nice trick
  class Shout < ApplicationRecord
    #this association needs to exists in order for reversible.down to work below
    belongs_to :content, polymorphic: true
  end
  class TextShout < ApplicationRecord; end

  def change
    change_table(:shouts) do |t|
      t.string :content_type
      t.integer :content_id
      t.index [:content_type, :content_id]
    end
    #reversible will make sure that the next change is... wel reversible
    reversible do |dir|
      #protect from the shout having some incorrect cached columns
      Shout.reset_column_information            
      Shout.find_each do|shout|
         dir.up do 
          text_shout = TextShout.create(body: shout.body)
          shout.update(content_id: text_shout.id, content_type: "TextShout")
        end
        dir.down do
          shout.update(body: shout.content.body)
          shout.content.destroy
        end
      end
    end
    remove_column :shouts, :body, :string
  end
end
