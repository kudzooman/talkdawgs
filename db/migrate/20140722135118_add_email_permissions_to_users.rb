class AddEmailPermissionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_favorites, :boolean
  end
end
