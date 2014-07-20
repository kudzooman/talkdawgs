class AddImagesToPost < ActiveRecord::Migration
  def change
    add_column :posts, :images, :string
  end
end
