class Change < ActiveRecord::Migration
  def change
  	change_column :relationships, :followed_id, 
  	'integer USING CAST(followed_id AS integer)'
  end
end
