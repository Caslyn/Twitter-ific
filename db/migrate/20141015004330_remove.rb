class Remove < ActiveRecord::Migration
  def change
  	remove_column :relationships, :integer
  end
end
