# frozen_string_literal: true

class RemovePicPathFromPirates < ActiveRecord::Migration
  def change
    remove_column :pirates, :picPath, :string
  end
end
