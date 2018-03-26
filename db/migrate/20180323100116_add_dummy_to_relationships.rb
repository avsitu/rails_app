class AddDummyToRelationships < ActiveRecord::Migration[5.1]
  def change
    add_column :relationships, :content, :string
  end
end
