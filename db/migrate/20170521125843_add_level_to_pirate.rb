# frozen_string_literal: true
# level support
#
# @author Alex Lecoq
# @since 0.0.0
class AddLevelToPirate < ActiveRecord::Migration
  def change
    add_column :pirates, :level, :int
  end
end
