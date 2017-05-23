# frozen_string_literal: true
# no need for picpath if we use gravatar
#
# @author Alex Lecoq
# @since 0.0.0
class RemovePicPathFromPirates < ActiveRecord::Migration
  def change
    remove_column :pirates, :picPath, :string
  end
end
