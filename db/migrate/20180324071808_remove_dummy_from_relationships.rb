class RemoveDummyFromRelationships < ActiveRecord::Migration[5.1]
  def change
    remove_column :relationships, :content
  end
end
