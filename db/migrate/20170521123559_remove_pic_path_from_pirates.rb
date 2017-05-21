class RemovePicPathFromPirates < ActiveRecord::Migration
  def change
    remove_column :pirates, :picPath, :string
  end
end
